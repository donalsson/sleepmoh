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
import 'package:badges/badges.dart';
import 'package:sleepmohapp/core/httpreq.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sleepmohapp/UI/settings1.dart';
import 'package:sleepmohapp/UI/IntroApps/addpropoerti.dart';
import 'package:sleepmohapp/core/preference.dart';
import 'package:sleepmohapp/core/util.dart';
import 'package:sleepmohapp/core/global.dart' as globals;
import 'package:bottom_navigation_badge/bottom_navigation_badge.dart';
import 'package:sleepmohapp/DataSample/ConversMod.dart';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:sleepmohapp/DataSample/message_cloud.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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
 AudioCache audioCache = AudioCache();
  Animation<Color> _buttonColor;
  Animation<double> _animateIcon;
  Animation<double> _translateButton;
  Curve _curve = Curves.easeOut;
  double _fabHeight = 56.0;
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  
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
  int position = 0;
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
       // playLocalAsset();
        print("onMessage: $message");
        print("popo"+position.toString());
     
     
       if(position != 1){
         setState(() {
            globals.countnotif = globals.countnotif + 1;
         });
               await SharedPreferencesClass.save("notifnot", globals.countnotif);
          }
     
          i = i + 1;
          HttpPostRequest.getAllConvers(globals.userinfos.login)
              .then((List<ConversMod> result) {
          setState(() {   
            print('rere');       
            globals.converts = result;
            });
          });
          
       

       

        //  items = badger.setBadge(items, i.toString(), 1);

     /*
        final notification = message['notification'];
          messages.add(Message(
              title: notification['title'], body: notification['body']));*/
        
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

 Future<AudioPlayer> playLocalAsset() async {
         
    audioCache.play('notif.mp3');
  }

  void initSaveData() async {

     if (globals.userinfos != null) {
          compteU = true;
        }

    await SharedPreferencesClass.restoreuser("listConversation").then((value) {
      log('listConversation :' + value);
      if (value != "" && value != "[]" && compteU == true) {
        Iterable list0 = jsonDecode(value);
        userconvers = list0.map((model) => ConversMod.fromJson(model)).toList();
        setState(() {          
        globals.converts = userconvers;
        });
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
  /*
  http://tptv.cz/get.php?username=AD24719F233133D&password=BjeGsdPEXk&type=m3u_plus&output=mpegts
http://tptv.cz/get.php?username=C07ADAD27D71&password=244A9C4C8D42&type=m3u_plus&output=mpegts
*/
  Widget currentScreen = Home();

  final PageStorageBucket bucket = PageStorageBucket();
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(
        icon: Icon(
          IconData(0xe900, fontFamily: 'home'),
          color: PaypalColors.Primary,
        ),
        title: Text("Home")),
    BottomNavigationBarItem(
        icon: globals.countnotif == 0 ? Icon(
          IconData(0xe900, fontFamily: 'message'),
          color: PaypalColors.Primary,
        ) : Badge(
           shape: BadgeShape.square,
          borderRadius: BorderRadius.circular(5),
          position: BadgePosition.topEnd(top: -12, end: -20),
          padding: EdgeInsets.all(3),
        
          badgeContent: Text(
            globals.countnotif.toString(),
            style: TextStyle(
                color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
          ),
          child: Icon(
          IconData(0xe900, fontFamily: 'message'),
          color: PaypalColors.Primary,
        ),
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
  /*
  Votre nom d'utilisateur est : franky4ekem@gmail.com

Votre mot de passe est : 53Q3tWYz
  
   */
    return Scaffold(
        backgroundColor: Colors.white,
        body: PageStorage(child: currentScreen, bucket: bucket),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentTab,
          iconSize: 17.0,
          unselectedFontSize: 17,
          selectedFontSize: 17,
          showUnselectedLabels: false,
          showSelectedLabels: false,
          elevation: 0.0,
          onTap: (i) {

            setState(() {
              position = i;
            });

            if(i == 1){
              globals.countnotif = 0;
            }
            

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
                                  Addpropertie(globals.userinfos)));
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
                                  Listprouser(globals.userinfos)));
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
