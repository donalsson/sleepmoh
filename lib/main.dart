import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sleepmohapp/DataSample/HebergementsModel.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:sleepmohapp/DataSample/HotelModel.dart';
import 'package:sleepmohapp/DataSample/ImmobModel.dart';
import 'package:sleepmohapp/DataSample/MaisonModel.dart';
import 'package:sleepmohapp/DataSample/TerrainModel.dart';
import 'package:sleepmohapp/DataSample/TourismeModel.dart';
import 'package:sleepmohapp/DataSample/EntreMod.dart';
import 'package:sleepmohapp/DataSample/ConversMod.dart';
import 'package:sleepmohapp/UI/IntroApps/OnBoarding.dart';
import 'package:flutter/services.dart';
import 'package:sleepmohapp/core/httpreq.dart';
import 'package:sleepmohapp/core/localizations.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'DataSample/ImagesModel.dart';
import 'package:sleepmohapp/DataSample/UserMod.dart';
import 'UI/Bottom_Nav_Bar/bottomNavBar.dart';
import 'core/LocaleHelper.dart';
import 'core/preference.dart';
import 'core/global.dart' as globals;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final FirebaseMessaging _fcm = FirebaseMessaging();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String userToken = prefs.get('FCMToken');
  if (userToken == null) {
    _fcm.getToken().then((val) async {
      print('Token: ' + val);
      prefs.setString('FCMToken', val);
    });
  } else {
    print('Token: ' + userToken);
  }
  await SharedPreferencesClass.restoreuser("userinfos").then((value) {
    var userinfos = new List<UserMod>();
    if (value != "") {
      compteU = true;
      log('value');
      log(value);
      Iterable list0 = jsonDecode(value);
       userinfos = list0.map((model) => UserMod.fromJson(model)).toList();
       globals.userinfos = userinfos[0];
      HttpPostRequest.getAllHebergementsUser(userinfos[0].idu)
          .then((List<HerbergemntMod> result) {
        if (result.length > 5) {
          log('savelistTot-Heberge');
          // SharedPreferencesClass.save('listHotel1', result);
        }
      });
      HttpPostRequest.getAllConvers(userinfos[0].login)
          .then((List<ConversMod> result) {
        if (result.length > 0) {
          log('savelist-Converssations');
          // SharedPreferencesClass.save('listHotel1', result);
        }
      });
    }
  });

  await SharedPreferencesClass.restore("initial").then((value) {
    SharedPreferencesClass.save("initial", true);
    if (value) {
      HttpPostRequest.getAllHotels().then((List<Hotelht> result) {
       
        if (result.length > 5) {
          log('savelistTot-Hotel');
        }
      });

      HttpPostRequest.getAllTourisme().then((List<Tourisme> result) {
        if (result.length > 5) {
          log('savelistTot-Tourisme');
        }
      });

      HttpPostRequest.getAllHebergements().then((List<HerbergemntMod> result) {
        if (result.length > 5) {
          log('savelistTot-Heberge');
          // SharedPreferencesClass.save('listHotel1', result);
        }
      });

      HttpPostRequest.getAllImages().then((List<Imagem> result) {
        if (result.length > 5) {
          log('savelistTot-Images');
          //SharedPreferencesClass.save('listHotel1', result);
        }
      });

      HttpPostRequest.getAllImobi().then((List<ImmobMod> result) {
        if (result.length > 5) {
          log('savelistTot-Immo');
          //SharedPreferencesClass.save('listHotel1', result);
        }
      });

      HttpPostRequest.getAllTerrain().then((List<TerrainMod> result) {
        if (result.length > 5) {
          log('savelistTot-Terrain');
          //SharedPreferencesClass.save('listHotel1', result);
        }
      });

      HttpPostRequest.getAllMaison().then((List<MaisonMod> result) {
        if (result.length > 5) {
          log('savelistTot-Maison');
          //SharedPreferencesClass.save('listHotel1', result);
        }
      });

      HttpPostRequest.getAllEntre().then((List<EntreMod> result) {
        if (result.length > 5) {
          log('savelistTot-Entre');
          //SharedPreferencesClass.save('listHotel1', result);
        }
      });

      runApp(
        Phoenix(
          child: HomePage(),
        ),
      );
      // runApp(First())

    } else {
      HttpPostRequest.getlimitHotels().then((List<Hotelht> result) {
        if (result.length > 5) {
          log('savelistLim-Hotel');
          //  SharedPreferencesClass.save('listHotel1', result);
        }
      });

      HttpPostRequest.getlimitHebergements()
          .then((List<HerbergemntMod> result) {
        if (result.length > 5) {
          log('savelistLim-Heberge');
          // SharedPreferencesClass.save('listHotel1', result);
        }
      });

      HttpPostRequest.getlimitTourisme().then((List<Tourisme> result) {
        if (result.length > 5) {
          log('savelistLim-Tourisme');
          // SharedPreferencesClass.save('listHotel1', result);
        }
      });
      HttpPostRequest.getAllImages().then((List<Imagem> result) {
        if (result.length > 5) {
          log('savelistTot-Images');
          // SharedPreferencesClass.save('listHotel1', result);
        }
      });

      HttpPostRequest.getlimitImobi().then((List<ImmobMod> result) {
        if (result.length > 5) {
          log('savelistLim-Imob');
          // SharedPreferencesClass.save('listHotel1', result);
        }
      });
      HttpPostRequest.getlimitMaison().then((List<MaisonMod> result) {
        if (result.length > 5) {
          log('savelistLim-Maiso');
          // SharedPreferencesClass.save('listHotel1', result);
        }
      });
      HttpPostRequest.getlimitTerrain().then((List<TerrainMod> result) {
        if (result.length > 5) {
          log('savelistLim-Trrain');
          // SharedPreferencesClass.save('listHotel1', result);
        }
      });
      HttpPostRequest.getlimitEntre().then((List<EntreMod> result) {
        if (result.length > 5) {
          log('savelistLim-Entre');
          // SharedPreferencesClass.save('listHotel1', result);
        }
      });

      HttpPostRequest.getAllHotels().then((List<Hotelht> result) {
        if (result.length > 5) {
          log('savelistTot-Hotel');
          // SharedPreferencesClass.save('listHotel1', result);
        }
      });

      HttpPostRequest.getAllTourisme().then((List<Tourisme> result) {
        if (result.length > 5) {
          log('savelistTot-Tourisme');
          // SharedPreferencesClass.save('listHotel1', result);
        }
      });

      HttpPostRequest.getAllHebergements().then((List<HerbergemntMod> result) {
        if (result.length > 5) {
          log('savelistTot-Heberge');
          //  SharedPreferencesClass.save('listHotel1', result);
        }
      });

      HttpPostRequest.getAllMaison().then((List<MaisonMod> result) {
        if (result.length > 5) {
          log('savelistTot-Maison');
          //  SharedPreferencesClass.save('listHotel1', result);
        }
      });

      HttpPostRequest.getAllTerrain().then((List<TerrainMod> result) {
        if (result.length > 5) {
          log('savelistTot-Terrain');
          //  SharedPreferencesClass.save('listHotel1', result);
        }
      });
      HttpPostRequest.getAllImobi().then((List<ImmobMod> result) {
        if (result.length > 5) {
          log('savelistTot-Immo');
          //  SharedPreferencesClass.save('listHotel1', result);
        }
      });
      HttpPostRequest.getAllEntre().then((List<EntreMod> result) {
        if (result.length > 5) {
          log('savelistTot-Entre');
          //SharedPreferencesClass.save('listHotel1', result);
        }
      });

      runApp(First());
    }
  });
}

class HomePage extends StatefulWidget {
  @override
  _HomePageAppState createState() => _HomePageAppState();
}

class _HomePageAppState extends State<HomePage> {
  SpecificLocalizationDelegate _specificLocalizationDelegate;

  @override
  void initState() {
    super.initState();
    helper.onLocaleChanged = onLocaleChange;

    _specificLocalizationDelegate =
        SpecificLocalizationDelegate(new Locale('en'));
  }

  onLocaleChange(Locale locale) {
    setState(() {
      _specificLocalizationDelegate = new SpecificLocalizationDelegate(locale);
    });
  }

  @override
  Widget build(BuildContext context) {
    LocaleHelper.restorelanguage();

    return MaterialApp(
      routes: {
        // When navigating to the "/plash" route, build the SecondScreen widget.
        '/startapp': (context) => bottomNavBar(),
      },
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        new FallbackCupertinoLocalisationsDelegate(),
        //app-specific localization
        _specificLocalizationDelegate
      ],
      supportedLocales: [Locale('en'), Locale('fr')],
      locale: _specificLocalizationDelegate.overriddenLocale,
      debugShowCheckedModeBanner: false,
      home: bottomNavBar(),
    );
  }
}

class First extends StatefulWidget {
  @override
  _FirstState createState() => _FirstState();
}

class _FirstState extends State<First> {
  SpecificLocalizationDelegate _specificLocalizationDelegate;

  @override
  void initState() {
    super.initState();
    helper.onLocaleChanged = onLocaleChange;
    _specificLocalizationDelegate =
        SpecificLocalizationDelegate(new Locale("en"));
  }

  onLocaleChange(Locale locale) {
    setState(() {
      //  log('mon message test');
      _specificLocalizationDelegate = new SpecificLocalizationDelegate(locale);
    });
  }

  @override
  Widget build(BuildContext context) {
    LocaleHelper.restorelanguage();
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        new FallbackCupertinoLocalisationsDelegate(),
        //app-specific localization
        _specificLocalizationDelegate
      ],
      supportedLocales: [Locale('en'), Locale('fr')],
      locale: _specificLocalizationDelegate.overriddenLocale,
      debugShowCheckedModeBanner: false,
      home: onBoarding(),
    );
  }
}

class splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ///Set color status bar
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent,
    ));

    /// To set orientation always portrait
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      home: onBoarding(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          primaryColorLight: Colors.red,
          primaryColorBrightness: Brightness.light,
          primaryColor: Colors.white),
    );
  }
}
