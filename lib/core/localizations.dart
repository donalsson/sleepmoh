import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../i10n/messages_all.dart';

class AppLocalizations {
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static Future<AppLocalizations> load(Locale locale) {
    final String name =
        locale.countryCode == null ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((bool _) {
      Intl.defaultLocale = localeName;
      return new AppLocalizations();
    });
  }
 //iiin

  String get nameer {
    return Intl.message('Name must be more than 2 charater', name: 'nameer');
  }

  String get haveacc {
    return Intl.message('Avez vous un compte ? Connectez-vous', name: 'haveacc');
  }



 //iint

  String get title {
    return Intl.message('Contact Us', name: 'title');
  }

  String get listapp {
    return Intl.message('Liste des appartements', name: 'listapp');
  }

  String get liststu {
    return Intl.message('Liste des Studios', name: 'liststu');
  }

  String get listcham {
    return Intl.message('Liste des chambres', name: 'listcham');
  }

  String get tourisdest {
    return Intl.message('Le tourisme est un moyen important pour que différents pays et différentes cultures puissent communiquer ensemble, une façon efficace de développer l’économie d’un pays, ainsi qu’un secteur clé pour améliorer la vie de la population', name: 'tourisdest');
  }

  String get categ {
    return Intl.message('Categories', name: 'categ');
  }

  // a partir d'ici

 String get scat {
    return Intl.message('Sous catégorie', name: 'scat');
  }
  String get sscat {
    return Intl.message('Sélectionner une catégorie', name: 'sscat');
  }
  String get vtous {
    return Intl.message('Voir Tout', name: 'vtous');
  }
  String get prix {
    return Intl.message('Prix', name: 'prix');
  }
  String get zcinq {
    return Intl.message('0 à 50 000', name: 'zcinq');
  }
  String get cindeux {
    return Intl.message('50 001 à 200 000', name: 'cindeux');
  }
  String get deuxcin {
    return Intl.message('200 001 à 500 000', name: 'deuxcin');
  }
  String get cindun {
    return Intl.message('500 001 à 1 000 000', name: 'cindun');
  }
  String get supun {
    return Intl.message('Supérieur à 1 000 001', name: 'supun');
  }
  String get touris {
    return Intl.message('Tourisme', name: 'touris');
  }
  String get mais {
    return Intl.message('Maison', name: 'mais');
  }
String get recherch {
    return Intl.message('Recherche', name: 'recherch');
  }
  String get chamm {
    return Intl.message('Chambre meublée', name: 'chamm');
  }
  String get chamnm {
    return Intl.message('Chambre non meublée', name: 'chamnm');
  }
  String get stum {
    return Intl.message('Studio meublée', name: 'stum');
  }
  String get stunm {
    return Intl.message('Studio non meublée', name: 'stunm');
  }
  String get appnm {
    return Intl.message('Appartement non meublée', name: 'appnm');
  }
  String get appm {
    return Intl.message('Appartement meublée', name: 'appm');
  }
  String get salf {
    return Intl.message('Salle de fête', name: 'salf');
  }
  String get magg {
    return Intl.message('Magasin', name: 'magg');
  }
  String get terra {
    return Intl.message('Térasse', name: 'terra');
  }
  String get burr {
    return Intl.message('Bureau', name: 'burr');
  }
  
  String get park {
    return Intl.message('Parc national', name: 'park');
  }
  String get sitet {
    return Intl.message('Site touristique', name: 'sitet');
  }
  String get rest {
    return Intl.message('Restaurant', name: 'rest');
  }
  String get lois {
    return Intl.message('Loisir', name: 'lois');
  }
  String get dupp {
    return Intl.message('Duplex', name: 'dupp');
  }

  
  String get vill {
    return Intl.message('Villa', name: 'vill');
  }
  
  String get chat {
    return Intl.message('Chateaux', name: 'chat');
  }
  
  String get champ {
    return Intl.message('Chambre privée', name: 'champ');
  }
  
  String get champp {
    return Intl.message('Chambre partagée', name: 'champp');
  }
  
  String get ett {
    return Intl.message('étoile', name: 'ett');
  }
  
  String get etts {
    return Intl.message('étoiles', name: 'etts');
  }
  
  

// limit limit
  

  String get offres {
    return Intl.message('Dez', name: 'offres');
  }
   String get hotels {
    return Intl.message('Hotels', name: 'hotels');
  }
  
   String get hotelstitle {
    return Intl.message('Meilleur Choix d\'Hotel', name: 'hotelstitle');
  }
  
   String get hotelsdesc {
    return Intl.message('Avec SleepMoh, Choisissez simplement la destination et les dates de votre séjour et notre comparateur vous indiquera la meilleure offre d\'hotel', name: 'hotelsdesc');
  } 
  
  String get hebergement {
    return Intl.message('Hébergements', name: 'hebergement');
  } 
  
  String get hebertitle {
    return Intl.message('Meilleur Choix d\'Hébergement', name: 'hebertitle');
  }
  
  String get heberdesc {
    return Intl.message('Best Deal d\'hébergement a des prix attractif, SleepMoh est hébergeur Africain polyvalen', name: 'heberdesc');
  }
  
  String get immo {
    return Intl.message('Immobilier', name: 'immo');
  }
  
  String get immotitle {
    return Intl.message('Lancez-vous', name: 'immotitle');
  }
  
  String get immodesc {
    return Intl.message('De la recherche du bien jusqu\'a l\'mposition de vos choix, SleepMoh vous accompagne pour vous obtenir un meilleur rendement', name: 'immodesc');
  }
  
  String get entre {
    return Intl.message('Entre-Nous', name: 'entre');
  }
  
  String get entretitle {
    return Intl.message('Trouvez ici', name: 'entretitle');
  }
  
  String get entredesc {
    return Intl.message('Les meilleurs suggestion pour vos déplacements temporaires dans un environnement sociale et intellectuel. Cliquer pour en savoir plus.', name: 'entredesc');
  }



 String get detente {
    return Intl.message('Lieux de détentes', name: 'detente');
  } 
  
  String get more {
    return Intl.message('Plus >>', name: 'more');
  }
  
   String get quelheberge {
    return Intl.message('Quelques Hébergements', name: 'quelheberge');
  }
  
   String get photels {
    return Intl.message(' Fcfa / nuit', name: 'photels');
  }
  
   String get nomess {
    return Intl.message('Pas de message', name: 'nomess');
  }
  
   String get nomesdesc {
    return Intl.message('Lorsque vous trouvez un bien qui vous intéresse commencer à échanger avec le propriétaire et profiter pour prendre rendez-vous pour visiter le bien', name: 'nomesdesc');
  }
  
  String get moreloca {
    return Intl.message('Quelques biens en location', name: 'moreloca');
  }
  
  String get sellhouse {
    return Intl.message('Maisons en ventes', name: 'sellhouse');
  }
  
  String get bestdest {
    return Intl.message('Meilleurs destinations', name: 'bestdest');
  }
  
  String get terr {
    return Intl.message('Terrains', name: 'terr');
  }
  
  String get terrof {
    return Intl.message('Terrain de ', name: 'terrof');
  }
  
  String get mcarr {
    return Intl.message(' m²', name: 'mcarr');
  }
  
  String get lmer {
    return Intl.message('le mètre', name: 'lmer');
  }
  
  String get reduc {
    return Intl.message('Réduction 15%', name: 'reduc');
  }
  
  String get forstu {
    return Intl.message('Entre Etudiants', name: 'forstu');
  }

String get slang {
    return Intl.message('Séléctionner une langue', name: 'slang');
  }

String get fr {
    return Intl.message('Français', name: 'fr');
  }
String get en {
    return Intl.message('Anglais', name: 'en');
  }
String get sett {
    return Intl.message('Paraméttres', name: 'sett');
  }
String get profu {
    return Intl.message('Profil utilisateur', name: 'profu');
  }


  String get passseer {
    return Intl.message('Contact Us', name: 'passseer');
  }
  String get valid_com {
    return Intl.message('Contact Us', name: 'valid_com');
  }
  String get tel_error {
    return Intl.message('Contact Us', name: 'tel_error');
  }
  String get pas_error {
    return Intl.message('Contact Us', name: 'pas_error');
  }
  String get passss_error {
    return Intl.message('Contact Us', name: 'passss_error');
  }
  String get compte_error {
    return Intl.message('Contact Us', name: 'compte_error');
  }
  String get mon {
    return Intl.message('Raise Money', name: 'mon');
  }
  String get rec {
    return Intl.message('Receive', name: 'rec');
  }
  String get set {
    return Intl.message('Settings', name: 'set');
  }
  String get chan {
    return Intl.message('Change Password', name: 'chan');
  }

  String get lan {
    return Intl.message('Change Language', name: 'lan');
  }

  String get loc {
    return Intl.message('Change Location', name: 'loc');
  }
  String get nos {
    return Intl.message('Notification Settings', name: 'nos');
  }

  String get rno {
    return Intl.message('Received notification', name: 'rno');
  }
  String get nee {
    return Intl.message('Received newsletter', name: 'nee');
  }
  String get off {
    return Intl.message('Received Offer Notification', name: 'off');
  }
  String get app {
    return Intl.message('Received App Updates', name: 'app');
  }
  String get tel {
    return Intl.message('Enter your Phone', name: 'tel');
  }String get pas {
    return Intl.message('Enter your password', name: 'pas');
  }String get con {
    return Intl.message('Confirm your password', name: 'con');
  }
  String get acc {
    return Intl.message('Home', name: 'acc');
  }
  String get sen {
    return Intl.message('Send', name: 'sen');
  }
  String get rece {
    return Intl.message('Reception', name: 'rece');
  }
  String get rem {
    return Intl.message('Withdrawals', name: 'rem');
  }
  String get aval {
    return Intl.message('Available', name: 'aval');
  }
  String get see {
    return Intl.message('See All', name: 'see');
  }
  String get tran {
    return Intl.message('Transactions', name: 'tran');
  }
  String get easy {
    return Intl.message('Send and receive money very easily and securely.', name: 'easy');
  }
  String get gere {
    return Intl.message('Manage all your accounts easily.', name: 'gere');
  }
  String get mobile {
    return Intl.message('Manage your accounts (bank and / or savings account from your mobile).', name: 'mobile');
  }
  String get start {
    return Intl.message('Start.', name: 'start');
  }
  String get well {
    return Intl.message('Welcome to your financial management application. Made and designed for you !!!.', name: 'well');
  }
  String get sign {
    return Intl.message('Signup.', name: 'sign');
  }
  String get log {
    return Intl.message('Login.', name: 'log');
  }
  String get cont {
    return Intl.message('Continuous with Google.', name: 'cont');
  }
  String get send {
    return Intl.message('Send in one click.', name: 'send');
  }
    String get small {
    return Intl.message('Make your transactions, anytime, anywhere. ', name: 'small');
  }
  String get pass {
    return Intl.message('Next', name: 'pass');
  }
   String get titre0 {
    return Intl.message('Bienvenu sur SmallPocket', name: 'titre0');
  }

   String get descrip0 {
    return Intl.message('Faites vos reservation avec cmmm', name: 'descrip0');
  }


  String get btnsubmit {
    return Intl.message('Submit', name: 'btnsubmit');
  }

  String get locale {
    return Intl.message('en', name: 'locale');
  }

  String get lblname {
    return Intl.message('Name', name: 'lblname');
  }

  String get lblphone {
    return Intl.message('Phone', name: 'lblphone');
  }

  String get lblemail {
    return Intl.message('Email', name: 'lblemail');
  }
   String get dooo {
    return Intl.message('Email', name: 'dooo');
  }
   String get fredy {
    return Intl.message('Email', name: 'fredy');
  }
   String get gg {
    return Intl.message('Email', name: 'gg');
  }
  String get tt {
    return Intl.message('Email', name: 'tt');
  }
}

class SpecificLocalizationDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  final Locale overriddenLocale;

  SpecificLocalizationDelegate(this.overriddenLocale);

  @override
  bool isSupported(Locale locale) => overriddenLocale != null;

  @override
  Future<AppLocalizations> load(Locale locale) =>
      AppLocalizations.load(overriddenLocale);

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) => true;
}

class FallbackCupertinoLocalisationsDelegate extends LocalizationsDelegate<CupertinoLocalizations> {
  const FallbackCupertinoLocalisationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ar','fr'].contains(locale.languageCode);

  @override
  Future<CupertinoLocalizations> load(Locale locale) => SynchronousFuture<_DefaultCupertinoLocalizations>(_DefaultCupertinoLocalizations(locale));

  @override
  bool shouldReload(FallbackCupertinoLocalisationsDelegate old) => false;
}

class _DefaultCupertinoLocalizations extends DefaultCupertinoLocalizations {
  final Locale locale;
  
  _DefaultCupertinoLocalizations(this.locale);

 
}
