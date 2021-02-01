import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:devicelocale/devicelocale.dart';
import 'package:flutter/material.dart';
import 'package:sleepmohapp/DataSample/mydata.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sleepmohapp/DataSample/HebergementsModel.dart';
import 'package:sleepmohapp/DataSample/HotelModel.dart';
import 'package:sleepmohapp/DataSample/UserMod.dart';
import 'package:sleepmohapp/DataSample/TourismeModel.dart';
import 'package:sleepmohapp/Library/SupportingLibrary/Ratting/Rating.dart';
import 'package:sleepmohapp/UI/B1_Home/Destination/destinationDetail.dart';
import 'package:sleepmohapp/UI/B1_Home/Experience/experienceList.dart';
import 'package:sleepmohapp/UI/B1_Home/Hotel/HotelList.dart';
import 'package:sleepmohapp/UI/B1_Home/Hotel/Hotel_Detail_Concept_1/hotelDetail_concept_1.dart';
import 'package:sleepmohapp/UI/B1_Home/Hotel/Hotel_Detail_Concept_2/hotelDetail_concept_2.dart';
import 'package:sleepmohapp/UI/B1_Home/Hotel/Hotel_Detail_Concept_2/mapsrech.dart';
import 'package:sleepmohapp/UI/B1_Home/House/HouseList.dart';
import 'package:sleepmohapp/UI/B1_Home/travel/travelList.dart';
import 'package:sleepmohapp/UI/B3_Trips/exploreTrip.dart';
import 'package:sleepmohapp/UI/B4_Favorite/B4_FavoriteScreen.dart';
import 'package:sleepmohapp/UI/IntroApps/Login.dart';
import 'package:sleepmohapp/core/LocaleHelper.dart';
import 'package:sleepmohapp/core/localizations.dart';
import 'package:sleepmohapp/core/preference.dart';
import 'package:sleepmohapp/core/util.dart';
import 'editProfile.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

String currentLocale;
var userinfos = new List<UserMod>();
var compteU;
var listHotels = initlistHotel.map((model) => Hotelht.fromJson(model)).toList();
var listHebergements =
    initlisHebergement.map((model) => HerbergemntMod.fromJson(model)).toList();
var listTourisme =
    initlisTourisme.map((model) => Tourisme.fromJson(model)).toList();

class _HomeState extends State<Home> {
  static final _txtStyle = TextStyle(
      fontSize: 15.5,
      color: Colors.black,
      fontWeight: FontWeight.w700,
      fontFamily: 'Gotik');

  @override
  void initState() {
    super.initState();

    initSaveData();
  }

  void initSaveData() async {
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    compteU = false;

    await SharedPreferencesClass.restoreuser("userinfos").then((value) {
      setState(() {
        if (value != "") {
          compteU = true;
          Iterable list0 = jsonDecode(value);
          userinfos = list0.map((model) => UserMod.fromJson(model)).toList();
          log('user_value :' + value);
        }
      });
    });

    setState(() {
      //  log("message");
      var valuHotel = sharedPrefs.get('listHotel1');
      currentLocale = (sharedPrefs.get('langue') ?? 'fr');

      print('currentLocale');
      print(currentLocale);
      var valuHheberge = sharedPrefs.get('listHebergement');
      var valuHTourism = sharedPrefs.get('listTourisme');
      //listHotels = jsonDecode(sharedPrefs.get('listHotel1'));
//print(valuHotel);
      //  print("listhPref");
      if (valuHotel != null) {
        Iterable list0 = jsonDecode(valuHotel);
        listHotels = list0.map((model) => Hotelht.fromJson(model)).toList();
      }
      if (valuHheberge != null) {
        Iterable list1 = jsonDecode(valuHheberge);
        listHebergements =
            list1.map((model) => HerbergemntMod.fromJson(model)).toList();
      }
      if (valuHTourism != null) {
        Iterable list2 = jsonDecode(valuHTourism);
        listTourisme = list2.map((model) => Tourisme.fromJson(model)).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var _appBar = AppBar(
      backgroundColor: Colors.white,
      title: Text(AppLocalizations.of(context).acc,
          style: TextStyle(
              fontWeight: FontWeight.w900,
              fontFamily: "Gotik",
              fontSize: 25.0,
              color: Colors.black)),
      centerTitle: false,
      actions: <Widget>[
        compteU == true
            ? Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (_, __, ___) => new editProfile(
                              userinfo: userinfos[0],
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
                                  "https://www.sleepmoh.com/manager/avatars/" +
                                      userinfos[0].avatar),
                              fit: BoxFit.cover)),
                    ),
                  ),
                ),
              )
            : Padding(
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
    );

    var _searchBox = Padding(
      padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 10.0),
      child: InkWell(
        onTap: () => Navigator.of(context).push(PageRouteBuilder(
          pageBuilder: (_, __, ___) => new mapsrecher(),
          transitionsBuilder:
              (_, Animation<double> animation, __, Widget child) {
            return Opacity(
              opacity: animation.value,
              child: child,
            );
          },
          transitionDuration: Duration(milliseconds: 500),
        )),
        child: Container(
          height: 43.0,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(9.0)),
            boxShadow: [
              BoxShadow(
                color: Colors.black12.withOpacity(0.1),
                spreadRadius: 1.0,
                blurRadius: 3.0,
              )
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.search,
                  color: PaypalColors.Primary,
                  size: 25.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(AppLocalizations.of(context).well,
                      style: TextStyle(
                          color: Colors.black26,
                          fontFamily: "Gotik",
                          fontWeight: FontWeight.w300,
                          fontSize: 15.0)),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    var _lastActivity = Container(
      padding: EdgeInsets.only(right: 5.0, top: 10.0),
      height: 220.0,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              AppLocalizations.of(context).cont,
              style: _txtStyle,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 10.0,
              ),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                primary: false,
                itemBuilder: (ctx, index) {
                  return cardLastActivity(listHotels[index]);
                },
                itemCount: 5,
              ),
            ),
          )
        ],
      ),
    );

    var _recomendedTrevatel = Container(
      padding: EdgeInsets.only(top: 40.0),
      height: 318.0,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0, left: 20.0),
            child: Text(
              AppLocalizations.of(context).offres,
              style: _txtStyle,
            ),
          ),
          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                Padding(padding: EdgeInsets.only(left: 20.0)),
                cardSuggeted(
                  img: 'https://sleepmoh.com/flutterimg/hotel.jpg',
                  txtTitle: AppLocalizations.of(context).hotels,
                  txtSize: 48.0,
                  txtHeader: AppLocalizations.of(context).hotelstitle,
                  txtDesc: AppLocalizations.of(context).hotelsdesc,
                  navigatorOntap: () {
                    Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (_, __, ___) => new hotelList()));
                  },
                ),
                cardSuggeted(
                  img: 'https://sleepmoh.com/flutterimg/home.jpg',
                  txtTitle: AppLocalizations.of(context).hebergement,
                  txtSize: 50.0,
                  txtHeader: AppLocalizations.of(context).hebertitle,
                  txtDesc: AppLocalizations.of(context).heberdesc,
                  navigatorOntap: () {
                    Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (_, __, ___) => new houseList(
                              nameAppbar:
                                  AppLocalizations.of(context).heberdesc,
                            )));
                  },
                ),
                cardSuggeted(
                  img: 'https://sleepmoh.com/flutterimg/experience.jpg',
                  txtTitle: AppLocalizations.of(context).immo,
                  txtSize: 35.0,
                  txtHeader: AppLocalizations.of(context).immotitle,
                  txtDesc: AppLocalizations.of(context).immodesc,
                  navigatorOntap: () {
                    Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (_, __, ___) => new exploreTrip()));
                  },
                ),
                cardSuggeted(
                  img: 'https://sleepmoh.com/flutterimg/travel.jpg',
                  txtTitle: AppLocalizations.of(context).entre,
                  txtSize: 40.0,
                  txtHeader: AppLocalizations.of(context).entretitle,
                  txtDesc: AppLocalizations.of(context).entredesc,
                  navigatorOntap: () {
                    Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (_, __, ___) => new recommendation()));
                  },
                ),
                Padding(padding: EdgeInsets.only(right: 10.0)),
              ],
            ),
          ),
        ],
      ),
    );

    var _destinationPopuler = Container(
      padding: EdgeInsets.only(top: 30.0),
      height: 280.0,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
              padding:
                  const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    AppLocalizations.of(context).detente,
                    style: _txtStyle,
                  ),
                  Text(
                    AppLocalizations.of(context).more,
                    style: _txtStyle.copyWith(
                        color: Colors.black26, fontSize: 13.5),
                  )
                ],
              )),
          /*   Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 15.0),
                ),
                cardDestinationPopuler(
                  txt: 'Hawai',
                  img: 'assets/image/destinationPopuler/destination4.jpg',
                ),
                cardDestinationPopuler(
                  txt: 'Mount',
                  img: 'assets/image/destinationPopuler/destination4.jpg',
                ),
                cardDestinationPopuler(
                  txt: 'Canada',
                  img: 'assets/image/destinationPopuler/destination7.jpg',
                ),
                cardDestinationPopuler(
                  txt: 'Ice',
                  img: 'assets/image/destinationPopuler/destination10.jpg',
                ),
                cardDestinationPopuler(
                  txt: 'Mount',
                  img: 'assets/image/destinationPopuler/destination3.jpg',
                ),
                cardDestinationPopuler(
                  txt: 'Pucket',
                  img: 'assets/image/destinationPopuler/populer3.png',
                ),
                cardDestinationPopuler(
                  txt: 'Paris',
                  img: 'assets/image/destinationPopuler/populer4.png',
                ),
                cardDestinationPopuler(
                  txt: 'Bali',
                  img: 'assets/image/destinationPopuler/populer2.png',
                ),
              ],
            ),
          ),*/
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 10.0,
              ),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                primary: false,
                itemBuilder: (ctx, index) {
                  return cardDestinationPopuler(
                    txt: listTourisme[index].nomtr,
                    img: listTourisme[index].imgh,
                  );
                },
                itemCount: 5,
              ),
            ),
          )
        ],
      ),
    );

    ///  Grid item in bottom of Category
    var _recommendedRooms = SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.only(left: 20.0, top: 40.0, right: 20.0),
              child: Text(AppLocalizations.of(context).quelheberge,
                  style: _txtStyle),
            ),

            /// To set GridView item
            GridView.count(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                crossAxisSpacing: 0.0,
                mainAxisSpacing: 0.0,
                childAspectRatio: 0.795,
                crossAxisCount: 2,
                primary: false,
                children: List.generate(
                  10,
                  (index) => ItemGrid(listHebergements[index]),
                ))
          ],
        ),
      ),
    );

    return Scaffold(
      appBar: _appBar,
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _searchBox,
                    _lastActivity,
                    _recomendedTrevatel,
                    _destinationPopuler,
                    _recommendedRooms
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class cardLastActivity extends StatelessWidget {
  Hotelht searchesModel;

  cardLastActivity(this.searchesModel);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0, top: 10.0, bottom: 8.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(PageRouteBuilder(
              pageBuilder: (_, __, ___) => new hotelDetail(
                    title: searchesModel.type,
                    id: searchesModel.id,
                    image: searchesModel.imgh,
                    location: searchesModel.localisation,
                    price: searchesModel.prix.toString(),
                    nom: searchesModel.nom,
                    destination: searchesModel.description,
                    profilh: searchesModel.imghotel,
                    ln: searchesModel.ln,
                    lat: searchesModel.lat,
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
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF656565).withOpacity(0.15),
                  blurRadius: 4.0,
                  spreadRadius: 1.0,
                )
              ]),
          child: Wrap(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Hero(
                    tag: 'hero-tag-${searchesModel.imgh}',
                    child: Material(
                      child: Container(
                        height: 100.0,
                        width: 140.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(7.0),
                                topRight: Radius.circular(7.0)),
                            image: DecorationImage(
                                image: CachedNetworkImageProvider(
                                    searchesModel.imgh),
                                fit: BoxFit.cover)),
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 5.0)),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: Container(
                      width: 110.0,
                      child: Text(
                        searchesModel.type,
                        style: TextStyle(
                            letterSpacing: 0.5,
                            color: Colors.black54,
                            fontFamily: "Sans",
                            fontWeight: FontWeight.w600,
                            fontSize: 13.0),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 2.0)),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 0.0),
                        child: Text(
                          searchesModel.prix.toString(),
                          style: TextStyle(
                              color: Colors.black54,
                              fontFamily: "Gotik",
                              fontWeight: FontWeight.w800,
                              fontSize: 14.0),
                        ),
                      ),
                      Text(
                        AppLocalizations.of(context).photels,
                        style: TextStyle(
                            color: Colors.black54,
                            fontFamily: "Gotik",
                            fontWeight: FontWeight.w400,
                            fontSize: 10.0),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 15.0, top: 3.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            ratingbar(
                              starRating: searchesModel.nombreetoile,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: Text(
                                searchesModel.nombreetoile.toString(),
                                style: TextStyle(
                                    fontFamily: "Sans",
                                    color: Colors.black26,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12.0),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class cardSuggeted extends StatelessWidget {
  @override
  String img, txtTitle, txtHeader, txtDesc;
  double txtSize;
  GestureTapCallback navigatorOntap;
  cardSuggeted(
      {this.img,
      this.txtTitle,
      this.txtSize,
      this.navigatorOntap,
      this.txtHeader,
      this.txtDesc});
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 4.0, right: 12.0, top: 8.0, bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          InkWell(
            onTap: navigatorOntap,
            child: Container(
              width: 285.0,
              height: 135.0,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: CachedNetworkImageProvider(img),
                      fit: BoxFit.cover),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF656565).withOpacity(0.15),
                      blurRadius: 2.0,
                      spreadRadius: 1.0,
//           offset: Offset(4.0, 10.0)
                    )
                  ]),
              child: Center(
                child: Text(
                  txtTitle,
                  style: TextStyle(
                      fontFamily: 'Amira',
                      color: Colors.white,
                      fontSize: txtSize,
                      letterSpacing: 2.0,
                      shadows: [
                        Shadow(
                          color: Colors.black12.withOpacity(0.1),
                          blurRadius: 2.0,
                        )
                      ]),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 10.0),
            child: Text(
              txtHeader,
              style: TextStyle(
                fontFamily: "Sans",
                fontSize: 16.0,
                fontWeight: FontWeight.w800,
                color: Colors.black54,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 5.0),
            child: Container(
                width: 270.0,
                child: Text(
                  txtDesc,
                  overflow: TextOverflow.clip,
                  maxLines: 3,
                  style: TextStyle(
                    fontFamily: "Sans",
                    fontSize: 13.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.black26,
                  ),
                )),
          ),
        ],
      ),
    );
  }
}

class cardDestinationPopuler extends StatelessWidget {
  String img, txt;
  cardDestinationPopuler({this.img, this.txt});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(PageRouteBuilder(
            pageBuilder: (_, __, ___) => new destination(
                  title: this.txt,
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
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 400.0,
          width: 140.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              image: DecorationImage(
                image: CachedNetworkImageProvider(img),
                fit: BoxFit.cover,
              ),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12.withOpacity(0.1),
                    blurRadius: 2.0,
                    spreadRadius: 1.0)
              ]),
          child: Center(
            child: Text(
              txt,
              style: TextStyle(
                  fontFamily: 'Amira',
                  color: Colors.white,
                  fontSize: 20.0,
                  letterSpacing: 1.0,
                  shadows: [
                    Shadow(
                      color: Colors.black,
                      blurRadius: 5.0,
                    )
                  ]),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

/// ItemGrid in bottom item "Recomended" item
class ItemGrid extends StatelessWidget {
  /// Get data from HomeGridItem.....dart class
  HerbergemntMod gridItem;
  ItemGrid(this.gridItem);

  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(PageRouteBuilder(
              pageBuilder: (_, __, ___) => new hotelDetail2(
                    title: gridItem.typefr,
                    id: gridItem.id,
                    image: gridItem.imgh,
                    location: gridItem.localisation,
                    price: gridItem.prix,
                    description: gridItem.description,
                    periode: gridItem.perifr,
                    ln: gridItem.ln,
                    lat: gridItem.lat,
                    note: gridItem.notefr,
                    acces: gridItem.accesfr,
                    stanting: gridItem.standingfr,
                    securi: gridItem.securitefr,
                    ratting: gridItem.note,
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
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF656565).withOpacity(0.15),
                  blurRadius: 4.0,
                  spreadRadius: 1.0,
//           offset: Offset(4.0, 10.0)
                )
              ]),
          child: Wrap(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Hero(
                    tag: 'hero-tag-${gridItem.id}',
                    child: Material(
                      child: Container(
                        height: mediaQueryData.size.height / 5.8,
                        width: 200.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(7.0),
                                topRight: Radius.circular(7.0)),
                            image: DecorationImage(
                                image:
                                    CachedNetworkImageProvider(gridItem.imgh),
                                fit: BoxFit.cover)),
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 5.0)),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: Container(
                      width: 130.0,
                      child: Text(
                        currentLocale == 'fr'
                            ? gridItem.typefr
                            : gridItem.typeen,
                        style: TextStyle(
                            letterSpacing: 0.5,
                            color: Colors.black54,
                            fontFamily: "Sans",
                            fontWeight: FontWeight.w600,
                            fontSize: 13.0),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 5.0)),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: Container(
                      width: 130.0,
                      child: Text(
                        gridItem.localisation,
                        style: TextStyle(
                            letterSpacing: 0.5,
                            color: Colors.black54,
                            fontFamily: "Sans",
                            fontWeight: FontWeight.w600,
                            fontSize: 13.0),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 2.0)),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 0.0),
                        child: Text(
                          gridItem.prix + ' Fcfa',
                          style: TextStyle(
                              color: Colors.black54,
                              fontFamily: "Gotik",
                              fontWeight: FontWeight.w800,
                              fontSize: 14.0),
                        ),
                      ),
                      Text(
                        currentLocale == 'fr'
                            ? " / " + gridItem.perifr
                            : " / " + gridItem.perien,
                        style: TextStyle(
                            color: Colors.black54,
                            fontFamily: "Gotik",
                            fontWeight: FontWeight.w400,
                            fontSize: 12.0),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 15.0, top: 5.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            ratingbar(
                              starRating: gridItem.note,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: Text(
                                currentLocale == 'fr'
                                    ? gridItem.notefr
                                    : gridItem.noteen,
                                style: TextStyle(
                                    fontFamily: "Sans",
                                    color: Colors.black26,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12.0),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
