import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sleepmohapp/DataSample/UserMod.dart';
import 'package:sleepmohapp/UI/Bottom_Nav_Bar/bottomNavBar.dart';
import 'package:sleepmohapp/core/localizations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:international_phone_input/international_phone_input.dart';
import 'package:connectivity/connectivity.dart';
import 'package:sleepmohapp/core/global.dart' as globals;
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:sleepmohapp/core/httpreq.dart';
import 'package:sleepmohapp/core/util.dart';

class editProfile extends StatefulWidget {
  UserMod userinfo;
  editProfile({Key key, this.userinfo}) : super(key: key);

  @override
  _editProfileState createState() => _editProfileState();
}

class _editProfileState extends State<editProfile> with TickerProviderStateMixin{
  String _date = "16/04/1998";
  String _name = "";
  String _toff = "";
  Future<File> file;
  String status = '';
  String base64Image;
  File tmpFile;
  int i = 0;
  String errMessage = 'Error Uploading Image';
  AnimationController sanimationController;
String phoneNumber = '';
 String _password = '';
 String _password0 = '';
  String _name0;
    bool showAddNote = false;
  bool showPageLoader = false;
  bool showSpinner = false;
  bool _autoValidate = false;
  bool showChecked = false;
  bool showCheckedErrorCompExit = false;
  bool showCheckedErrorInternet = false;
  bool showCheckedError = false;
String confirmedNumber = '';
AnimationController animationController;
  String phoneIsoCode = "+237";
  bool visible = false;
  var tap = 0;
  String _connectionStatus = 'Unknown';
  final Connectivity _connectivity = Connectivity();
final GlobalKey<FormState> _formkey0 = GlobalKey<FormState>();
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

  void initState() {
    sanimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800))
          ..addStatusListener((statuss) {
            if (statuss == AnimationStatus.dismissed) {
              setState(() {
                tap = 0;
              });
            }
          });
      initConnectivity();
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 15));

    animationController.addListener(() {
      if (animationController.status.toString() ==
          'AnimationStatus.completed') {
        setState(() {
          showSpinner = false;
          showCheckedErrorInternet = true;
        });
        Timer(
          Duration(seconds: 3),
          () => setState(() {
                showPageLoader = false;
                showAddNote = false;
                showSpinner = false;
                showCheckedErrorInternet = false;
                animationController.reset();
                //Navigator.of(context).pop();
              }),
        );
      }
    });

    // TODO: implement initState
    super.initState();
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
     // print(e.toString());
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }
//print(result);
    return _updateConnectionStatus(result);
  }
  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
        String wifiName, wifiBSSID, wifiIP;

        try {
          if (!kIsWeb && Platform.isIOS) {
            LocationAuthorizationStatus status =
                await _connectivity.getLocationServiceAuthorization();
            if (status == LocationAuthorizationStatus.notDetermined) {
              status =
                  await _connectivity.requestLocationServiceAuthorization();
            }
            if (status == LocationAuthorizationStatus.authorizedAlways ||
                status == LocationAuthorizationStatus.authorizedWhenInUse) {
              wifiName = await _connectivity.getWifiName();
            } else {
              wifiName = await _connectivity.getWifiName();
            }
          } else {
            wifiName = await _connectivity.getWifiName();
          }
        } on PlatformException catch (e) {
          print(e.toString());
          wifiName = "Failed to get Wifi Name";
        }

        try {
          if (!kIsWeb && Platform.isIOS) {
            LocationAuthorizationStatus status =
                await _connectivity.getLocationServiceAuthorization();
            if (status == LocationAuthorizationStatus.notDetermined) {
              status =
                  await _connectivity.requestLocationServiceAuthorization();
            }
            if (status == LocationAuthorizationStatus.authorizedAlways ||
                status == LocationAuthorizationStatus.authorizedWhenInUse) {
              wifiBSSID = await _connectivity.getWifiBSSID();
            } else {
              wifiBSSID = await _connectivity.getWifiBSSID();
            }
          } else {
            wifiBSSID = await _connectivity.getWifiBSSID();
          }
        } on PlatformException catch (e) {
          print(e.toString());
          wifiBSSID = "Failed to get Wifi BSSID";
        }

        try {
          wifiIP = await _connectivity.getWifiIP();
        } on PlatformException catch (e) {
          print(e.toString());
          wifiIP = "Failed to get Wifi IP";
        }

        setState(() {
          _connectionStatus = '$result\n'
              'Wifi Name: $wifiName\n'
              'Wifi BSSID: $wifiBSSID\n'
              'Wifi IP: $wifiIP\n';
        });
        break;
      case ConnectivityResult.mobile:
      case ConnectivityResult.none:
        setState(() => _connectionStatus = result.toString());
        break;
      default:
        setState(() => _connectionStatus = 'Failed to get connectivity.');
        break;
    }
  }

   setStatus(String message) {
    setState(() {
      status = message;
    });
  }

   void garelypic() {
    
     setState(() {
      file = ImagePicker.pickImage(source: ImageSource.gallery);
    });
    setStatus('');
    Navigator.of(context).pop();
      //  return json.decode(response.body);
    }
     void camerapic() {
    
     setState(() {
      file = ImagePicker.pickImage(source: ImageSource.camera);
    });
    setStatus('');
    Navigator.of(context).pop();
      //  return json.decode(response.body);
    }

  startPayment() {
    setState(() {      
      showPageLoader = true;
      showSpinner = true;
      animationController.forward();
    });
  }

sucessTansaction() {
    
        setState(() {
          showSpinner = false;
          showChecked = true;
        });
        Timer(
          Duration(seconds: 3),
          () => setState(() {
                showPageLoader = false;
                showAddNote = false;
                showSpinner = false;
                showChecked = false;
                showCheckedErrorInternet = false;
                animationController.reset();
                // ouverture de la page d'acceuil

                //Navigator.of(context).pop();
              }),
        );
  }

  compteExit() {
    
        setState(() {
          showSpinner = false;
          showCheckedErrorCompExit = true;
        });
        Timer(
          Duration(seconds: 3),
          () => setState(() {
                showPageLoader = false;
                showAddNote = false;
                showSpinner = false;
                showChecked = false;
                showCheckedErrorCompExit = false;
                showCheckedErrorInternet = false;
                animationController.reset();
                //Navigator.of(context).pop();
              }),
        );
  }

  errorTransaction() {
    
        setState(() {
          showSpinner = false;
          showCheckedError = true;
        });
        Timer(
          Duration(seconds: 3),
          () => setState(() {
                showPageLoader = false;
                showAddNote = false;
                showSpinner = false;
                showChecked = false;
                showCheckedError = false;
                animationController.reset();
                //Navigator.of(context).pop();
              }),
        );
  }

   netErrorTransaction() {
   initConnectivity();
   setState(() {      
      showPageLoader = true;
      showSpinner = true;
      animationController.forward();     
    });
   // log(_connectionStatus);
     if(_connectionStatus == "ConnectivityResult.none"){
         Timer(
        Duration(seconds: 1),
        () => {
          setState(() {
          showSpinner = false;
          showCheckedErrorInternet = true;
        }),
        Timer(
          Duration(seconds: 1),
          () => setState(() {
                showPageLoader = false;
                showAddNote = false;
                showSpinner = false;
                showCheckedErrorInternet = false;
                animationController.reset();
                //Navigator.of(context).pop();
              }),
        )
        }
    );
      }
         
  }

  Widget _showPageLoader() {
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaY: 10,
              sigmaX: 10,
            ),
            child: Container(
              color: Colors.white.withOpacity(0.6),
            ),
          ),
        ),
        showSpinner
            ? Align(
                alignment: Alignment.center,
                child: Image.asset('assets/image/losleep.png', height: 35),
              )
            : Container(),
        showSpinner
            ? Align(
                alignment: Alignment.center,
                child: RotationTransition(
                  turns:
                      Tween(begin: 0.0, end: 2.0).animate(animationController),
                  child: Image.asset('assets/image/load2.gif', height: 150,),
                ),
              )
            : Container(),
        showChecked
            ? Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset('assets/image/checked.png'),
                    SizedBox(height: 25),
                    Material(
                      child: Text(
                        'Transaction Successful',
                        style: TextStyle(
                            fontFamily: "worksans",
                            fontSize: 17,
                            color: PaypalColors.Green),
                      ),
                    ),
                  ],
                ),
              )
            : Container(),
             showCheckedError
            ? Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset('assets/image/error.png'),
                    SizedBox(height: 0),
                    Material(
                      child: Text(
                        "Verifier vos informations",
                        style: TextStyle(
                            fontFamily: "worksans",
                            fontSize: 17,
                            color: PaypalColors.LightBlue),
                      ),
                    ),
                  ],
                ),
              )
            : Container(),
               showCheckedErrorCompExit
            ? Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset('assets/image/error.png'),
                    SizedBox(height: 0),
                    Material(
                      child: Text(
                        "Ce compte existe déja",
                        style: TextStyle(
                            fontFamily: "worksans",
                            fontSize: 17,
                            color: PaypalColors.LightBlue),
                      ),
                    ),
                  ],
                ),
              )
            : Container(),
               showCheckedErrorInternet
            ? Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset('assets/image/error.png'),
                    SizedBox(height: 0),
                    Material(
                      child: Text(
                        "Verrifier votre connexion Internet",
                        style: TextStyle(
                            fontFamily: "worksans",
                            fontSize: 17,
                            color: PaypalColors.LightBlue),
                      ),
                    ),
                  ],
                ),
              )
            : Container(),
      ],
    );
  }
 Widget showImage(nom) {
    return FutureBuilder<File>(
      future: file,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            null != snapshot.data) {
          tmpFile = snapshot.data;
          _toff = "oui";
          base64Image = base64Encode(snapshot.data.readAsBytesSync());
          return Hero(
                          tag: 'hero-profile',
                          child:  Container(
                            height: 130.0,
                            width: 130.0,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50.0)),
                                image: DecorationImage(
                                    image: new FileImage(
                                      snapshot.data
                                    ),
                                    fit: BoxFit.cover)),
                          ),
                        );
        } else if (null != snapshot.error) {
         _toff = "non";
          return Hero(
                          tag: 'hero-tag-',
                          child: Container(
                            height: 130.0,
                            width: 130.0,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50.0)),
                                image: DecorationImage(
                                    image: CachedNetworkImageProvider(
                                      "https://www.sleepmoh.com/manager/avatars/" + nom,
                                    ),
                                    fit: BoxFit.cover)),
                          ),
                        );
        } else {
         _toff = "non";
          return Hero(
                          tag: 'tag-profile',
                          child: Container(
                            height: 130.0,
                            width: 130.0,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50.0)),
                                image: DecorationImage(
                                    image: CachedNetworkImageProvider(
                                      "https://www.sleepmoh.com/manager/avatars/" + nom,
                                    ),
                                    fit: BoxFit.cover)),
                          ),
                        );
        }
      },
    );
  }

_displayDialog(BuildContext context) async {
 
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('D\'où voulez-vous prendre la photo ?'),
            content: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
             
                 new RaisedButton(
                    padding: const EdgeInsets.all(8.0),
                    textColor: Colors.white,
                    color: Colors.blue,
                    onPressed: (){
                      garelypic();
                    },
                    child: new Text("Gallery"),
                  ),
                   new FlatButton(
                child: new Text(''),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
                  new RaisedButton(
                    onPressed: (){
                      camerapic();
                    },
                    textColor: Colors.white,
                    color: Colors.blue[200],
                    padding: const EdgeInsets.all(8.0),
                    child: new Text(
                      "Camera",
                    ),
                  ),
                ]
            ),
            actions: <Widget>[
             
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
i ++;
    phoneNumber = widget.userinfo.login;
      confirmedNumber = widget.userinfo.telephone;
 _password0 = widget.userinfo.password;
  _name = widget.userinfo.nom;
   
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text("Edit Profile",
            style: TextStyle(fontFamily: "Sofia", color: Colors.black)),
        actions: <Widget>[
          Center(
              child: Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: InkWell(onTap: (){
_validateInputs();
            },
            child: Text("Done",
                style: TextStyle(
                    color: Color(0xFF7F53AC),
                    fontFamily: "Sofia",
                    fontWeight: FontWeight.w800,
                    fontSize: 17.0)),)
          ))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Container(
                        height: 420.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 15.0,
                              spreadRadius: 10.0,
                              color: Colors.black12.withOpacity(0.03),
                            )
                          ],
                        ),
                        child: new Form(key: _formkey0,
                        autovalidate: _autoValidate,
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 50.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0,
                                  right: 15.0,
                                  bottom: 10.0,
                                  top: 50.0),
                              child: Theme(
                                data: ThemeData(
                                  highlightColor: Colors.white,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "Username",
                                      style: TextStyle(
                                          fontFamily: "Sofia",
                                          color: Colors.black26,
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 40.0),
                                        child: TextFormField(
                                          validator: validateName,
                                           onSaved: (String val) {
                                          _name = val;
                                        },
                                        initialValue: widget.userinfo.nom,
                                            decoration: InputDecoration(
                                          hintText: widget.userinfo.nom,
                                          
                                          hintStyle: TextStyle(
                                              fontFamily: "Sofia",
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 17.0),
                                          enabledBorder:
                                              new UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white,
                                                width: 1.0,
                                                style: BorderStyle.none),
                                          ),
                                        )),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Divider(
                              color: Colors.black12.withOpacity(0.1),
                              height: 0.3,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0,
                                  right: 15.0,
                                  bottom: 10.0,
                                  top: 10.0),
                              child: Theme(
                                data: ThemeData(
                                  highlightColor: Colors.white,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "Téléphone",
                                      style: TextStyle(
                                          fontFamily: "Sofia",
                                          color: Colors.black26,
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 40.0),
                                        child: InternationalPhoneInput(
                                    onPhoneNumberChange: onPhoneNumberChange,
                                    initialSelection: phoneIsoCode,
                                    initialPhoneNumber: widget.userinfo.login,
                                    errorText: AppLocalizations.of(context).tel_error,
                                    hintText: widget.userinfo.login,
                                       hintStyle: TextStyle(
                                              fontFamily: "Sofia",
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 17.0),
                                    showCountryCodes: false,
                                    showCountryFlags: true,
                                ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Divider(
                              color: Colors.black12.withOpacity(0.1),
                              height: 0.3,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0,
                                  right: 15.0,
                                  bottom: 10.0,
                                  top: 10.0),
                              child: Theme(
                                data: ThemeData(
                                  highlightColor: Colors.white,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "Mot de passe ",
                                      style: TextStyle(
                                          fontFamily: "Sofia",
                                          color: Colors.black26,
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 40.0),
                                        child: TextFormField(
                                          obscureText: true,
                                          validator: validatePass,
                                                onSaved: (String val) {
                                                  _password = val;
                                                },
                                                initialValue: widget.userinfo.password,
                                            decoration: InputDecoration(
                                          hintText: 'Enter new pasword',
                                  
                                          hintStyle: TextStyle(
                                              fontFamily: "Sofia",
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 17.0),
                                          enabledBorder:
                                              new UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white,
                                                width: 1.0,
                                                style: BorderStyle.none),
                                          ),
                                        )),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Divider(
                              color: Colors.black12.withOpacity(0.1),
                              height: 0.3,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0,
                                  right: 15.0,
                                  bottom: 10.0,
                                  top: 10.0),
                              child: Theme(
                                data: ThemeData(
                                  highlightColor: Colors.white,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "Confirm password",
                                      style: TextStyle(
                                          fontFamily: "Sofia",
                                          color: Colors.black26,
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 40.0),
                                        child: InkWell(
                                          onTap: () {
                                         
                                          },
                                          child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 10.0),
                                              child: Container(
                                                height: 53.5,
                                                decoration: BoxDecoration(),
                                                child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 1.0,
                                                            right: 12.0,
                                                            top: 3.0),
                                                    child: TextFormField(
                                          obscureText: true,
                                          validator: validateCPass,
                                                onSaved: (String val) {
                                                  _password0 = val;
                                                },
                                                initialValue: widget.userinfo.password,
                                            decoration: InputDecoration(
                                          hintText: 'Enter new pasword',
                                  
                                          hintStyle: TextStyle(
                                              fontFamily: "Sofia",
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 17.0),
                                          enabledBorder:
                                              new UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white,
                                                width: 1.0,
                                                style: BorderStyle.none),
                                          ),
                                        )),),
                                              )),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Divider(
                              color: Colors.black12.withOpacity(0.1),
                              height: 0.3,
                            ),
                          ],
                        ),
                        
                      )),
                    )
                  ],
                ),
              ),
              Align(
                      alignment: Alignment.topCenter,
                      child: Stack(children: <Widget>[
                        showImage(widget.userinfo.avatar),
                        Padding(
                          padding: const EdgeInsets.only(top: 80.0, left: 90.0),
                          child: InkWell(
                            onTap: () {
                              _displayDialog(context);
                            },
                            child: Container(
                              height: 45.0,
                              width: 45.0,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50.0)),
                                color: Colors.black,
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                  size: 18.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ])),
                 showPageLoader ? _showPageLoader() : Container(),
            ],
          ),
        ),
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

  String validatePass(String value) {
// Indian Mobile number are of 10 digit only
_password = value;

  if(value == null || value.isEmpty){
    return AppLocalizations.of(context).pas_error;
  }else{
    if (!isPasswordCompliant(value))
          return AppLocalizations.of(context).passseer;
        else
          return null;
  }
    
  }
    String validateCPass(String value) {
// Indian Mobile number are of 10 digit only
_password0 = value;

  if(value == null || value.isEmpty){
    return AppLocalizations.of(context).pas_error;
  }else{
    if (value != _password)
          return AppLocalizations.of(context).passss_error;
        else
          return null;
  }
    
  }
    bool isPasswordCompliant(String password, [int minLength = 6]) {
      if (password == null || password.isEmpty) {
        return false;
      }

      bool hasUppercase = password.contains(new RegExp(r'[A-Z]'));
      bool hasDigits = password.contains(new RegExp(r'[0-9]'));
      bool hasLowercase = password.contains(new RegExp(r'[a-z]'));
      bool hasSpecialCharacters = password.contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
      bool hasMinLength = password.length > minLength;

      return hasMinLength;
    }

  String validateEmail(String value) {
    /*Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;*/
  if(value == null || value.isEmpty){
    return AppLocalizations.of(context).pas_error;
  }else{
  //  log(_mobile);
    if (!(value == _password0))
          return AppLocalizations.of(context).passss_error;
        else
          return null;
  }

  }
  void _validateInputs() {
    
  if (_formkey0.currentState.validate()) {
//    If all data are correct then save data to out variables
    _formkey0.currentState.save();
    startPayment();
                  if(_toff == 'oui'){
String fileName = tmpFile.path.split('/').last;
  HttpPostRequest.uploade_image_up(phoneNumber,confirmedNumber,phoneIsoCode,_name, _password0, fileName, base64Image, widget.userinfo.idu).then((String result){
              if(result == "error"){
                             errorTransaction();
                           }else{
                                  if(result == "exit"){
                                  compteExit();
                                }else{
                                 // log('result'+ result);
                                  var userinfos = new List<UserMod>();
           
                                Iterable list0 = jsonDecode(result);
                                userinfos = list0.map((model) => UserMod.fromJson(model)).toList();
                                    globals.userinfos = userinfos[0];
                                //pour le compte existant  widget.compteE();
                                 sucessTansaction();

                                 Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(builder: (context) => new bottomNavBar()),
                                  (Route<dynamic> route) => false,
                                );
                                }
                           }
              });

            }else{
              HttpPostRequest.uploade_image_up(phoneNumber,confirmedNumber,phoneIsoCode,_name, _password0, "non", "non", widget.userinfo.idu).then((String result){
            if(result == "error"){
                             errorTransaction();
                           }else{
                                  if(result == "exit"){
                                  compteExit();
                                }else{
                                 // log('result'+ result);
                                 
                                //pour le compte existant  widget.compteE();
                                 sucessTansaction();

                                   Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(builder: (context) => new bottomNavBar()),
                                  (Route<dynamic> route) => false,
                                );
                                }
                           }
              });
            }
             
                         

    //widget.notifyParent();
    //log(_email);
  }else {
//    If all data are not valid then start auto validation.
    setState(() {
      _autoValidate = true;
    });
  } 
}
}
