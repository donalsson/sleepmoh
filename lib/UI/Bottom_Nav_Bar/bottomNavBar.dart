import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:sleepmohapp/DataSample/ConversMod.dart';
import 'package:flutter/material.dart';
import 'package:sleepmohapp/UI/B1_Home/B1_Home_Screen/B1_Home_Screen.dart';
import 'package:sleepmohapp/UI/B2_Message/B2_MessageScreen.dart';
import 'package:sleepmohapp/UI/B2_Message/travelGuideMessage.dart';
import 'package:sleepmohapp/UI/B3_Trips/B3_TripScreen.dart';
import 'package:sleepmohapp/UI/B3_Trips/exploreTrip.dart';
import 'package:sleepmohapp/UI/B4_Favorite/B4_FavoriteScreen.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';

import 'package:sleepmohapp/core/httpreq.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sleepmohapp/UI/settings1.dart';
import 'package:sleepmohapp/UI/IntroApps/addpropoerti.dart';
import 'package:sleepmohapp/core/preference.dart';
import 'package:sleepmohapp/core/util.dart';
import 'package:bottom_navigation_badge/bottom_navigation_badge.dart';
import 'package:sleepmohapp/DataSample/ConversMod.dart';
import 'package:sleepmohapp/DataSample/message_cloud.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:sleepmohapp/DataSample/UserMod.dart';
import 'package:sleepmohapp/UI/IntroApps/listuserpro.dart';

class bottomNavBar extends StatefulWidget {
  bottomNavBar();
  _bottomNavBarState createState() => _bottomNavBarState();
}

var compteU;
var userconvers = new List<ConversMod>();
var userinfos = new List<UserMod>();

class _bottomNavBarState extends State<bottomNavBar>
    with SingleTickerProviderStateMixin {
  bool isOpened = false;

  Animation<Color> _buttonColor;
  Animation<double> _animateIcon;
  Animation<double> _translateButton;
  Curve _curve = Curves.easeOut;
  double _fabHeight = 56.0;
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(
        icon: Icon(
          IconData(0xe900, fontFamily: 'home'),
          color: PaypalColors.Primary,
        ),
        title: Text("Home")),
    BottomNavigationBarItem(
        icon: Icon(
          IconData(0xe900, fontFamily: 'message'),
          color: PaypalColors.Primary,
        ),
        title: Text("Notifications")),
    BottomNavigationBarItem(
        icon: Icon(
          IconData(0xe900, fontFamily: 'trip'),
          color: PaypalColors.Primary,
        ),
        title: Text("Notifications")),
    BottomNavigationBarItem(
        icon: Icon(
          IconData(0xe900, fontFamily: 'hearth'),
          color: PaypalColors.Primary,
        ),
        title: Text("Notifications")),
    BottomNavigationBarItem(
        icon: Icon(
          IconData(0xe900, fontFamily: 'profile'),
          color: PaypalColors.Primary,
        ),
        title: Text("Profile"))
  ];
  BottomNavigationBadge badger = new BottomNavigationBadge(
      backgroundColor: Colors.red,
      badgeShape: BottomNavigationBadgeShape.circle,
      textColor: Colors.white,
      position: BottomNavigationBadgePosition.topRight,
      textSize: 8);

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final List<Message> messages = [];

  int currentTab = 0;
  int i = 0;
  List<Widget> screens = [];
  Animation<double> _animation;
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    compteU = false;
    initSaveData();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );

    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        await SharedPreferencesClass.restoreuser("userinfos").then((value) {
          setState(() {
            if (value != "") {
              compteU = true;
            }
          });
        });

        final notification = message['notification'];
        setState(() {
          FlutterRingtonePlayer.playNotification();
          i = i + 1;
          HttpPostRequest.getAllConvers(userinfos[0].login)
              .then((List<ConversMod> result) {
            //  print(result);
          });
          items = badger.setBadge(items, i.toString(), 1);

          messages.add(Message(
              title: notification['title'], body: notification['body']));
        });
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");

        final notification = message['data'];
        setState(() {
          messages.add(Message(
            title: '${notification['title']}',
            body: '${notification['body']}',
          ));
        });
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );

    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
  }

  void initSaveData() async {
    await SharedPreferencesClass.restoreuser("userinfos").then((value) {
      setState(() {
        if (value != "") {
          compteU = true;
          Iterable list0 = jsonDecode(value);
          userinfos = list0.map((model) => UserMod.fromJson(model)).toList();
        }
      });
    });

    await SharedPreferencesClass.restoreuser("listConversation").then((value) {
      //log('listConversation :' + value);
      if (value != "" && compteU == true) {
        Iterable list0 = jsonDecode(value);
        userconvers = list0.map((model) => ConversMod.fromJson(model)).toList();
        // log('user_value :' + value);

        setState(() {
          screens = [
            Home(),
            travelGuide(),
            exploreTrip(),
            recommendation(),
            SettingsOnePage()
          ];
        });
      } else {
        setState(() {
          screens = [
            Home(),
            noMessage(),
            exploreTrip(),
            recommendation(),
            SettingsOnePage()
          ];
        });
      }
    });
  }

  Widget currentScreen = Home();

  final PageStorageBucket bucket = PageStorageBucket();
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: PageStorage(child: currentScreen, bucket: bucket),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentTab,
          iconSize: 15.0,
          elevation: 0.0,
          onTap: (i) {
            setState(() {
              currentTab = i;
              currentScreen = screens[i];
            });
          },
          items: items,
        ),
        floatingActionButtonLocation:
            compteU == true ? FloatingActionButtonLocation.endFloat : null,
        floatingActionButton: compteU == true
            ? FloatingActionBubble(
                // Menu items
                items: <Bubble>[
                  // Floating action menu item
                  Bubble(
                    title: "Ajouter",
                    iconColor: Colors.white,
                    bubbleColor: Colors.blue,
                    icon: Icons.add,
                    titleStyle: TextStyle(fontSize: 16, color: Colors.white),
                    onPress: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  Addpropertie(userinfos[0])));
                      _animationController.reverse();
                    },
                  ),
                  // Floating action menu item
                  Bubble(
                    title: "Mes Ajouts",
                    iconColor: Colors.white,
                    bubbleColor: Colors.blue,
                    icon: Icons.library_books,
                    titleStyle: TextStyle(fontSize: 16, color: Colors.white),
                    onPress: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  Listprouser(userinfos[0])));
                      _animationController.reverse();
                    },
                  ),
                  //Floating action menu item
                  /*  Bubble(
                    title: "Mes Réservations",
                    iconColor: Colors.white,
                    bubbleColor: Colors.blue,
                    icon: Icons.home,
                    titleStyle: TextStyle(fontSize: 16, color: Colors.white),
                    onPress: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (BuildContext context) => Home()));
                      _animationController.reverse();
                    },
                  ),*/
                ],

                // animation controller
                animation: _animation,

                // On pressed change animation state
                onPress: () => _animationController.isCompleted
                    ? _animationController.reverse()
                    : _animationController.forward(),

                // Floating Action button Icon color
                iconColor: Colors.blue,

                // Flaoting Action button Icon
                iconData: Icons.ac_unit,
                backGroundColor: Colors.white,
              )
            : null);
  }
}
