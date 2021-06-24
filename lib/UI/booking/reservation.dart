import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:ui';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:international_phone_input/international_phone_input.dart';
import 'package:sleepmohapp/Library/SupportingLibrary/Animation/FadeAnimation.dart';
import 'package:sleepmohapp/Library/SupportingLibrary/Animation/LoginAnimation.dart';
import 'package:sleepmohapp/UI/IntroApps/Login.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:sleepmohapp/core/httpreq.dart';
import 'package:sleepmohapp/core/global.dart' as globals;
import 'package:sleepmohapp/core/preference.dart';
import 'package:sleepmohapp/UI/booking/datepicker.dart';
import 'package:carousel_pro/carousel_pro.dart';

import 'package:like_button/like_button.dart';
import 'package:sleepmohapp/DataSample/UserMod.dart';
import 'package:sleepmohapp/UI/Bottom_Nav_Bar/bottomNavBar.dart';
import 'package:sleepmohapp/core/localizations.dart';
import 'package:sleepmohapp/core/util.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class Reservation extends StatefulWidget {
 // const Reservation({ Key? key }) : super(key: key);
String type, title,note, price, location, id, description, periode, acces, stanting, securi;
  double  ratting, ln, lat;
  Reservation(
    {
      this.type,
      this.title,
      this.price,
      this.location,
      this.id,
      this.ratting, this.description, this.periode, this.ln, this.lat, this.note, this.acces, this.stanting, this.securi
    }
  );

  @override
  _ReservationState createState() => _ReservationState();
}

class _ReservationState extends State<Reservation> with TickerProviderStateMixin {
  @override

  //Animation Declaration
  var userinfos = new List<UserMod>();
  AnimationController sanimationController;
  String phoneNumber = '';
  String _date = '';
  String _dated = '';
  String _datef = '';
  String _prixt = '';
  int code;
  String _name;
  String _daterange = "";
  Timer _timer;
  int _start = 10;
  double _nbjour = 0;
  var ratting = 2.5;
  var texttt = TextEditingController();
  var datrrr = TextEditingController();
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
  String _platformVersion = 'Unknown';

  String _connectionStatus = 'Unknown';
  var _txtStyleTitle = TextStyle(
    color: Colors.black54,
    fontFamily: "Sofia",
    fontSize: 20.0,
    fontWeight: FontWeight.w800,
  );
  var _txtStyleSub = TextStyle(
      color: Colors.black26,
      fontFamily: "Sofia",
      fontSize: 12.5,
      fontWeight: FontWeight.w600,
    );
  final Connectivity _connectivity = Connectivity();
  final GlobalKey<FormState> _formkey0 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formkey1000 = GlobalKey<FormState>();
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
    Random random = new Random();
    code = random.nextInt(1000000);
    print("code");
    print(code);
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

/*
  Future<void> initPlatformState(code) async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    const oneSec = const Duration(seconds: 5);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () async {
          var list = await query.querySms(address: "KifCab");
          var i = 0;
          print("list");
          while (i < list.length) {
            print(list[i].body);
            print(code);

            var string = list[i].body;
            var resul = string.split(":");
            print(resul[1]);
            if (resul[1].toString() == code.toString()) {
              print('arret');
              texttt.text = code.toString();
              _timer.cancel();
              _validateInputs10();
            }

            i = i + 1;
          }
        },
      ),
    );
  }
*/
  /// Dispose animation controller
  @override
  void dispose() {
    sanimationController.dispose();
    super.dispose();
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

  _displayDialog(BuildContext context, phone, result) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Véifier le ' + phone,
              style: TextStyle(
                  fontSize: 15.5,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Gotik'),
              textAlign: TextAlign.center,
            ),
            content: Container(
                height: 160.0,
                width: double.infinity,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 0.0, right: 0.0, top: 20.0),
                        child: Text(
                          "Veuillez saisir le code reçu par SMS au ",
                          style: TextStyle(
                              color: Colors.black, fontFamily: "Sofia"),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 0.0, right: 0.0, top: 0.0),
                        child: Text(
                          phone,
                          style: TextStyle(
                              fontSize: 15.5,
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Gotik'),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 0.0, right: 0.0, top: 10.0),
                          child: Text(
                            "Numéro incorect ?",
                            style: TextStyle(
                                color: Colors.blue, fontFamily: "Sofia"),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        width: 100.0,
                        child: TextFormField(
                          validator: validateName,
                          controller: texttt,
                          onChanged: (text) {
                            print(text.toString());
                            print(code.toString());
                            if (text.toString() == code.toString()) {
                              _validateInputs11(result);
                            }
                          },
                          decoration: InputDecoration(
                              hintText: "Code",
                              hintStyle: TextStyle(
                                  color: Colors.grey, fontFamily: "sofia")),
                          onSaved: (String val) {
                            _name = val;
                          },
                        ),
                      )
                    ])),
            actions: <Widget>[],
          );
        });
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

  /// Playanimation set forward reverse
  Future<Null> _PlayAnimation() async {
    try {
      await sanimationController.forward();
      await sanimationController.reverse();
    } on TickerCanceled {}
  }

  Widget build(BuildContext context,) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          margin: null,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: ListView(
            children: <Widget>[
              Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: <Widget>[
                  
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      /// Image Top
                      Container(
                        height: 200,
                        child: Stack(
                          children: <Widget>[
                            
                            Positioned(
                              height: 200,
                              width: width + 20,
                              child: new Carousel(
                                boxFit: BoxFit.cover,
                                dotColor: Colors.white.withOpacity(0.5),
                                dotSize: 8.5,
                                dotSpacing: 16.0,
                                dotBgColor: Colors.transparent,
                                showIndicator: true,
                                overlayShadow: true,
                                overlayShadowColors:
                                    Colors.white.withOpacity(0.1),
                                overlayShadowSize: 0.9,
                                images: globals.listimages.map((image) => CachedNetworkImageProvider(image.imgh_name)).toList(),
                              ),
                            ),
                            Positioned(
                              left: 0,
                              top: 0,                           
                              child: RawMaterialButton(
                              onPressed: () {Navigator.pop(context);},
                              elevation: 0.0,
                              fillColor: Colors.white.withOpacity(0.85),
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.black
                              ),
                              padding: EdgeInsets.all(5.0),
                              shape: CircleBorder(),
                            ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                         decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.red[200].withOpacity(0.5),
                            spreadRadius: 0,
                            blurRadius: 20,
                            offset: Offset(0, 0.5), // changes position of shadow
                          ),
                        ],
                      ),
                        child: Align(
          alignment: Alignment.bottomLeft,
          child: Opacity(
            opacity: (1),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 10.0, right: 20.0, left: 20.0, bottom: 10.0),
              child: Container(
                height: 140.0,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: Colors.white.withOpacity(0.85)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 15.0, right: 2.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                    width: 180.0,
                                    child: Text(
                                      widget.title,
                                     style: _txtStyleTitle.copyWith(
                                          fontSize: 27.0),
                                      overflow: TextOverflow.clip,
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(right: 13.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        widget.price.toString(),
                                        style: TextStyle(
                                            fontSize: 25.0,
                                            color: Colors.blue[300],
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "Gotik"),
                                      ),
                                      Text( "/ " + widget.periode,
                                      style: _txtStyleSub.copyWith(
                                              fontSize: 15.0)
                                          )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 15.0, right: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                      Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 15.0, top: 5.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                            widget.ratting > 1 ? 
                                        Icon(
                                          Icons.star,
                                          color: Colors.blue[300],
                                          size: 22.0,
                                        )
                                        : 

                                        Icon(
                                          Icons.star_border,
                                          color: Colors.blue[300],
                                          size: 22.0,
                                        ),

                                         widget.ratting > 2 ? 
                                        Icon(
                                          Icons.star,
                                          color: Colors.blue[300],
                                          size: 22.0,
                                        )
                                        : 

                                        Icon(
                                          Icons.star_border,
                                          color: Colors.blue[300],
                                          size: 22.0,
                                        ),
                                         widget.ratting > 3 ? 
                                        Icon(
                                          Icons.star,
                                          color: Colors.blue[300],
                                          size: 22.0,
                                        )
                                        : 

                                        Icon(
                                          Icons.star_border,
                                          color: Colors.blue[300],
                                          size: 22.0,
                                        ),
                                         widget.ratting > 4 ? 
                                        Icon(
                                          Icons.star,
                                          color: Colors.blue[300],
                                          size: 22.0,
                                        )
                                        : 

                                        Icon(
                                          Icons.star_border,
                                          color: Colors.blue[300],
                                          size: 22.0,
                                        ),
                                         widget.ratting > 5 ? 
                                        Icon(
                                          Icons.star,
                                          color: Colors.blue[300],
                                          size: 22.0,
                                        )
                                        : 

                                        Icon(
                                          Icons.star_border,
                                          color: Colors.blue[300],
                                          size: 22.0,
                                        ),
                                      
                      ],
                    ),
                  ),
                                    // ratingbar(starRating: ratting,color: Colors.deepPurpleAccent,),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Icon(
                                            Icons.location_on,
                                            size: 14.0,
                                            color: Colors.black26,
                                          ),
                                          Text(
                                            widget.location,
                                            style: TextStyle(
                                                color: Colors.black26,
                                                fontSize: 14.5,
                                                fontFamily: "Sofia",
                                                fontWeight: FontWeight.w400),
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                LikeButton(),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
                      ),

                     
                      Padding(
                          padding: EdgeInsets.only(
                            left: 20,
                            right: 20.0,
                          ),
                          child: new Form(
                            key: _formkey0,
                            autovalidate: _autoValidate,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  height: 20,
                                ),
                                FadeAnimation(
                                    1.2,
                                    Text(
                                      AppLocalizations.of(context).resv,
                                      style: TextStyle(
                                          fontFamily: "Sofia",
                                          fontWeight: FontWeight.w800,
                                          fontSize: 24.5,
                                          wordSpacing: 0.1),
                                    )),
                                SizedBox(
                                  height: 10,
                                ),
                                FadeAnimation(
                                    1.2,
                                    Text(
                                      AppLocalizations.of(context).resvatio,
                                      style: TextStyle(
                                          fontFamily: "Sofia",
                                          fontSize: 14.5,
                                          wordSpacing: 0.1),
                                    )),
                                SizedBox(
                                  height: 10,
                                ),
                                FadeAnimation(
                                    1.7,
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color.fromRGBO(
                                                  255, 110, 80, 0.3),
                                              blurRadius: 20,
                                              offset: Offset(0, 10),
                                            )
                                          ]),
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    bottom: BorderSide(
                                                        color:
                                                            Colors.grey[200]))),
                                            child: TextFormField(
                                              validator: validateName,
                                              decoration: InputDecoration(
                                                  hintText: AppLocalizations.of(
                                                          context)
                                                      .lblname,
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
                                          Container(
                                            padding: EdgeInsets.all(10),
                                            child: InternationalPhoneInput(
                                              onPhoneNumberChange:
                                                  onPhoneNumberChange,
                                              initialSelection: phoneIsoCode,
                                              errorText:
                                                  AppLocalizations.of(context)
                                                      .tel_error,
                                              hintText:
                                                  AppLocalizations.of(context)
                                                      .tel,
                                              showCountryCodes: false,
                                              showCountryFlags: true,
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(10),
                                            child: TextFormField(
                                               onTap: () async {
                                                var result = await Navigator.push(context, new MaterialPageRoute(
                                                builder: (BuildContext context) => new Datepicker(),
                                                fullscreenDialog: true,));
                                                print(result.toString());
                                                setState(() {
                                                  _daterange = result.toString();
                                                  datrrr.text = result.toString();
                                                  FocusScope.of(context).requestFocus(FocusNode());
                                                });
                                              },
                                              controller: datrrr,
                                              decoration: InputDecoration(
                                                  hintText: AppLocalizations.of(
                                                          context)
                                                      .datedeparr,
                                                  icon: Icon(
                                                    Icons.calendar_today_sharp,
                                                    color: Colors.black12,
                                                  ),
                                                  hintStyle: TextStyle(
                                                      color: Colors.grey,
                                                      fontFamily: "sofia")),
                                             
                                              validator: validatePass,
                                              onSaved: (String val) {
                                                _daterange = val;
                                              },
                                            ),
                                          )
                                        ],
                                      ),
                                    )),
                                
                                SizedBox(
                                  height: 90,
                                ),
                              ],
                            ),
                          ))
                    ],
                  ),
                  InkWell(
                    onTap: () {

                      _validateInputs();
                    },
                    child: Container(
                      height: 55.0,
                      margin: EdgeInsets.only(left: 10.0, right: 10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Color(0xFF8DA2BF),
                      ),
                      child: Center(
                        child: Text(
                          AppLocalizations.of(context).confr,
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Sofia",
                              fontWeight: FontWeight.w500,
                              fontSize: 17.5,
                              letterSpacing: 1.2),
                        ),
                      ),
                    ),
                  ),

                  /// Set Animaion after user click buttonSignup

                  // animationController: sanimationController.view,

                  showPageLoader ? _showPageLoader() : Container(),
                ],
              ),
            ],
          )),
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
    _daterange = value;

    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context).pas_error;
    } else {
      if (!isPasswordCompliant(value))
        return AppLocalizations.of(context).passseer;
      else
        return null;
    }
  }

  String validateCPass(String value) {
// Indian Mobile number are of 10 digit only
    _daterange = value;

    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context).pas_error;
    } else {
      if (value != _daterange)
        return AppLocalizations.of(context).passss_error;
      else
        return null;
    }
  }

  bool isPasswordCompliant(String password, [int minLength = 6]) {
    if (password == null || password.isEmpty) {
      return false;
    }
/*
    bool hasUppercase = password.contains(new RegExp(r'[A-Z]'));
    bool hasDigits = password.contains(new RegExp(r'[0-9]'));
    bool hasLowercase = password.contains(new RegExp(r'[a-z]'));
    bool hasSpecialCharacters =
        password.contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
        */
    bool hasMinLength = password.length > minLength;

    return  hasMinLength;
  }

  String validateEmail(String value) {
    /*Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;*/
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context).pas_error;
    } else {
      //  log(_mobile);
      if (!(value == _daterange))
        return AppLocalizations.of(context).passss_error;
      else
        return null;
    }
  }

  void _validateInputs() {
    if (_formkey0.currentState.validate()) {
//    If all data are correct then save data to out variables
      _formkey0.currentState.save();

      _validateInputs10();
   //   _displayDialog(context, confirmedNumber);
      print(code);

      /*
      HttpPostRequest.sendMessage(confirmedNumber, code)
          .then((String result) async {
        // initPlatformState(code);

        if (result == "error") {
          // errorTransaction();
        } else {
          if (result == "exit") {
            // compteExit();
          } else {
            // log('result'+ result);
            // Navigator.pop(context);
            //pour le compte existant  widget.compteE();
            //    _displayDialog(context, confirmedNumber);

            // sucessTansaction();
          }
        }
      });
*/
      //widget.notifyParent();
      //log(_email);
    } else {
//    If all data are not valid then start auto validation.
      setState(() {
        _autoValidate = true;
      });
    }
  }

  void _validateInputs11(result) {

 Navigator.of(context).pop();
    startPayment();
    
    netErrorTransaction();
      Navigator.of(context).pop();
                               SharedPreferencesClass.save("userinfos", result);
                               setState(() {
                                 
                                globals.userinfos = userinfos[0];
                               });

                               sucessTansaction();

                                 Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(builder: (context) => new bottomNavBar()),
                                  (Route<dynamic> route) => false,
                                );
  }
  void _validateInputs10() {
   // Navigator.of(context).pop();
//    If all data are correct then save data to out variables

 
  int days = DateTime.parse(_daterange.substring(13, 23)).millisecondsSinceEpoch - DateTime.parse(_daterange.substring(0, 10)).millisecondsSinceEpoch;
  

  double bae = (days / 1000).toDouble();


  _nbjour = (bae / 86400).toDouble();


  _prixt = (int.parse(widget.price) * _nbjour).toString();
 
  _dated = DateFormat('dd/MM/yyyy').format(DateTime.parse(_daterange.substring(0, 10)));
  _datef = DateFormat('dd/MM/yyyy').format(DateTime.parse(_daterange.substring(13, 23)));

    startPayment();
    netErrorTransaction();

    HttpPostRequest.reservation_request( _dated, _datef, _name, confirmedNumber.substring(1, confirmedNumber.length), widget.type, "", _prixt, widget.id)
        .then((String result) {
        print("print ::" + result.toString());
      if (result == "error") {
        errorTransaction();
      } else {
        if (result == "exit") {
          compteExit();
        } else {
          // log('result'+ result);
          Navigator.pop(context);
        }
      }
    });

    //widget.notifyParent();
    //log(_email);
  }

}