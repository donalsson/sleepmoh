import 'dart:developer';
import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';

typedef void LocaleChangeCallback(Locale locale);

class LocaleHelper {
  LocaleChangeCallback onLocaleChanged;

  static final LocaleHelper _helper = new LocaleHelper._internal();
  factory LocaleHelper() {
    return _helper;
  }

  static Future<LocaleHelper> restorelanguage() async {
     String langue;
     bool languec;
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
   // sharedPrefs.setBool('initialized', true);
    langue =  (sharedPrefs.get('langue') ?? 'fr');    
    languec =  (sharedPrefs.get('languecc') ?? true);
    log('language: $langue');
    if (languec){
      sharedPrefs.setBool('languecc', false);
      helper.onLocaleChanged(new Locale(langue));
    }
    
  }
   static Future<String> getCurent() async {
     String langue;
     bool languec;
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
   // sharedPrefs.setBool('initialized', true);
    langue =  (sharedPrefs.get('langue') ?? 'fr');    
    languec =  (sharedPrefs.get('languecc') ?? true);
    
    return langue;
    
  }
LocaleHelper._internal();
}

//LocaleHelper language = new LanguageChange();
LocaleHelper helper = new LocaleHelper();
