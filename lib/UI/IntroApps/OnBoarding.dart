import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sleepmohapp/Library/intro_views_flutter-2.4.0/lib/Models/page_view_model.dart';
import 'package:sleepmohapp/Library/intro_views_flutter-2.4.0/lib/intro_views_flutter.dart';
import 'package:sleepmohapp/UI/Bottom_Nav_Bar/bottomNavBar.dart';
import 'package:sleepmohapp/core/LocaleHelper.dart';
import 'package:sleepmohapp/core/localizations.dart';
import 'package:sleepmohapp/core/preference.dart';
import 'package:sleepmohapp/core/util.dart';


class onBoarding extends StatefulWidget {
  @override
  _onBoardingState createState() => _onBoardingState();
}

var _fontHeaderStyle = TextStyle(
    fontFamily: "Gotik",
    fontSize: 20.0,
    fontWeight: FontWeight.w800,
    color: Colors.black87,
    letterSpacing: 1.5);

var _fontDescriptionStyle = TextStyle(
    fontFamily: "Sans",
    fontSize: 15.0,
    color: Colors.black38,
    fontWeight: FontWeight.w400);

class _onBoardingState extends State<onBoarding> {
  @override
  Widget build(BuildContext context) {
    return IntroViewsFlutter(
      [
        
         PageViewModel(
           pageColor: Colors.white,
      iconColor: Colors.black,
      bubbleBackgroundColor: Colors.black,
        title:  Text(
        AppLocalizations.of(context).titre0,
        style: _fontHeaderStyle,
      ),
        body: Text(
          AppLocalizations.of(context).descrip0,
          textAlign: TextAlign.center,
          style: _fontDescriptionStyle),
        mainImage: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () {
              log("cool1");
              helper.onLocaleChanged(new Locale("fr"));
              
              SharedPreferencesClass.save('langue', 'fr');
            }, // handle your image tap here
            child: Image.asset('assets/image/onBoardingImage/france.png',
              fit: BoxFit.cover, // this is the solution for border
              width: 110.0,
              height: 110.0,
            ),),
            GestureDetector(
            onTap: () {
              log("cool");
              helper.onLocaleChanged(new Locale("en"));
              SharedPreferencesClass.save('langue', 'en');
            }, // handle your image tap here
            child: Image.asset('assets/image/onBoardingImage/anglais.png',
              fit: BoxFit.cover, // this is the solution for border
              width: 110.0,
              height: 110.0,
            ),),],
      ),
        textStyle: TextStyle(color: Colors.black),
    ),

  new PageViewModel(
      pageColor: Colors.white,
      iconColor: Colors.black,
      bubbleBackgroundColor: Colors.black,
      title: Text(
        AppLocalizations.of(context).dooo,
        style: _fontHeaderStyle,

      ),
      body: Text(
          AppLocalizations.of(context).small,
          textAlign: TextAlign.center,
          style: _fontDescriptionStyle),
      mainImage: Image.asset(
        'assets/image/onBoardingImage/image01.png',
        height: 285.0,
        width: 285.0,
        alignment: Alignment.center,
      )),

       new PageViewModel(
      pageColor: Colors.white,
      iconColor: Colors.black,
      bubbleBackgroundColor: Colors.black,
      title: Text(
        AppLocalizations.of(context).send,
        style: _fontHeaderStyle,
      ),
      body: Text(
          AppLocalizations.of(context).easy,
          textAlign: TextAlign.center,
          style: _fontDescriptionStyle),
      mainImage: Image.asset(
        'assets/image/onBoardingImage/image02.png',
        height: 285.0,
        width: 285.0,
        alignment: Alignment.center,
      )),
     
  new PageViewModel(
      pageColor: Colors.white,
      iconColor: Colors.black,
      bubbleBackgroundColor: Colors.black,
      title: Text(
          AppLocalizations.of(context).gere,
        style: _fontHeaderStyle,
      ),
      body: Text(
          AppLocalizations.of(context).mobile,
          textAlign: TextAlign.center,
          style: _fontDescriptionStyle),
      mainImage: Image.asset(
        'assets/image/onBoardingImage/image03.png',
        height: 285.0,
        width: 285.0,
        alignment: Alignment.center,
      )),
],
      pageButtonsColor: Colors.black45,
      skipText: Text(
        AppLocalizations.of(context).pass,
        style: _fontDescriptionStyle.copyWith(
            color: PaypalColors.Primary,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.0),
      ),
      doneText: Text(
        AppLocalizations.of(context).start,
        style: _fontDescriptionStyle.copyWith(
            color: PaypalColors.Primary,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.0),
      ),
      onTapDoneButton: () {
        print("goo");
        
        Navigator.of(context).pushReplacement(
            PageRouteBuilder(pageBuilder: (_, __, ___) => new bottomNavBar()));
      },
    );
  }
}
