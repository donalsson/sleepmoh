import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'dart:math';

import 'package:path_provider/path_provider.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter_google_places/flutter_google_places.dart';

import 'package:flutter/material.dart';
import 'package:international_phone_input/international_phone_input.dart';
import 'package:sleepmohapp/DataSample/UserMod.dart';
import 'package:sleepmohapp/Library/SupportingLibrary/Animation/FadeAnimation.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:sleepmohapp/core/httpreq.dart';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:im_stepper/stepper.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:sleepmohapp/UI/Bottom_Nav_Bar/bottomNavBar.dart';
import 'package:sleepmohapp/core/localizations.dart';
import 'package:sleepmohapp/core/util.dart';

import 'package:sleepmohapp/UI/IntroApps/listuserpro.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

const kGoogleApiKey = "AIzaSyDRn0mlxRwnXRJZI4cNqFOgsGNssI5APRo";

// to get places detail (lat/lng)
GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

class Addpropertie extends StatefulWidget {
  UserMod userinfo;
  Addpropertie(this.userinfo);

  @override
  _AddpropertieState createState() => _AddpropertieState();
}

final homeScaffoldKey = GlobalKey<ScaffoldState>();
final searchScaffoldKey = GlobalKey<ScaffoldState>();

class _AddpropertieState extends State<Addpropertie>
    with TickerProviderStateMixin {
  @override
  int activeStep = 0; // Initial step set to 5.
  Mode _mode = Mode.overlay;
  // Must be used to control the upper bound of the activeStep variable. Please see next button below the build() method!
  int upperBound = 0;
  //Animation Declaration
  AnimationController sanimationController;
  String phoneNumber = '';
  String _password = '';
  String _id = '';
  String _password0 = '';
  List<File> fileImageArray = [];
  List<Asset> imagesss = List<Asset>();
  String _error = 'No Error Dectected';
  List<String> _typeb = [
    'Appartement meublé',
    'Appartement non meublé',
    'Chambre meublée',
    'Chambre non meublé',
    'Studio meublée',
    'Studio non meublé'
  ]; // Option 2
  List<String> _aces = ['Facile', 'Moyen', 'Difficile']; // Option 2
  List<String> _periode = ['Jours', 'Semaine', 'Mois', 'Année']; // Option 2
  List<String> niveauss = ['Haut', 'Moyen', 'Bas']; // Option 2
  List<String> stanting = ['Haut', 'Moyen', 'Bas']; // Option 2
  String vtype;
  String vaces;
  String vperiode;
  String vniveaus;
  String vstantding;
  bool clim = false;
  bool barri = false;
  bool internet = false;
  bool parki = false;
  bool eauch = false;
  bool clautu = false;
  bool ascenseur = false;
  bool groupe = false;
  bool piscin = false;
  bool wifi = false;
  bool gard = false;
  bool tera = false;
  int code;
  String _vile;
  String _quartier;
  String _zone;
  String _prix;
  String _capacit;
  String descfr;
  String descen;
  String _name;
  Timer _timer;
  int _start = 10;
  var texttt = TextEditingController();
  var name = TextEditingController();
  bool showAddNote = false;
  bool showPageLoader = true;
  bool showSpinner = false;
  bool _autoValidate = false;
  bool _autoValidate1 = false;
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

  //f SmsQuery query = new SmsQuery();

  final Connectivity _connectivity = Connectivity();
  final GlobalKey<FormState> _formkey0 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formkey1 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formkey2 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formkey3 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formkey4 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formkey5 = GlobalKey<FormState>();
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

  Widget buildGridView() {
    fileImageArray.clear();
    imagesss.forEach((imageAsset) async {
      print("litel");
      final byteData = await imageAsset.getByteData();

      final tempFile =
          File("${(await getTemporaryDirectory()).path}/${imageAsset.name}");
      final file = await tempFile.writeAsBytes(
        byteData.buffer
            .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes),
      );
      print("file.path");
      print(file.path);
      //   File tempFile = File(filePath);
      fileImageArray.add(file);
      //  fileImageArray.add(file);
    });

    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(imagesss.length, (index) {
        Asset asset = imagesss[index];
        // File imageFile = File(imagesss[index].toString());
        return AssetThumb(
          asset: asset,
          width: 300,
          height: 300,
        );
      }),
    );
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();
    String error = 'No Error Dectected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
        enableCamera: true,
        selectedAssets: imagesss,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Example App",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

//return fileImageArray;

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      imagesss = resultList;
      _error = error;
    });
  }

/*
  Future<void> initPlatformState(code) async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    const oneSec = const Duration(seconds: 5);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () async {
          var list = await query.querySms(address: "SleepMoh");
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
      //animationController.forward();
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

  _displayDialog(BuildContext context, phone) async {
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
                height: 150.0,
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
                          _timer.cancel();
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
                            print(text.length);
                            if (text.toString() == code.toString()) {
                              _validateInputs10();
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
              margin: EdgeInsets.all(10),
              color: Colors.white.withOpacity(0.6),
            ),
          ),
        ),
        showSpinner
            ? Align(
                alignment: Alignment.bottomCenter,
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

  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Container(
          color: Colors.white,
          child: Center(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            child: Stack(children: <Widget>[
              Column(
                  // Column is also a layout widget. It takes a list of children and
                  // arranges them vertically. By default, it sizes itself to fit its
                  // children horizontally, and tries to be as tall as its parent.
                  //
                  // Invoke "debug painting" (press "p" in the console, choose the
                  // "Toggle Debug Paint" action from the Flutter Inspector in Android
                  // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
                  // to see the wireframe for each widget.
                  //
                  // Column has various properties to control how it sizes itself and
                  // how it positions its children. Here we use mainAxisAlignment to
                  // center the children vertically; the main axis here is the vertical
                  // axis because Columns are vertical (the cross axis would be
                  // horizontal).
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Padding(
                                padding: EdgeInsets.only(
                                    top: 50.0, left: 15.0, bottom: 10.0),
                                child: Icon(
                                  Icons.clear,
                                  size: 30.0,
                                ))),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 50.0, left: 30.0, right: 15.0, bottom: 10),
                          child: Text(
                            "Ajout d'une Propriété",
                            style: TextStyle(
                                fontFamily: "Sofia",
                                fontSize: 22.0,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                      ],
                    ),
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
                              overlayShadowColors:
                                  Colors.white.withOpacity(0.1),
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
                    IconStepper(
                      // enableNextPreviousButtons: false,
                      activeStepColor: Colors.redAccent,

                      steppingEnabled: true,
                      icons: [
                        Icon(Icons.add_location),
                        Icon(Icons.monetization_on_outlined),
                        Icon(Icons.grade_outlined),
                        Icon(Icons.tab_outlined),
                        Icon(Icons.picture_in_picture_outlined),
                        Icon(Icons.image)
                      ],

                      // activeStep property set to activeStep variable defined above.
                      activeStep: activeStep,
                      // activeStepColor: Colors.accents,
                      // bound receives value from upperBound.
                      upperBound: (bound) => upperBound = bound,

                      // This ensures step-tapping updates the activeStep.
                      onStepReached: (index) {
                        setState(() {
                          // activeStep = index;
                        });
                      },
                    ),
                    header(),
                    Container(
                      height: MediaQuery.of(context).size.height - 470,
                      child: ListView(children: <Widget>[
                        Stack(
                            alignment: AlignmentDirectional.bottomCenter,
                            children: <Widget>[
                              //child: Text('$activeStep'),

                              contain(activeStep),
                            ])
                      ]),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          activeStep > 0 ? previousButton() : Container(),
                          activeStep < 5 ? nextButton() : submitFunction(),
                        ],
                      ),
                    ),
                  ]),
              showPageLoader ? _showPageLoader() : Container(),
            ]),
          ),
        ),
      ),
    );
  }

  String validateVille(String value) {
    _vile = value;
    if (value.length < 3)
      return "Veuillez renseigner la ville";
    else
      return null;
  }

  String validateQuart(String value) {
    _quartier = value;
    if (value.length < 3)
      return "Veuillez renseigner le quartier";
    else
      return null;
  }

  String validateZone(String value) {
    _zone = value;
    if (value.length < 3)
      return "Veuillez renseigner la zone";
    else
      return null;
  }

  String validatePrix(String value) {
    _prix = value;
    if (value.length < 3)
      return "Veuillez renseigner le prix";
    else
      return null;
  }

  String validateCapa(String value) {
    _capacit = value;
    if (value.length < 3)
      return "Veuillez renseigner la Capacité";
    else
      return null;
  }

  String validateDescripfr(String value) {
    descfr = value;
    if (value.length < 3)
      return "Veuillez renseigner le champ";
    else
      return null;
  }

  String validateDescripen(String value) {
    descen = value;
    if (value.length < 3)
      return "Veuillez renseigner le champ";
    else
      return null;
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
    _password0 = value;

    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context).pas_error;
    } else {
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
    bool hasSpecialCharacters =
        password.contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    bool hasMinLength = password.length > minLength;

    return hasDigits &
        hasUppercase &
        hasLowercase &
        hasSpecialCharacters &
        hasMinLength;
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
      if (!(value == _password0))
        return AppLocalizations.of(context).passss_error;
      else
        return null;
    }
  }

  Widget nextButton() {
    return ElevatedButton(
      onPressed: () {
        // Increment activeStep, when the next button is tapped. However, check for upper bound.
        if (activeStep < upperBound) {
          setState(() {
            activeStep == 0
                ? _validateInputs0()
                : activeStep == 1
                    ? _validateInputs1()
                    : activeStep == 2
                        ? _validateInputs2()
                        : activeStep == 3
                            ? _validateInputs3()
                            : activeStep == 4
                                ? _validateInputs0()
                                : activeStep == 5
                                    ? _validateInputs0()
                                    : activeStep++;
          });
        }
      },
      child: Text('Suivant'),
    );
  }

  Widget submitFunction() {
    return ElevatedButton(
      onPressed: () {
        startPayment();
        print(vtype);
        String vvtype;
        String vvacces;
        String vvstand;
        String vvperi;
        String vvnive;

        if (vtype == "Appartement meublé") {
          vvtype = "apm";
        } else {
          if (vtype == "Appartement non meublé") {
            vvtype = "apnm";
          } else {
            if (vtype == "Chambre meublée") {
              vvtype = "chm";
            } else {
              if (vtype == "Chambre non meublé") {
                vvtype = "chnm";
              } else {
                if (vtype == "Studio meublée") {
                  vvtype = "stm";
                } else {
                  vvtype = "stnm";
                }
              }
            }
          }
        }

        if (vaces == "Facile") {
          vvacces = "f";
        } else {
          if (vaces == "Moyen") {
            vvacces = "m";
          } else {
            vvacces = "d";
          }
        }
        if (vperiode == "Jours") {
          vvperi = "jr";
        } else {
          if (vperiode == "Semaine") {
            vvperi = "se";
          } else {
            if (vperiode == "Mois") {
              vvperi = "mo";
            } else {
              vvperi = "an";
            }
          }
        }
        if (vniveaus == "Haut") {
          vvnive = "h";
        } else {
          if (vniveaus == "Moyen") {
            vvnive = "m";
          } else {
            vvnive = "b";
          }
        }

        if (vstantding == "Haut") {
          vvstand = "h";
        } else {
          if (vstantding == "Moyen") {
            vvstand = "m";
          } else {
            vvstand = "b";
          }
        }
        var rng = new Random();

        _id = rng.nextInt(1000000000).toString();
        print(vvtype);
        print(_id);

        HttpPostRequest.save_hebergement(
                _id,
                vvtype,
                _vile,
                _quartier,
                _zone,
                confirmedNumber,
                vvperi,
                _prix,
                _capacit,
                vvacces,
                vvnive,
                vvstand,
                descfr,
                descen,
                widget.userinfo.idu,
                clim,
                barri,
                internet,
                parki,
                eauch,
                clautu,
                ascenseur,
                groupe,
                piscin,
                wifi,
                gard,
                tera,
                fileImageArray)
            .then((String result) {
          if (result == "error") {
            // errorTransaction();
          } else {
            if (result == "exit") {
              // compteExit();
            } else {
              //  sucessTansaction();

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => new Listprouser(widget.userinfo)),
                (Route<dynamic> route) => false,
              );
            }
          }
        });
      },
      child: Text('Enregistrer'),
    );
  }

  /// Returns the previous button.
  Widget previousButton() {
    return ElevatedButton(
      onPressed: () {
        // Decrement activeStep, when the previous button is tapped. However, check for lower bound i.e., must be greater than 0.
        if (activeStep > 0) {
          setState(() {
            activeStep--;
          });
        }
      },
      child: Text('Précedent'),
    );
  }

  /// Returns the header wrapping the header text.
  Widget header() {
    return Container(
      margin: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
      decoration: BoxDecoration(
        color: Colors.blue[400],
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              headerText(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget contain(position) {
    return position == 0
        ? Padding(
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
                  FadeAnimation(
                      1.7,
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(26, 117, 255, 0.3),
                                blurRadius: 20,
                                offset: Offset(0, 10),
                              )
                            ]),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: [
                                Container(
                                  width: 20.0,
                                  padding: EdgeInsets.all(10),
                                  margin: EdgeInsets.fromLTRB(0, 0, 25.0, 0.0),
                                  child: Icon(
                                    Icons.location_city_outlined,
                                    color: Colors.black12,
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width - 85,
                                  padding: EdgeInsets.all(10),
                                  child: DropdownButtonFormField(
                                    isExpanded: true,
                                    validator: (value) => value == null
                                        ? 'Veuillez sélectioner le type'
                                        : null,
                                    hint: Text(
                                        'De quel type de proprietée s\'agit t\'il ?'),
                                    items: _typeb.map(
                                      (val) {
                                        return DropdownMenuItem(
                                          value: val,
                                          child: Text(val),
                                        );
                                      },
                                    ).toList(),
                                    value: vtype,
                                    onChanged: (value) {
                                      setState(() {
                                        vtype = value;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border: Border(
                                      top:
                                          BorderSide(color: Colors.grey[200]))),
                              child: TextFormField(
                                validator: validateVille,
                                controller: name,
                                onTap: _handlePressButton,
                                decoration: InputDecoration(
                                    hintText:
                                        "Dans quel vile est-elle situer ?",
                                    icon: Icon(
                                      Icons.add_location_outlined,
                                      color: Colors.black12,
                                    ),
                                    hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontFamily: "sofia")),
                                onSaved: (String val) {
                                  _vile = val;
                                },
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border: Border(
                                      top:
                                          BorderSide(color: Colors.grey[200]))),
                              child: TextFormField(
                                validator: validateQuart,
                                initialValue: _quartier,
                                decoration: InputDecoration(
                                    hintText: "Quartier ?",
                                    icon: Icon(
                                      Icons.add_location,
                                      color: Colors.black12,
                                    ),
                                    hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontFamily: "sofia")),
                                onSaved: (String val) {
                                  _quartier = val;
                                },
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border: Border(
                                      top:
                                          BorderSide(color: Colors.grey[200]))),
                              child: TextFormField(
                                validator: validateZone,
                                initialValue: _zone,
                                decoration: InputDecoration(
                                    hintText: "Zone ?",
                                    icon: Icon(
                                      Icons.add_location_alt_outlined,
                                      color: Colors.black12,
                                    ),
                                    hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontFamily: "sofia")),
                                onSaved: (String val) {
                                  _zone = val;
                                },
                              ),
                            ),
                          ],
                        ),
                      )),
                  SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ))
        : position == 1
            ? Padding(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20.0,
                ),
                child: new Form(
                  key: _formkey1,
                  autovalidate: _autoValidate1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      FadeAnimation(
                          1.9,
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromRGBO(26, 117, 255, 0.3),
                                    blurRadius: 20,
                                    offset: Offset(0, 10),
                                  )
                                ]),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(10),
                                  child: InternationalPhoneInput(
                                    onPhoneNumberChange: onPhoneNumberChange,
                                    initialSelection: phoneIsoCode,
                                    initialPhoneNumber: phoneNumber,
                                    errorText:
                                        AppLocalizations.of(context).tel_error,
                                    hintText: AppLocalizations.of(context).tel,
                                    showCountryCodes: false,
                                    showCountryFlags: true,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width: 20.0,
                                      padding: EdgeInsets.all(10),
                                      margin:
                                          EdgeInsets.fromLTRB(0, 0, 20.0, 0.0),
                                      child: Icon(
                                        Icons.location_city_outlined,
                                        color: Colors.black12,
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width -
                                          85,
                                      padding: EdgeInsets.all(10),
                                      child: DropdownButtonFormField(
                                        isExpanded: true,
                                        hint: Text(
                                            'Quel est la période de location'),
                                        items: _periode.map(
                                          (val) {
                                            return DropdownMenuItem(
                                              value: val,
                                              child: Text(val),
                                            );
                                          },
                                        ).toList(),
                                        value: vperiode,
                                        validator: (value) => value == null
                                            ? 'Veuillez sélectioner une période'
                                            : null,
                                        onChanged: (value) {
                                          setState(() {
                                            vperiode = value;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          top: BorderSide(
                                              color: Colors.grey[200]))),
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    validator: validatePrix,
                                    initialValue: _prix,
                                    decoration: InputDecoration(
                                        hintText: "Quel est le prix ?",
                                        icon: Icon(
                                          Icons.monetization_on_outlined,
                                          color: Colors.black12,
                                        ),
                                        hintStyle: TextStyle(
                                            color: Colors.grey,
                                            fontFamily: "sofia")),
                                    onSaved: (String val) {
                                      _prix = val;
                                    },
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          top: BorderSide(
                                              color: Colors.grey[200]))),
                                  child: TextFormField(
                                    validator: validateCapa,
                                    initialValue: _capacit,
                                    decoration: InputDecoration(
                                        hintText:
                                            "Quel est la Capacité( ou superficie) ?",
                                        icon: Icon(
                                          Icons.map_outlined,
                                          color: Colors.black12,
                                        ),
                                        hintStyle: TextStyle(
                                            color: Colors.grey,
                                            fontFamily: "sofia")),
                                    onSaved: (String val) {
                                      _capacit = val;
                                    },
                                  ),
                                )
                              ],
                            ),
                          )),
                      SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                ))
            : position == 2
                ? Padding(
                    padding: EdgeInsets.only(
                      left: 20,
                      right: 20.0,
                    ),
                    child: new Form(
                      key: _formkey2,
                      autovalidate: _autoValidate,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          FadeAnimation(
                              1.9,
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Color.fromRGBO(26, 117, 255, 0.3),
                                        blurRadius: 20,
                                        offset: Offset(0, 10),
                                      )
                                    ]),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey[200]))),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 20.0,
                                            padding: EdgeInsets.all(10),
                                            margin: EdgeInsets.fromLTRB(
                                                0, 0, 20.0, 0.0),
                                            child: Icon(
                                              Icons.edit_road,
                                              color: Colors.black12,
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                85,
                                            padding: EdgeInsets.all(10),
                                            child: DropdownButtonFormField(
                                              isExpanded: true,
                                              validator: (value) =>
                                                  value == null
                                                      ? 'Veuillez sélectioner'
                                                      : null,
                                              hint:
                                                  Text('comment est l\'accès'),
                                              items: _aces.map(
                                                (val) {
                                                  return DropdownMenuItem(
                                                    value: val,
                                                    child: Text(val),
                                                  );
                                                },
                                              ).toList(),
                                              value: vaces,
                                              onChanged: (value) {
                                                setState(() {
                                                  vaces = value;
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey[200]))),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 20.0,
                                            padding: EdgeInsets.all(10),
                                            margin: EdgeInsets.fromLTRB(
                                                0, 0, 20.0, 0.0),
                                            child: Icon(
                                              Icons.lock_outline,
                                              color: Colors.black12,
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                85,
                                            padding: EdgeInsets.all(10),
                                            child: DropdownButtonFormField(
                                              isExpanded: true,
                                              validator: (value) =>
                                                  value == null
                                                      ? 'Veuillez sélectioner'
                                                      : null,
                                              hint: Text(
                                                  'Quel est le niveau de sécurité'),
                                              items: niveauss.map(
                                                (val) {
                                                  return DropdownMenuItem(
                                                    value: val,
                                                    child: Text(val),
                                                  );
                                                },
                                              ).toList(),
                                              value: vniveaus,
                                              onChanged: (value) {
                                                setState(() {
                                                  vniveaus = value;
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey[200]))),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 20.0,
                                            padding: EdgeInsets.all(10),
                                            margin: EdgeInsets.fromLTRB(
                                                0, 0, 20.0, 0.0),
                                            child: Icon(
                                              Icons.hd_outlined,
                                              color: Colors.black12,
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                85,
                                            padding: EdgeInsets.all(10),
                                            child: DropdownButtonFormField(
                                              isExpanded: true,
                                              validator: (value) =>
                                                  value == null
                                                      ? 'Veuillez sélectioner'
                                                      : null,
                                              hint:
                                                  Text('Quel est le standing'),
                                              items: stanting.map(
                                                (val) {
                                                  return DropdownMenuItem(
                                                    value: val,
                                                    child: Text(val),
                                                  );
                                                },
                                              ).toList(),
                                              value: vstantding,
                                              onChanged: (value) {
                                                setState(() {
                                                  vstantding = value;
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                          SizedBox(
                            height: 40,
                          ),
                        ],
                      ),
                    ))
                : position == 3
                    ? Padding(
                        padding: EdgeInsets.only(
                          left: 20,
                          right: 20.0,
                        ),
                        child: new Form(
                          key: _formkey3,
                          autovalidate: _autoValidate,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              FadeAnimation(
                                  1.9,
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color.fromRGBO(
                                                26, 117, 255, 0.3),
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
                                                  top: BorderSide(
                                                      color:
                                                          Colors.grey[200]))),
                                          child: TextFormField(
                                            validator: validateDescripfr,
                                            initialValue: descfr,
                                            maxLines: 6,
                                            decoration: InputDecoration(
                                                hintText:
                                                    "Description en Français",
                                                icon: Icon(
                                                  Icons.map_outlined,
                                                  color: Colors.black12,
                                                ),
                                                hintStyle: TextStyle(
                                                    color: Colors.grey,
                                                    fontFamily: "sofia")),
                                            onSaved: (String val) {
                                              descfr = val;
                                            },
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  top: BorderSide(
                                                      color:
                                                          Colors.grey[200]))),
                                          child: TextFormField(
                                            validator: validateDescripen,
                                            maxLines: 6,
                                            initialValue: descen,
                                            decoration: InputDecoration(
                                                hintText:
                                                    "Description en Anglais",
                                                icon: Icon(
                                                  Icons.map_outlined,
                                                  color: Colors.black12,
                                                ),
                                                hintStyle: TextStyle(
                                                    color: Colors.grey,
                                                    fontFamily: "sofia")),
                                            onSaved: (String val) {
                                              descen = val;
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                              SizedBox(
                                height: 40,
                              ),
                            ],
                          ),
                        ))
                    : position == 4
                        ? Padding(
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
                                  FadeAnimation(
                                      1.9,
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color.fromRGBO(
                                                    26, 117, 255, 0.3),
                                                blurRadius: 20,
                                                offset: Offset(0, 10),
                                              )
                                            ]),
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              decoration: BoxDecoration(
                                                  border: Border(
                                                      bottom: BorderSide(
                                                          color: Colors
                                                              .grey[200]))),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width:
                                                        (MediaQuery.of(context)
                                                                    .size
                                                                    .width -
                                                                60) /
                                                            2,
                                                    padding: EdgeInsets.all(10),
                                                    margin: EdgeInsets.fromLTRB(
                                                        0, 0, 20.0, 0.0),
                                                    child: CheckboxListTile(
                                                      title: Text("Barrière"),
                                                      value: barri,
                                                      onChanged: (newValue) {
                                                        setState(() {
                                                          barri = newValue;
                                                        });
                                                      },
                                                      controlAffinity:
                                                          ListTileControlAffinity
                                                              .leading, //  <-- leading Checkbox
                                                    ),
                                                  ),
                                                  Container(
                                                    width:
                                                        (MediaQuery.of(context)
                                                                    .size
                                                                    .width -
                                                                60) /
                                                            2,
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            0, 0, 0, 0),
                                                    child: CheckboxListTile(
                                                      title: Text("Internet"),
                                                      value: internet,
                                                      onChanged: (newValue) {
                                                        setState(() {
                                                          internet = newValue;
                                                        });
                                                      },
                                                      controlAffinity:
                                                          ListTileControlAffinity
                                                              .leading, //  <-- leading Checkbox
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                  border: Border(
                                                      bottom: BorderSide(
                                                          color: Colors
                                                              .grey[200]))),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width:
                                                        (MediaQuery.of(context)
                                                                    .size
                                                                    .width -
                                                                60) /
                                                            2,
                                                    padding: EdgeInsets.all(10),
                                                    margin: EdgeInsets.fromLTRB(
                                                        0, 0, 20.0, 0.0),
                                                    child: CheckboxListTile(
                                                      title: Text("Parking"),
                                                      value: parki,
                                                      onChanged: (newValue) {
                                                        setState(() {
                                                          parki = newValue;
                                                        });
                                                      },
                                                      controlAffinity:
                                                          ListTileControlAffinity
                                                              .leading, //  <-- leading Checkbox
                                                    ),
                                                  ),
                                                  Container(
                                                    width:
                                                        (MediaQuery.of(context)
                                                                    .size
                                                                    .width -
                                                                60) /
                                                            2,
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            0, 0, 0, 0),
                                                    child: CheckboxListTile(
                                                      title: Text("Eau chaude"),
                                                      value: eauch,
                                                      onChanged: (newValue) {
                                                        setState(() {
                                                          eauch = newValue;
                                                        });
                                                      },
                                                      controlAffinity:
                                                          ListTileControlAffinity
                                                              .leading, //  <-- leading Checkbox
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                  border: Border(
                                                      bottom: BorderSide(
                                                          color: Colors
                                                              .grey[200]))),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width:
                                                        (MediaQuery.of(context)
                                                                    .size
                                                                    .width -
                                                                60) /
                                                            2,
                                                    padding: EdgeInsets.all(10),
                                                    margin: EdgeInsets.fromLTRB(
                                                        0, 0, 20.0, 0.0),
                                                    child: CheckboxListTile(
                                                      title: Text("Cloture"),
                                                      value: clautu,
                                                      onChanged: (newValue) {
                                                        setState(() {
                                                          clautu = newValue;
                                                        });
                                                      },
                                                      controlAffinity:
                                                          ListTileControlAffinity
                                                              .leading, //  <-- leading Checkbox
                                                    ),
                                                  ),
                                                  Container(
                                                    width:
                                                        (MediaQuery.of(context)
                                                                    .size
                                                                    .width -
                                                                60) /
                                                            2,
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            0, 0, 0, 0),
                                                    child: CheckboxListTile(
                                                      title: Text("Ascenseur"),
                                                      value: ascenseur,
                                                      onChanged: (newValue) {
                                                        setState(() {
                                                          ascenseur = newValue;
                                                        });
                                                      },
                                                      controlAffinity:
                                                          ListTileControlAffinity
                                                              .leading, //  <-- leading Checkbox
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                  border: Border(
                                                      bottom: BorderSide(
                                                          color: Colors
                                                              .grey[200]))),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width:
                                                        (MediaQuery.of(context)
                                                                    .size
                                                                    .width -
                                                                60) /
                                                            2,
                                                    padding: EdgeInsets.all(10),
                                                    margin: EdgeInsets.fromLTRB(
                                                        0, 0, 20.0, 0.0),
                                                    child: CheckboxListTile(
                                                      title: Text(
                                                          "Groupe électrogène"),
                                                      value: groupe,
                                                      onChanged: (newValue) {
                                                        setState(() {
                                                          groupe = newValue;
                                                        });
                                                      },
                                                      controlAffinity:
                                                          ListTileControlAffinity
                                                              .leading, //  <-- leading Checkbox
                                                    ),
                                                  ),
                                                  Container(
                                                    width:
                                                        (MediaQuery.of(context)
                                                                    .size
                                                                    .width -
                                                                60) /
                                                            2,
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            0, 0, 0, 0),
                                                    child: CheckboxListTile(
                                                      title: Text("Piscine"),
                                                      value: piscin,
                                                      onChanged: (newValue) {
                                                        setState(() {
                                                          piscin = newValue;
                                                        });
                                                      },
                                                      controlAffinity:
                                                          ListTileControlAffinity
                                                              .leading, //  <-- leading Checkbox
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                  border: Border(
                                                      bottom: BorderSide(
                                                          color: Colors
                                                              .grey[200]))),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width:
                                                        (MediaQuery.of(context)
                                                                    .size
                                                                    .width -
                                                                60) /
                                                            2,
                                                    padding: EdgeInsets.all(10),
                                                    margin: EdgeInsets.fromLTRB(
                                                        0, 0, 20.0, 0.0),
                                                    child: CheckboxListTile(
                                                      title: Text("wi-fi"),
                                                      value: wifi,
                                                      onChanged: (newValue) {
                                                        setState(() {
                                                          wifi = newValue;
                                                        });
                                                      },
                                                      controlAffinity:
                                                          ListTileControlAffinity
                                                              .leading, //  <-- leading Checkbox
                                                    ),
                                                  ),
                                                  Container(
                                                    width:
                                                        (MediaQuery.of(context)
                                                                    .size
                                                                    .width -
                                                                60) /
                                                            2,
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            0, 0, 0, 0),
                                                    child: CheckboxListTile(
                                                      title: Text("Gardien"),
                                                      value: gard,
                                                      onChanged: (newValue) {
                                                        setState(() {
                                                          gard = newValue;
                                                        });
                                                      },
                                                      controlAffinity:
                                                          ListTileControlAffinity
                                                              .leading, //  <-- leading Checkbox
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                  border: Border(
                                                      bottom: BorderSide(
                                                          color: Colors
                                                              .grey[200]))),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width:
                                                        (MediaQuery.of(context)
                                                                    .size
                                                                    .width -
                                                                60) /
                                                            2,
                                                    padding: EdgeInsets.all(10),
                                                    margin: EdgeInsets.fromLTRB(
                                                        0, 0, 20.0, 0.0),
                                                    child: CheckboxListTile(
                                                      title:
                                                          Text("Climatisation"),
                                                      value: clim,
                                                      onChanged: (newValue) {
                                                        setState(() {
                                                          clim = newValue;
                                                        });
                                                      },
                                                      controlAffinity:
                                                          ListTileControlAffinity
                                                              .leading, //  <-- leading Checkbox
                                                    ),
                                                  ),
                                                  Container(
                                                    width:
                                                        (MediaQuery.of(context)
                                                                    .size
                                                                    .width -
                                                                60) /
                                                            2,
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            0, 0, 0, 0),
                                                    child: CheckboxListTile(
                                                      title: Text("Térasse"),
                                                      value: tera,
                                                      onChanged: (newValue) {
                                                        setState(() {
                                                          tera = newValue;
                                                        });
                                                      },
                                                      controlAffinity:
                                                          ListTileControlAffinity
                                                              .leading, //  <-- leading Checkbox
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      )),
                                  SizedBox(
                                    height: 40,
                                  ),
                                ],
                              ),
                            ))
                        : position == 5
                            ? Padding(
                                padding: EdgeInsets.only(
                                  left: 20,
                                  right: 20.0,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Center(
                                      child: RaisedButton(
                                        child: Text("Sélectionner les images"),
                                        color: Colors.blue[400],
                                        textColor: Colors.white,
                                        onPressed: loadAssets,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                        top: 20,
                                      ),
                                      height: 350,
                                      width: MediaQuery.of(context).size.width,
                                      child: imagesss.length > 0
                                          ? buildGridView()
                                          : Container(
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: CachedNetworkImageProvider(
                                                          "https://www.sleepmoh.com/flutterimg/hoome.png"),
                                                      fit: BoxFit.scaleDown)),
                                            ),
                                    ),
                                  ],
                                ),
                              )
                            : Container();
  }

  // Returns the header text based on the activeStep.
  String headerText() {
    switch (activeStep) {
      case 1:
        return 'Détails';

      case 2:
        return 'Standing';

      case 3:
        return 'Description';

      case 4:
        return 'Options disponible';

      case 5:
        return 'Images';

      default:
        return 'Localisation';
    }
  }

  void _validateInputs() {
    if (_formkey0.currentState.validate()) {
//    If all data are correct then save data to out variables
      _formkey0.currentState.save();
      _displayDialog(context, confirmedNumber);
      print(code);
      HttpPostRequest.sendMessage(confirmedNumber, code)
          .then((String result) async {
        //  initPlatformState(code);

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

      //widget.notifyParent();
      //log(_email);
    } else {
//    If all data are not valid then start auto validation.
      setState(() {
        _autoValidate = true;
      });
    }
  }

  void _validateInputs0() {
    // startPayment();
    if (_formkey0.currentState.validate()) {
//    If all data are correct then save data to out variables
      _formkey0.currentState.save();

      print(_quartier);
      activeStep++;

      //widget.notifyParent();
      //log(_email);
    } else {
//    If all data are not valid then start auto validation.
      setState(() {
        _autoValidate = true;
      });
    }
  }

  void _validateInputs1() {
    // startPayment();

    if (_formkey1.currentState.validate()) {
//    If all data are correct then save data to out variables
      _formkey1.currentState.save();

      // print("activeStep");
      activeStep++;

      //widget.notifyParent();
      //log(_email);
    } else {
//    If all data are not valid then start auto validation.
      setState(() {
        _autoValidate1 = true;
      });
    }
  }

  void _validateInputs2() {
    // startPayment();

    if (_formkey2.currentState.validate()) {
//    If all data are correct then save data to out variables
      _formkey2.currentState.save();

      // print("activeStep");
      activeStep++;

      //widget.notifyParent();
      //log(_email);
    } else {
//    If all data are not valid then start auto validation.
      setState(() {
        _autoValidate1 = true;
      });
    }
  }

  void _validateInputs3() {
    // startPayment();

    if (_formkey3.currentState.validate()) {
//    If all data are correct then save data to out variables
      _formkey3.currentState.save();

      // print("activeStep");
      activeStep++;

      //widget.notifyParent();
      //log(_email);
    } else {
//    If all data are not valid then start auto validation.
      setState(() {
        _autoValidate1 = true;
      });
    }
  }

  void _validateInputs10() {
    Navigator.of(context).pop();
//    If all data are correct then save data to out variables

    startPayment();
    netErrorTransaction();

    HttpPostRequest.register_request(
            phoneNumber, confirmedNumber, phoneIsoCode, _name, _password0)
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

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => new bottomNavBar()),
            (Route<dynamic> route) => false,
          );
        }
      }
    });

    //widget.notifyParent();
    //log(_email);
  }

  Widget _buildDropdownMenu() => DropdownButton(
        value: _mode,
        items: <DropdownMenuItem<Mode>>[
          DropdownMenuItem<Mode>(
            child: Text("Overlay"),
            value: Mode.overlay,
          ),
          DropdownMenuItem<Mode>(
            child: Text("Fullscreen"),
            value: Mode.fullscreen,
          ),
        ],
        onChanged: (m) {
          setState(() {
            _mode = m;
          });
        },
      );

  void onError(PlacesAutocompleteResponse response) {
    homeScaffoldKey.currentState.showSnackBar(
      SnackBar(content: Text(response.errorMessage)),
    );
  }

  Future<void> _handlePressButton() async {
    // show input autocomplete with selected mode
    // then get the Prediction selected
    Prediction p = await PlacesAutocomplete.show(
        context: context,
        apiKey: kGoogleApiKey,
        onError: onError,
        mode: _mode,
        language: "fr",
        components: [new Component(Component.country, "cmr")]);

    displayPrediction(p, homeScaffoldKey.currentState);
  }

  Future<Null> displayPrediction(Prediction p, ScaffoldState scaffold) async {
    if (p != null) {
      // get detail (lat/lng)
      PlacesDetailsResponse detail =
          await _places.getDetailsByPlaceId(p.placeId);
      final lat = detail.result.geometry.location.lat;
      final lng = detail.result.geometry.location.lng;

      print("vovivi");
      print(detail.result.addressComponents.first.shortName);
      _name = detail.result.addressComponents.first.shortName;
      name.text = detail.result.addressComponents.first.shortName;
      scaffold.showSnackBar(
        SnackBar(content: Text("${p.description} - $lat/$lng")),
      );
    }
  }
}
