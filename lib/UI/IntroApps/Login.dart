import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sleepmohapp/Library/SupportingLibrary/Animation/FadeAnimation.dart';
import 'package:sleepmohapp/Library/SupportingLibrary/Animation/LoginAnimation.dart';
import 'package:sleepmohapp/core/localizations.dart';
import 'SignUp.dart';
import 'package:international_phone_input/international_phone_input.dart';
import 'package:connectivity/connectivity.dart';
import 'package:sleepmohapp/core/httpreq.dart';

import 'package:carousel_pro/carousel_pro.dart';
import 'dart:async';
import 'dart:ui';
import 'package:sleepmohapp/core/util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:sleepmohapp/UI/Bottom_Nav_Bar/bottomNavBar.dart';

import 'dart:developer';
import 'dart:io';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with TickerProviderStateMixin {
  @override

  //Animation Declaration
  AnimationController sanimationController;
  final GlobalKey<FormState> _formkey0 = GlobalKey<FormState>();
  bool _autoValidate = false;
  var _login = "";
  var _password = "";
  String phoneNumber = '';
  bool showPageLoader = false;
  bool showSpinner = false;
  bool showAddNote = false;
  bool showChecked = false;
  bool showCheckedErrorCompExit = false;
  bool showCheckedErrorInternet = false;
  bool showCheckedError = false;
  String _platformVersion = 'Unknown';
  String confirmedNumber = '';
  String phoneIsoCode = "+237";
  bool visible = false;

  String _connectionStatus = 'Unknown';
  AnimationController animationController;
  var tap = 0;
  final Connectivity _connectivity = Connectivity();
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

  /// set state animation controller
  void initState() {
    sanimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 10))
          ..addStatusListener((statuss) {
            if (statuss == AnimationStatus.dismissed) {
              setState(() {
                tap = 0;
              });
            }
          });

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

    //  initConnectivity();
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
    if (_connectionStatus == "ConnectivityResult.none") {
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
              });
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
                  child: Image.asset(
                    'assets/image/load2.gif',
                    height: 150,
                  ),
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

  /// Dispose animation controller
  @override
  void dispose() {
    sanimationController.dispose();
    super.dispose();
  }

  /// Playanimation set forward reverse
  Future<Null> _PlayAnimation() async {
    try {
      await sanimationController.forward();
      await sanimationController.reverse();
    } on TickerCanceled {}
  }

  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    height: 220,
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          height: 200,
                          width: width + 20,
                          child: new Carousel(
                            boxFit: BoxFit.cover,
                            dotColor: Colors.white.withOpacity(0.8),
                            dotSize: 5.5,
                            dotSpacing: 16.0,
                            dotBgColor: Colors.transparent,
                            showIndicator: true,
                            overlayShadow: true,
                            overlayShadowColors: Colors.white.withOpacity(0.1),
                            overlayShadowSize: 0.9,
                            images: [
                              CachedNetworkImageProvider(
                                  "https://sleepmoh.com/flutterimg/hotel2.jpg"),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 20,
                      right: 20.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        /// Fade Animation for transtition animaniton
                        FadeAnimation(
                            1.2,
                            Text(
                              "Connexion",
                              style: TextStyle(
                                  fontFamily: "Sofia",
                                  fontWeight: FontWeight.w800,
                                  fontSize: 37.5,
                                  wordSpacing: 0.1),
                            )),
                        SizedBox(
                          height: 30,
                        ),
                        FadeAnimation(
                            1.7,
                            Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Color.fromRGBO(255, 110, 80, 0.3),
                                        blurRadius: 20,
                                        offset: Offset(0, 10),
                                      )
                                    ]),
                                child: new Form(
                                  key: _formkey0,
                                  autovalidate: _autoValidate,
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: Colors.grey[200]))),
                                        child: InternationalPhoneInput(
                                          onPhoneNumberChange:
                                              onPhoneNumberChange,
                                          initialSelection: phoneIsoCode,
                                          errorText:
                                              AppLocalizations.of(context)
                                                  .tel_error,
                                          hintText:
                                              AppLocalizations.of(context).tel,
                                          showCountryCodes: false,
                                          showCountryFlags: true,
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        child: TextFormField(
                                          obscureText: true,
                                          validator: validatePass,
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "Mot de passe",
                                              icon: Icon(
                                                Icons.vpn_key,
                                                color: Colors.black12,
                                              ),
                                              hintStyle: TextStyle(
                                                  color: Colors.grey,
                                                  fontFamily: "sofia")),
                                          onSaved: (String val) {
                                            _password = val;
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                ))),
                        SizedBox(
                          height: 40,
                        ),
                        FadeAnimation(
                            1.7,
                            InkWell(
                                onTap: () {
                                  Navigator.of(context).pushReplacement(
                                      PageRouteBuilder(
                                          pageBuilder: (_, __, ___) => Signup(),
                                          transitionDuration:
                                              Duration(milliseconds: 2000),
                                          transitionsBuilder: (_,
                                              Animation<double> animation,
                                              __,
                                              Widget child) {
                                            return Opacity(
                                              opacity: animation.value,
                                              child: child,
                                            );
                                          }));
                                },
                                child: Text(
                                  "Besoin d'un compte ? Inscrivez-vous",
                                  style: TextStyle(
                                      color: Colors.black38,
                                      fontFamily: "Sofia",
                                      fontWeight: FontWeight.w300,
                                      letterSpacing: 1.3),
                                ))),
                        SizedBox(height: 110)
                      ],
                    ),
                  ),
                ],
              ),

              /// Set Animaion after user click buttonLogin
              tap == 0
                  ? InkWell(
                      splashColor: Colors.yellow,
                      onTap: () {
                        _validateInputs();
                      },
                      child: FadeAnimation(
                        1.9,
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: 55.0,
                            margin: EdgeInsets.only(
                                left: 20.0, right: 20.0, top: 0.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Color(0xFF8DA2BF),
                            ),
                            child: Center(
                              child: Text(
                                "Connexion",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Sofia",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 19.5,
                                    letterSpacing: 1.2),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : new LoginAnimation(
                      // animationController: sanimationController.view,
                      ),
              showPageLoader ? _showPageLoader() : Container(),
            ],
          ),
        ],
      ),
    );
  }

  String validateName(String value) {
    _login = value;
    if (value.length < 3)
      return AppLocalizations.of(context).tel;
    else
      return null;
  }

  String validatePass(String value) {
// Indian Mobile number are of 10 digit only
    _password = value;

    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context).pas_error;
    } else {
      if (!isPasswordCompliant(value))
        return AppLocalizations.of(context).passseer;
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
    bool hasSpecialCharacters =
        password.contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    bool hasMinLength = password.length > minLength;

    return hasDigits &
        hasUppercase &
        hasLowercase &
        hasSpecialCharacters &
        hasMinLength;
  }

  void _validateInputs() {
    if (_formkey0.currentState.validate()) {
//    If all data are correct then save data to out variables
      _formkey0.currentState.save();
      startPayment();
      netErrorTransaction();

      HttpPostRequest.login_request(phoneNumber, _password)
          .then((String result) {
        if (result == "error") {
          errorTransaction();
        } else {
          if (result == "exit") {
            compteExit();
          } else {
            // log('result'+ result);
            // Navigator.pop(context);
            //pour le compte existant  widget.compteE();
            // _displayDialog(context, confirmedNumber);

            sucessTansaction();
            sleep(const Duration(seconds: 20));
            Navigator.pushNamed(context, '/startapp');

            /* Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => new bottomNavBar()),
              (Route<dynamic> route) => false,
            );*/
          }
        }
      });
    } else {
//    If all data are not valid then start auto validation.
      setState(() {
        _autoValidate = true;
      });
    }
  }
}
