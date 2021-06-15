import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:international_phone_input/international_phone_input.dart';
import 'package:sleepmohapp/core/localizations.dart';
import 'AppBar_ItemScreen/inboxAppbar.dart';
import 'package:sleepmohapp/DataSample/UserMod.dart';
import 'AppBar_ItemScreen/notificationAppbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'travelGuideMessage.dart';
import 'package:sleepmohapp/UI/IntroApps/Login.dart';
import 'Chatting/chatting.dart';
import 'package:sleepmohapp/core/httpreq.dart';
import 'package:sleepmohapp/core/preference.dart';

class noMessage extends StatefulWidget {
  noMessage({Key key}) : super(key: key);

  @override
  _noMessageState createState() => _noMessageState();
}

  bool _autoValidate = false;
var userinfos = new List<UserMod>(); 
var compteU;

class _noMessageState extends State<noMessage> {
  @override
  final _formKey = GlobalKey<FormState>();

  String phoneNumber = '';
String _name;
String _message;
String confirmedNumber = '';
  String phoneIsoCode = "+237";
  bool visible = false;

   void onPhoneNumberChange(
      String number, String internationalizedPhoneNumber, String isoCode) {
   // print(number);
    setState(() {
      phoneNumber = number;
      phoneIsoCode = isoCode;      
      confirmedNumber = internationalizedPhoneNumber;
    });
  }

  onValidPhoneNumber(
      String number, String internationalizedPhoneNumber, String isoCode) {
    setState(() {
      visible = true;
      confirmedNumber = internationalizedPhoneNumber;
      phoneIsoCode = isoCode;
    });
  }

  @override
  void initState() {
    super.initState();
    
      initSaveData();

 }

 void initSaveData () async {

    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
compteU = false;

   await SharedPreferencesClass.restoreuser("userinfos").then((value) {
   setState(() {
     if(value != ""){
      compteU = true;
      Iterable list0 = jsonDecode(value);
        userinfos = list0.map((model) => UserMod.fromJson(model)).toList();
    // log('user_value :' + value);
     }
     
   });
     });
     
 }

  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
     /* appBar: AppBar(
        elevation: 0.0,
        title: Text(
          "Message",
          style: TextStyle(
              fontFamily: "Sofia",
              fontWeight: FontWeight.w800,
              fontSize: 29.5,
              wordSpacing: 0.1),
        ),
        actions: <Widget>[
          InkWell(
              onTap: () {
                Navigator.of(context).push(PageRouteBuilder(
                    pageBuilder: (_, __, ___) => new inboxAppbar()));
              },
              child: Image.asset(
                "assets/image/icon/box.png",
                height: 21.0,
                width: 21.0,
              )),
          SizedBox(
            width: 20.0,
          ),
          InkWell(
              onTap: () {
                Navigator.of(context).push(PageRouteBuilder(
                    pageBuilder: (_, __, ___) => new notificationAppbar()));
              },
              child: Image.asset(
                "assets/image/icon/notification.png",
                height: 21.0,
                width: 21.0,
              )),
          SizedBox(
            width: 15.0,
          ),
        ],
      ),*/
      body: Stack(
        children: <Widget>[
          Image(
            image:CachedNetworkImageProvider('https://sleepmoh.com/flutterimg/destination1.jpg'),
            height: _height,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 240.0,
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                      blurRadius: 20.0, color: Colors.black12.withOpacity(0.08))
                ]),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                      child: Text(
                        AppLocalizations.of(context).nomess,
                        style: TextStyle(
                            fontFamily: "Sofia",
                            fontSize: 21.0,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Text(
                        AppLocalizations.of(context).nomesdesc,
                        style: TextStyle(
                            color: Colors.black26, fontFamily: "Sofia"),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    
                  
                    SizedBox(
                      height: 20.0,
                    ),
                  InkWell(
                      onTap: () {
                     /*   Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (_, __, ___) => new travelGuide(
                              title: "List conversation",
                            )));*/
            compteU ?     
                     showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Stack(
                      overflow: Overflow.visible,
                      children: <Widget>[
                        Positioned(
                          right: -40.0,
                          top: -40.0,
                          child: InkResponse(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: CircleAvatar(
                              child: Icon(Icons.close),
                              backgroundColor: Colors.blue[300],
                            ),
                          ),
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                             
                               Padding(
                                padding: EdgeInsets.all(8.0),
                                child: TextFormField(
                                  validator: validateName,
                                   keyboardType: TextInputType.multiline,
                                    maxLines: 3,
                                      decoration: InputDecoration(
                                          hintText: "Message",
                                          icon: Icon(
                                            Icons.mail,
                                            color: Colors.black12,
                                          ),
                                          hintStyle: TextStyle(
                                              color: Colors.grey,
                                              fontFamily: "sofia")),
                                              onSaved: (String val) {
                                          _message = val;
                                        },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: RaisedButton(
                                  child: Text("Envoyer"),
                                  color: Colors.blue[400],
                                  textColor: Colors.white,
                                  onPressed: () {
                                    if (_formKey.currentState.validate()) {
                                      _formKey.currentState.save();

print("userinfos[0].avatar : "+userinfos[0].telephone);
                                       HttpPostRequest.create_con_request(userinfos[0].login, _message, userinfos[0].nom, userinfos[0].avatar, "", "tchat_admin", "").then((String result){
                                                        if(result == "error"){
                                                                    //  errorTransaction();
                                                                    }else{
                                                                            if(result == "exit"){
                                                                          //  compteExit();
                                                                          }else{
                                                                          // log('result'+ result);
                                                                            
                                                                          //pour le compte existant  widget.compteE();
                                                                         // sucessTansaction();


                                                                          Navigator.of(context).push(PageRouteBuilder(
                                                                          pageBuilder: (_, __, ___) => new chatting(
                                                                                name: userinfos[0].nom,
                                                                                nom: userinfos[0].nom,
                                                                                messages: result,
                                                                              )));
                                                                          }
                                                                    }
                                                        });
                                    }else {
//    If all data are not valid then start auto validation.
                                      setState(() {
                                        _autoValidate = true;
                                      });
                                    } 
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                    );})

                    :
                     showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Stack(
                      
                      overflow: Overflow.visible,
                      children: <Widget>[
                        Positioned(
                          right: -40.0,
                          top: -40.0,
                          child: InkResponse(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: CircleAvatar(
                              child: Icon(Icons.close),
                              backgroundColor: Colors.blue[300],
                            ),
                          ),
                        ),
                     Container(
                height: 240.0,
                padding: EdgeInsets.all(0.0),
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                      blurRadius: 20.0, color: Colors.black12.withOpacity(0.08))
                ]),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                      child: Text(
                        "Veuillez vous Connecter",
                        style: TextStyle(
                            fontFamily: "Sofia",
                            fontSize: 21.0,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Text(
                        "En vous connectectant nous pourions vous identifier a traver votre nom, votre numéro de téléphone et nous pourrions vous guider dans tous vos besoins sur SleepMoh",
                        style: TextStyle(
                            color: Colors.black26, fontFamily: "Sofia"),
                        textAlign: TextAlign.center,
                      ),
                    ),
                     Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: RaisedButton(
                                  child: Text("Continuer"),
                                  color: Colors.blue[400],
                                  textColor: Colors.white,
                                  onPressed: () {
                        Navigator.of(context).push(PageRouteBuilder(
                                            pageBuilder: (_, __, ___) => new Login(),
                                            transitionDuration: Duration(milliseconds: 600),
                                            transitionsBuilder:
                                                (_, Animation<double> animation, __, Widget child) {
                                              return Opacity(
                                                opacity: animation.value,
                                                child: child,
                                              );
                                            }));
                                  },
                                ),
                              )
                  ],
                  ),
                  ),
                      ],
                    )
                    );});

                      },
                      child: Container(
                        height: 45.0,
                        width: 180.0,
                        color: Colors.blue[400],
                        child: Center(
                          child: Text(
                            "Nous écrire",
                            style: TextStyle(
                                color: Colors.white, fontFamily: "Sofia"),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
    
  }

   String validateName(String value) {
    _name = value;
    if (value.length < 3)
      return AppLocalizations.of(context).nameer;
    else
      return null;
  }

   showDialogzzz(context) {
                  return AlertDialog(
                    content: Stack(
                      overflow: Overflow.visible,
                      children: <Widget>[
                        Positioned(
                          right: -40.0,
                          top: -40.0,
                          child: InkResponse(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: CircleAvatar(
                              child: Icon(Icons.close),
                              backgroundColor: Colors.blue[300],
                            ),
                          ),
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: InternationalPhoneInput(
                                    onPhoneNumberChange: onPhoneNumberChange,
                                    initialSelection: phoneIsoCode,
                                    errorText: AppLocalizations.of(context).tel_error,
                                    hintText: AppLocalizations.of(context).tel,
                                    showCountryCodes: false,
                                    showCountryFlags: true,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: TextFormField(
                                  validator: validateName,
                                      decoration: InputDecoration(
                                          hintText: AppLocalizations.of(context).lblname,
                                          icon: Icon(
                                            Icons.person,
                                            color: Colors.black12,
                                          ),
                                          hintStyle: TextStyle(
                                              color: Colors.grey,
                                              fontFamily: "sofia")),
                                              onSaved: (String val) {
                                          _name = val;
                                        },
                                ),
                              ),
                               Padding(
                                padding: EdgeInsets.all(8.0),
                                child: TextFormField(
                                  validator: validateName,
                                   keyboardType: TextInputType.multiline,
                                    maxLines: 3,
                                      decoration: InputDecoration(
                                          hintText: "Message",
                                          icon: Icon(
                                            Icons.mail,
                                            color: Colors.black12,
                                          ),
                                          hintStyle: TextStyle(
                                              color: Colors.grey,
                                              fontFamily: "sofia")),
                                              onSaved: (String val) {
                                          _message = val;
                                        },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: RaisedButton(
                                  child: Text("Envoyer"),
                                  color: Colors.blue[400],
                                  textColor: Colors.white,
                                  onPressed: () {
                                    if (_formKey.currentState.validate()) {
                                      _formKey.currentState.save();
                                    }
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                    );
                    }

                     showDialog1(context) {
                  return AlertDialog(
                    content: Stack(
                      overflow: Overflow.visible,
                      children: <Widget>[
                        Positioned(
                          right: -40.0,
                          top: -40.0,
                          child: InkResponse(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: CircleAvatar(
                              child: Icon(Icons.close),
                              backgroundColor: Colors.blue[300],
                            ),
                          ),
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                             Padding(
                                padding: EdgeInsets.all(8.0),
                                child: TextFormField(
                                  validator: validateName,
                                   keyboardType: TextInputType.multiline,
                                    maxLines: 3,
                                      decoration: InputDecoration(
                                          hintText: "Message",
                                          icon: Icon(
                                            Icons.mail,
                                            color: Colors.black12,
                                          ),
                                          hintStyle: TextStyle(
                                              color: Colors.grey,
                                              fontFamily: "sofia")),
                                              onSaved: (String val) {
                                          _message = val;
                                        },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: RaisedButton(
                                  child: Text("Envoyer"),
                                  color: Colors.blue[400],
                                  textColor: Colors.white,
                                  onPressed: () {
                                    if (_formKey.currentState.validate()) {
                                      _formKey.currentState.save();
                                    }
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                    );
                    }


}
