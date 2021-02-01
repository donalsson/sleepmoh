import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sleepmohapp/core/httpreq.dart';
import 'package:sleepmohapp/DataSample/UserMod.dart';
import 'package:intl/intl.dart';

import 'package:sleepmohapp/DataSample/message_cloud.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:sleepmohapp/core/preference.dart';
import 'package:sleepmohapp/DataSample/MessageTchaMod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shared_preferences/shared_preferences.dart';

class chatting extends StatefulWidget {
  String name, nom, photoProfile, messages, idconvers, idbien, typeb;
  UserMod userinfos;
  chatting(
      {this.name,
      this.nom,
      this.userinfos,
      this.messages,
      this.photoProfile,
      this.idconvers,
      this.idbien,
      this.typeb});

  _chattingState createState() => _chattingState();
}

class _chattingState extends State<chatting> with TickerProviderStateMixin {
  var _messagesdata = new List<MessageTchaMod>();
  final List<Msg> _messages = <Msg>[];
  final TextEditingController _textController = new TextEditingController();
  bool _isWriting = true;

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
    log("widget.name");
    print(widget.name);
    log("tellll");
    print(widget.userinfos.telephone);
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
        /*   await SharedPreferencesClass.restoreuser("userinfos").then((value) {
          setState(() {
            if (value != "") {
//compteU = true;

            }
          });
        });*/

        final notification = message['notification'];
        setState(() {
          /*   FlutterRingtonePlayer.playNotification();
          i = i + 1;
           HttpPostRequest.getAllConvers(userinfos[0].login).then((List<ConversMod> result){
        //  print(result);
          
              });
          items = badger.setBadge(items, i.toString(), 1);
          */
          DateTime now = DateTime.now();
          String formattedDate =
              DateFormat('kk:mm:ss \n EEE d MMM').format(now);

          Msg msg = new Msg(
            txt: notification['body'],
            type: notification['title'],
            type1: widget.userinfos.login,
            heure: formattedDate,
            animationController: new AnimationController(
                vsync: this, duration: new Duration(milliseconds: 800)),
          );
          // if(widget.name == )
          setState(() {
            _messages.insert(0, msg);
          });
          msg.animationController.forward();
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
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();

    await SharedPreferencesClass.restoreuser("listMessages").then((value) {
      setState(() {
        //  log("vall" + value);
        if (value != "") {
//log(value);
          Iterable list0 = jsonDecode(value);
          _messagesdata =
              list0.map((model) => MessageTchaMod.fromJson(model)).toList();
          _messagesdata = _messagesdata
              .where((element) => element.messagec == widget.idconvers)
              .toList();
          /*Comparator<MessageTchaMod> sortById = (a, b) => a.idm.compareTo(b.idm);
_messagesdata.sort(sortById);*/
          int i = 0;
          while (i < _messagesdata.length) {
            log(_messagesdata[i].iduser);

            setState(() {
              _isWriting = false;
            });
            Msg msg = new Msg(
              txt: _messagesdata[i].message,
              type: _messagesdata[i].iduser,
              type1: widget.userinfos.login,
              heure: _messagesdata[i].heuremessage,
              animationController: new AnimationController(
                  vsync: this, duration: new Duration(milliseconds: 800)),
            );
            setState(() {
              _messages.insert(0, msg);
            });
            msg.animationController.forward();
            i++;
          }
        }
      });
    });
  }

/*




SingleChildScrollView(
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 20.0,
            ),
            _item,
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, bottom: 0.0),
              child: Text("Liste des conversations",
                  style: TextStyle(
                      fontFamily: "Sofia",
                      fontWeight: FontWeight.w300,
                      fontSize: 17.5,
                      color: Colors.black45)),
            ),
            ListView.builder(              
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                primary: false,
                itemBuilder: (ctx, index) {
                  return messageList(image: userconvers[index].taille, name: userconvers[index].msgdis, time: userconvers[index].surdis);
                },
                itemCount: userconvers.length,
              ),
            
          ],
        ),
      ),






*/
  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 80.0),
            child: Container(
              color: Colors.white,
              child: new Column(children: <Widget>[
                new Flexible(
                  child: _messages.length > 0
                      ? Container(
                          child: new ListView.builder(
                            itemBuilder: (_, int index) => _messages[index],
                            itemCount: _messages.length,
                            reverse: true,
                            padding: new EdgeInsets.all(10.0),
                          ),
                        )
                      : NoMessage(),
                ),
                new Container(
                  child: _buildComposer(),
                ),
              ]),
            ),
          ),
          Container(
            height: 85.0,
            width: double.infinity,
            decoration: BoxDecoration(color: Colors.blue[100]),
            child: Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pop(context, true);
                        },
                      ),
                    ),
                    Container(
                      height: 45.0,
                      width: 45.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50.0)),
                          image: DecorationImage(
                            image: CachedNetworkImageProvider(
                                "https://www.sleepmoh.com/manager/avatars/" +
                                    widget.photoProfile),
                          )),
                    ),
                    Text(widget.nom,
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1.1,
                            fontSize: 17.0)),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 225,
                    )
                  ]),
            ),
          )
        ],
      ),
    );
  }

  /// Component for typing text
  Widget _buildComposer() {
    return new IconTheme(
      data: new IconThemeData(
        color: Color(0xFF7F53AC),
      ),
      child: new Container(
          margin: const EdgeInsets.symmetric(horizontal: 9.0),
          child: new Row(
            children: <Widget>[
              /* Icon(
                Icons.add,
                color: Color(0xFF7F53AC),
                size: 27.0,
              ),*/
              new Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 5.0, bottom: 10.0),
                  child: Container(
                    height: 46.0,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 5.0,
                            color: Colors.black12.withOpacity(0.1),
                            spreadRadius: 2.0,
                          )
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 15.0, left: 15.0, right: 15.0),
                      child: new TextField(
                        controller: _textController,
                        onChanged: (String txt) {
                          setState(() {
                            _isWriting = txt.length > 0;
                          });
                        },
                        onSubmitted: _submitMsg,
                        decoration: new InputDecoration.collapsed(
                            hintText: "Enter text",
                            hintStyle: TextStyle(
                                fontFamily: "Sofia",
                                fontSize: 17.1,
                                letterSpacing: 1.5,
                                color: Colors.black26)),
                      ),
                    ),
                  ),
                ),
              ),
              new Container(
                  margin: new EdgeInsets.symmetric(horizontal: 3.0),
                  child: Theme.of(context).platform == TargetPlatform.iOS
                      ? new CupertinoButton(
                          child: Icon(
                            Icons.send,
                            color: Color(0xFF7F53AC),
                          ),
                          // child: new Text("Submit"),
                          onPressed: _isWriting
                              ? () => _submitMsg(_textController.text)
                              : null)
                      : new IconButton(
                          icon: new Icon(
                            Icons.send,
                            color: Color(0xFF7F53AC),
                          ),
                          onPressed: _isWriting
                              ? () => _submitMsg(_textController.text)
                              : null,
                        )),
            ],
          ),
          decoration: Theme.of(context).platform == TargetPlatform.iOS
              ? new BoxDecoration()
              : null),
    );
  }

  void _submitMsg(String txt) {
    _textController.clear();
    setState(() {
      _isWriting = false;
    });
    log("rrrr");

    HttpPostRequest.create_con_request(
            widget.userinfos.login,
            txt,
            widget.userinfos.nom,
            widget.userinfos.avatar,
            widget.idbien,
            widget.name,
            widget.typeb)
        .then((String result) {
      log(result);

      /*if(result == "error"){
                             errorTransaction();
                           }else{
                                  if(result == "exit"){
                                  compteExit();
                                }else{
                                 // log('result'+ result);
                                 // Navigator.pop(context);
                                //pour le compte existant  widget.compteE();
                              // _displayDialog(context, confirmedNumber);
                              
                                 sucessTansaction();

                                   Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(builder: (context) => new bottomNavBar()),
                                  (Route<dynamic> route) => false,
                                );

                                }
                           }*/
    });

    DateTime now = DateTime.now();
    String formattedDate = DateFormat('kk:mm:ss \n EEE d MMM').format(now);

    Msg msg = new Msg(
      txt: txt,
      type: widget.userinfos.login,
      type1: widget.userinfos.login,
      heure: formattedDate,
      animationController: new AnimationController(
          vsync: this, duration: new Duration(milliseconds: 800)),
    );

    setState(() {
      _messages.insert(0, msg);
    });
    msg.animationController.forward();
  }

  @override
  void dispose() {
    for (Msg msg in _messages) {
      msg.animationController.dispose();
    }
    super.dispose();
  }
}

class Msg extends StatelessWidget {
  Msg({this.txt, this.type, this.type1, this.heure, this.animationController});

  final String txt;
  final String type;
  final String type1;
  final String heure;
  final AnimationController animationController;

  @override
  Widget build(BuildContext ctx) {
    return new SizeTransition(
      sizeFactor: new CurvedAnimation(
          parent: animationController, curve: Curves.fastOutSlowIn),
      axisAlignment: 0.0,
      child: new Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            type == type1
                ? new Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(1.0),
                                    bottomLeft: Radius.circular(20.0),
                                    topRight: Radius.circular(20.0),
                                    topLeft: Radius.circular(20.0)),
                                gradient: LinearGradient(colors: [
                                  Color(0xFF647DEE),
                                  Color(0xFF7F53AC)
                                ])),
                            padding: const EdgeInsets.all(10.0),
                            child: new Text(
                              txt,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : new Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(1.0),
                                    bottomLeft: Radius.circular(20.0),
                                    topRight: Radius.circular(20.0),
                                    topLeft: Radius.circular(20.0)),
                                gradient: LinearGradient(
                                    colors: [Colors.red, Color(0xFF7F53AC)])),
                            padding: const EdgeInsets.all(10.0),
                            child: new Text(
                              txt,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

class NoMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      child: ListView(
        children: <Widget>[
          /* Padding(
            padding: const EdgeInsets.only(top: 130.0),
            child: Center(
              child: Opacity(
                  opacity: 0.8,
                  child: Image.asset(
                    "assets/image/illustration/noMessage.png",
                    height: 220.0,
                  )),
            ),
          ),
          */
          SizedBox(height: 25.0),
          Center(
              child: Text(
            "Not Have Message",
            style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 19.5,
                color: Colors.black38,
                fontFamily: "Sofia"),
          ))
        ],
      ),
    ));
  }
}
