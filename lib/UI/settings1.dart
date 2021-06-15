import 'dart:developer';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sleepmohapp/core/preference.dart';
/**
 * Author: Damodar Lohani
 * profile: https://github.com/lohanidamodar
  */
import 'dart:io';

import 'package:sleepmohapp/core/util.dart';
import 'package:sleepmohapp/core/global.dart' as globals;
import 'package:flutter/material.dart';
import 'package:sleepmohapp/core/assets.dart';
import 'package:sleepmohapp/DataSample/UserMod.dart';

import '../core/LocaleHelper.dart';
import '../core/localizations.dart';
import 'B1_Home/B1_Home_Screen/editProfile.dart';
import 'IntroApps/Login.dart';
import 'package:sleepmohapp/core/preference.dart';
import 'package:sleepmohapp/UI/Bottom_Nav_Bar/bottomNavBar.dart';

class SettingsOnePage extends StatefulWidget {
 // static final String path = "lib/src/pages/settings/settings1.dart";

  @override
  _SettingsOnePageState createState() => _SettingsOnePageState();
}
var compteU;
enum Langue { fran, angla }
class _SettingsOnePageState extends State<SettingsOnePage> {
  bool _dark;
  Langue _valLangue = Langue.fran;
 
 final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _dark = false;
    setState(() {
    compteU = false;
  
        if (globals.userinfos != null) {
          compteU = true;
        }else{
           compteU = false;
  
        }
});
    initSaveData();
  }
void initSaveData () async {
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
setState(() {
  compteU = false;

  if (globals.userinfos != null) {
          compteU = true;
        }
});

}
  Brightness _getBrightness() {
     return _dark ? Brightness.dark : Brightness.light;
  }

  @override
  Widget build(BuildContext context) {
bool _isChecked = true;

 String dropdownslangue = AppLocalizations.of(context).slang;
  List<String> _items1 = <String>[
    AppLocalizations.of(context).slang,
    AppLocalizations.of(context).fr,
    AppLocalizations.of(context).en,
  ];

    return Theme(
      isMaterialAppTheme: true,
      data: ThemeData(
        brightness: _getBrightness(),
      ),
      child: Scaffold(
        backgroundColor: _dark ? null : Colors.grey.shade100,
        appBar: AppBar(
      backgroundColor: Colors.white,
        title: Text(AppLocalizations.of(context).sett,
            style: TextStyle(
                fontWeight: FontWeight.w900,
                fontFamily: "Gotik",
                fontSize: 25.0,
                color: Colors.black)),
        centerTitle: false,
        actions: <Widget>[
        compteU == true
            ?
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(PageRouteBuilder(
                    pageBuilder: (_, __, ___) => new editProfile(
                      userinfo: globals.userinfos,
                    ),
                    transitionDuration: Duration(milliseconds: 600),
                    transitionsBuilder:
                        (_, Animation<double> animation, __, Widget child) {
                      return Opacity(
                        opacity: animation.value,
                        child: child,
                      );
                    }));
              },
              child: Hero(
                tag: 'hero-tag-profile',
                child: Container(
                  height: 45.0,
                  width: 45.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(
                        "https://www.sleepmoh.com/manager/avatars/" + globals.userinfos.avatar
                       ),
                      )),
                ),
              ),
            ),
          )
          :
          Padding(
                  padding: const EdgeInsets.only(right: 20.0),
            child: InkWell(
              onTap: () {
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
              child: Hero(
                tag: 'hero-tag-profile',
                child: Container(
                  height: 45.0,
                  width: 45.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      image: DecorationImage(
                        image: AssetImage(
                          "assets/image/compteins.png",
                        ),
                      )),
                ),
              ),
            ),
          )
        ],
        brightness: Brightness.light,
        elevation: 0.0,
      ),
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                
                   compteU == true
            ?
           
                             Card(
                    elevation: 8.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    color: PaypalColors.LightBlue,
                    child: ListTile(
                      onTap: () {
                         Navigator.of(context).push(PageRouteBuilder(
                    pageBuilder: (_, __, ___) => new editProfile(
                      userinfo: globals.userinfos,
                    ),
                    transitionDuration: Duration(milliseconds: 600),
                    transitionsBuilder:
                        (_, Animation<double> animation, __, Widget child) {
                      return Opacity(
                        opacity: animation.value,
                        child: child,
                      );
                    }));
                      },
                      title: Text(
                        globals.userinfos.nom,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      leading: CircleAvatar(
                        backgroundImage: CachedNetworkImageProvider("https://www.sleepmoh.com/manager/avatars/" + globals.userinfos.avatar),
                      ),
                      trailing: Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                    ),
                  )
                  :
                  Card(
                    elevation: 8.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    color: PaypalColors.LightBlue,
                    child: ListTile(
                      onTap: () {
                        //open edit profile
                      },
                      title: Text(
                        AppLocalizations.of(context).profu,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      leading: CircleAvatar(
                        backgroundImage: CachedNetworkImageProvider('https://www.sleepmoh.com/manager/avatars/pro1.jpg'),
                      ),
                      trailing: Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Card(
                    elevation: 4.0,
                    margin: const EdgeInsets.fromLTRB(32.0, 8.0, 32.0, 16.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Column(
                      children: <Widget>[
                  
                        ListTile(
                          leading: Icon(
                            Icons.language,
                            color: PaypalColors.LightBlue,
                          ),
                          title: Text( AppLocalizations.of(context).lan),
                          trailing: Icon(Icons.keyboard_arrow_right),
                          onTap: () {

                            //_displayDialog(context);

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
                          height: 120.0,
                          child:  Column(
                        children: <Widget>[
                          ListTile(
                            title: Text(AppLocalizations.of(context).fr),
                            leading: Radio(
                              value: Langue.fran,
                              groupValue: _valLangue,
                              onChanged: (Langue value) {
                                setState(() {
                                  _valLangue = value;
                               //   log("cool1");
                                  helper.onLocaleChanged(new Locale("fr"));
                                  
                                  SharedPreferencesClass.save('langue', 'fr');
                                  Navigator.of(context).pop();
                                });
                              },
                            ),
                          ),
                          ListTile(
                            title: Text(AppLocalizations.of(context).en),
                            leading: Radio(
                              value: Langue.angla,
                              groupValue: _valLangue,
                              onChanged: (Langue value) {
                                setState(() {
                                  _valLangue = value;
                               //    log("cool");
                                    helper.onLocaleChanged(new Locale("en"));
                                    SharedPreferencesClass.save('langue', 'en');
                                  Navigator.of(context).pop();
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                        ),
                        
                      ],
                    )
                    );});
                           },
                        ),
                   _buildDivider(),
                        ListTile(
                          leading: Icon(
                            Icons.lock_outline,
                            color: PaypalColors.LightBlue,
                          ),
                          title: Text( AppLocalizations.of(context).chan),
                          trailing: Icon(Icons.keyboard_arrow_right),
                          onTap: () {
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
                                child: TextFormField(),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: TextFormField(),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: RaisedButton(
                                  child: Text("Submitß"),
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
                    );});
                
                          },
                        ),
                       
                       
                      ],
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    AppLocalizations.of(context).nos,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: PaypalColors.LightBlue,
                    ),
                  ),
                  SwitchListTile(
                    activeColor: PaypalColors.LightBlue,
                    contentPadding: const EdgeInsets.all(0),
                    value: true,
                    title: Text( AppLocalizations.of(context).rno),
                    onChanged: (val) {},
                  ),
                  SwitchListTile(
                    activeColor: PaypalColors.LightBlue,
                    contentPadding: const EdgeInsets.all(0),
                    value: false,
                    title: Text( AppLocalizations.of(context).nee),
                    onChanged: null,
                  ),
                  SwitchListTile(
                    activeColor: PaypalColors.LightBlue,
                    contentPadding: const EdgeInsets.all(0),
                    value: true,
                    title: Text( AppLocalizations.of(context).off),
                    onChanged: (val) {},
                  ),
                  SwitchListTile(
                    activeColor: PaypalColors.LightBlue,
                    contentPadding: const EdgeInsets.all(0),
                    value: true,
                    title: Text( AppLocalizations.of(context).app),
                    onChanged: null,
                  ),
                  const SizedBox(height: 60.0),
                 
                ],
              ),
            ),
            compteU == true
            ?
              Positioned(
              bottom: 00,
              left: 50,
              right: 50,
              child:   RaisedButton(
                            padding: const EdgeInsets.fromLTRB(50, 8.0, 50, 8.0),
                            textColor: Colors.white,
                            color: PaypalColors.LightBlue,
                            onPressed: (){

                              
                                //setState(() {
                                    
                                  globals.userinfos = null;
                                  //}); 


                                  SharedPreferencesClass.save("userinfos", "");
                                  
                                  
                                  Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(builder: (context) => new bottomNavBar()),
                                  (Route<dynamic> route) => false,
                                );  
            
                            },
                            child: Text('Déconnexion'),
                          ),
            )
            :
            Container(),
          ],
        ),
      ),
    );
  }

  Container _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      width: double.infinity,
      height: 1.0,
      color: Colors.grey.shade400,
    );
  }
  
}
