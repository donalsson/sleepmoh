import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:devicelocale/devicelocale.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sleepmohapp/DataSample/HotelListData.dart';
import 'package:sleepmohapp/DataSample/ImmobModel.dart';
import 'package:sleepmohapp/DataSample/MaisonModel.dart';
import 'package:sleepmohapp/DataSample/TerrainModel.dart';
import 'package:sleepmohapp/DataSample/travelModelData.dart';
import 'package:sleepmohapp/Library/SupportingLibrary/Ratting/Rating.dart';
import 'package:sleepmohapp/UI/B1_Home/Destination/destinationDetail.dart';
import 'package:sleepmohapp/UI/B1_Home/Hotel/Hotel_Detail_Concept_1/hotelDetail_concept_1.dart';
import 'package:sleepmohapp/UI/B1_Home/Hotel/Hotel_Detail_Concept_2/hotelDetail_concept_2.dart';
import 'package:sleepmohapp/UI/B1_Home/Hotel/Hotel_Detail_Concept_2/immodelails.dart';
import 'package:sleepmohapp/UI/B1_Home/Hotel/Hotel_Detail_Concept_2/maisondetails.dart';
import 'package:sleepmohapp/UI/B1_Home/Hotel/Hotel_Detail_Concept_2/terrainsdetails.dart';

import 'package:sleepmohapp/core/localizations.dart';
import 'package:sleepmohapp/core/preference.dart';
import 'package:sleepmohapp/DataSample/mydata.dart';

class exploreTrip extends StatefulWidget {
  exploreTrip({Key key}) : super(key: key);

  @override
  _exploreTripState createState() => _exploreTripState();
}

String currentLocale;
var compteU;
var listTerrains =
    initlistTerrain.map((model) => TerrainMod.fromJson(model)).toList();
var listImmo =
    initlisHebergement.map((model) => ImmobMod.fromJson(model)).toList();
var listMaison =
    initlistMaison.map((model) => MaisonMod.fromJson(model)).toList();

class _exploreTripState extends State<exploreTrip> {
  var _recommended = Padding(
    padding: EdgeInsets.only(left: 5.0),
    child: Container(
      child: ListView.builder(
        shrinkWrap: true,
        primary: false,
        itemBuilder: (ctx, index) {
          return cardList(listTerrains[index]);
        },
        itemCount: listTerrains.length,
      ),
    ),
  );
  @override
  void initState() {
    super.initState();

    initSaveData();
  }

  void initSaveData() async {
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    currentLocale = await Devicelocale.currentLocale;

    await SharedPreferencesClass.restore("Userinfos").then((value) {
      setState(() {
        compteU = value;
      });
    });
    print(currentLocale);
    print('compte');
    print(compteU);
    setState(() {
      //  log("message");
      var valuTerain = sharedPrefs.get('listTerrain');
      var valuImmo = sharedPrefs.get('listImobi');
      var valuMaison = sharedPrefs.get('listMaison');
      //listHotels = jsonDecode(sharedPrefs.get('listHotel1'));
//print(valuHotel);
      //  print("listhPref");
      if (valuTerain != null) {
        Iterable list0 = jsonDecode(valuTerain);
        listTerrains =
            list0.map((model) => TerrainMod.fromJson(model)).toList();
      }
      if (valuImmo != null) {
        Iterable list1 = jsonDecode(valuImmo);
        listImmo = list1.map((model) => ImmobMod.fromJson(model)).toList();
      }
      if (valuMaison != null) {
        Iterable list2 = jsonDecode(valuMaison);
        listMaison = list2.map((model) => MaisonMod.fromJson(model)).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          height: _height,
          child: ListView(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    height: 200.0,
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
                            "https://sleepmoh.com/flutterimg/legrand22.jpg"),
                        CachedNetworkImageProvider(
                            "https://sleepmoh.com/flutterimg/legrand33.jpg"),
                        CachedNetworkImageProvider(
                            "https://sleepmoh.com/flutterimg/legrand44.jpg"),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 30.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  AppLocalizations.of(context).moreloca,
                  style: TextStyle(
                      fontFamily: "Sofia",
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(height: 5.0),
              Container(
                height: 320.0,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: listImmo
                      .map<Widget>((data) => _cardLocalion(context, data))
                      .toList(),
                ),
              ),
              SizedBox(
                height: 25.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  AppLocalizations.of(context).sellhouse,
                  style: TextStyle(
                      fontFamily: "Sofia",
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(height: 5.0),
              Container(
                height: 320.0,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: listMaison
                      .map<Widget>((data) => _cardMaison(context, data))
                      .toList(),
                ),
              ),
              SizedBox(
                height: 25.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        AppLocalizations.of(context).bestdest,
                        style: TextStyle(
                            fontFamily: "Sofia",
                            fontSize: 20.0,
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        AppLocalizations.of(context).more,
                        style: TextStyle(
                            fontFamily: "Sofia",
                            fontSize: 16.0,
                            fontWeight: FontWeight.w300),
                      ),
                    ]),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 10.0,
                ),
                child: Container(
                  height: 140.0,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      SizedBox(
                        width: 20.0,
                      ),
                      cardCountry(
                        colorTop: Color(0xFFF07DA4),
                        colorBottom: Color(0xFFF5AE87),
                        image: "assets/image/icon/amerika.png",
                        title: "America",
                      ),
                      cardCountry(
                          colorTop: Color(0xFF63CCD1),
                          colorBottom: Color(0xFF75E3AC),
                          image: "assets/image/icon/thailand.png",
                          title: "Thailand"),
                      cardCountry(
                          colorTop: Color(0xFF9183FC),
                          colorBottom: Color(0xFFDB8EF6),
                          image: "assets/image/icon/england.png",
                          title: "England"),
                      cardCountry(
                          colorTop: Color(0xFF56B4EE),
                          colorBottom: Color(0xFF59CCE1),
                          image: "assets/image/icon/italia.png",
                          title: "Italia"),
                      cardCountry(
                          colorTop: Color(0xFF56AB2F),
                          colorBottom: Color(0xFFA8E063),
                          image: "assets/image/icon/spanyol.png",
                          title: "Spanyol"),
                      InkWell(
                        onTap: () {},
                        child: cardCountry(
                            colorTop: Color(0xFF74EBD5),
                            colorBottom: Color(0xFFACB6E5),
                            image: "assets/image/icon/paris.png",
                            title: "France"),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 25.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 22.0),
                child: Text(
                  AppLocalizations.of(context).terr,
                  style: TextStyle(
                      fontFamily: "Sofia",
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700),
                ),
              ),
              _recommended,
              SizedBox(
                height: 20.0,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class cardList extends StatelessWidget {
  @override
  var _txtStyleTitle = TextStyle(
    color: Colors.black87,
    fontFamily: "Gotik",
    fontSize: 17.0,
    fontWeight: FontWeight.w800,
  );

  var _txtStyleSub = TextStyle(
    color: Colors.black26,
    fontFamily: "Gotik",
    fontSize: 12.5,
    fontWeight: FontWeight.w600,
  );

  TerrainMod listimmo;

  cardList(this.listimmo);
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(PageRouteBuilder(
              pageBuilder: (_, __, ___) => new terrainsdetails(
                    title: AppLocalizations.of(context).terrof +
                        listimmo.superficiet +
                        AppLocalizations.of(context).mcarr,
                    id: listimmo.id,
                    image: listimmo.imgh,
                    location: listimmo.localisation,
                    price: listimmo.prixt,
                    description: listimmo.descriptiont,
                    periode: AppLocalizations.of(context).mcarr,
                    ln: listimmo.ln,
                    lat: listimmo.lat,
                    note: listimmo.superficiet,
                    acces: "10",
                    stanting: listimmo.telephone,
                    securi: listimmo.telephone,
                    ratting: 10,
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
          height: 230.0,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12.withOpacity(0.1),
                    blurRadius: 3.0,
                    spreadRadius: 1.0)
              ]),
          child: Column(children: [
            Hero(
              tag: 'hero-tag-${listimmo.id}',
              child: Material(
                child: Container(
                  height: 165.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10.0),
                        topLeft: Radius.circular(10.0)),
                    image: DecorationImage(
                        image: CachedNetworkImageProvider(listimmo.imgh),
                        fit: BoxFit.cover),
                  ),
                  alignment: Alignment.topRight,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            width: 220.0,
                            child: Text(
                              AppLocalizations.of(context).terrof +
                                  listimmo.superficiet +
                                  AppLocalizations.of(context).mcarr,
                              style: _txtStyleTitle,
                              overflow: TextOverflow.ellipsis,
                            )),
                        Padding(padding: EdgeInsets.only(top: 5.0)),
                        Padding(
                          padding: const EdgeInsets.only(top: 4.9),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.location_on,
                                size: 16.0,
                                color: Colors.black26,
                              ),
                              Padding(padding: EdgeInsets.only(top: 3.0)),
                              Text(listimmo.localisation, style: _txtStyleSub)
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 13.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          listimmo.prixt + " Fcfa",
                          style: TextStyle(
                              fontSize: 25.0,
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Gotik"),
                        ),
                        Text(AppLocalizations.of(context).lmer,
                            style: _txtStyleSub.copyWith(fontSize: 11.0))
                      ],
                    ),
                  ),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}

Widget _cardLocalion(BuildContext context, ImmobMod data) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        InkWell(
          onTap: () {
            Navigator.of(context).push(PageRouteBuilder(
                pageBuilder: (_, __, ___) => new immodetails(
                      title: data.typefr,
                      id: data.id,
                      image: data.imgh,
                      location: data.localisation,
                      price: data.prix,
                      description: data.description,
                      periode: data.perifr,
                      ln: data.ln,
                      lat: data.lat,
                      note: data.notefr,
                      acces: data.accesfr,
                      stanting: data.standingfr,
                      securi: data.notefr,
                      ratting: data.note,
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
            tag: 'hero-tag-${data.id}',
            child: Material(
              child: Container(
                height: 220.0,
                width: 160.0,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: CachedNetworkImageProvider(data.imgh),
                        fit: BoxFit.cover),
                    color: Colors.black12,
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 5.0,
                          color: Colors.black12.withOpacity(0.1),
                          spreadRadius: 2.0)
                    ]),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        Text(
          data.typefr,
          style: TextStyle(
              fontFamily: "Sofia",
              fontWeight: FontWeight.w600,
              fontSize: 17.0,
              color: Colors.black87),
        ),
        SizedBox(
          height: 2.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(
              Icons.location_on,
              size: 18.0,
              color: Colors.black12,
            ),
            Text(
              data.localisation,
              style: TextStyle(
                  fontFamily: "Sofia",
                  fontWeight: FontWeight.w500,
                  fontSize: 15.0,
                  color: Colors.black26),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.star,
              size: 18.0,
              color: Colors.yellow,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 3.0),
              child: Text(
                data.prix + ' Fcfa',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontFamily: "Sofia",
                    fontSize: 13.0),
              ),
            ),
            SizedBox(
              width: 3.0,
            ),
            Container(
              height: 23.0,
              width: 62.0,
              decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              child: Center(
                child: Text(AppLocalizations.of(context).reduc,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 10.0)),
              ),
            )
          ],
        ),
      ],
    ),
  );
}

Widget _cardMaison(BuildContext context, MaisonMod data) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        InkWell(
          onTap: () {
            Navigator.of(context).push(PageRouteBuilder(
                pageBuilder: (_, __, ___) => new maisondetails(
                      title: data.typefr,
                      id: data.id,
                      image: data.imgh,
                      location: data.localisation,
                      price: data.prix,
                      description: data.description,
                      periode: data.nbrechambre,
                      ln: data.ln,
                      lat: data.lat,
                      note: data.nbresalon,
                      acces: data.nbrechambre,
                      stanting: data.nbrecuisine,
                      securi: data.nombredouche,
                      ratting: 4,
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
            tag: 'hero-tag-${data.id}',
            child: Material(
              child: Container(
                height: 220.0,
                width: 160.0,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: CachedNetworkImageProvider(data.imgh),
                        fit: BoxFit.cover),
                    color: Colors.black12,
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 5.0,
                          color: Colors.black12.withOpacity(0.1),
                          spreadRadius: 2.0)
                    ]),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        Text(
          data.typefr,
          style: TextStyle(
              fontFamily: "Sofia",
              fontWeight: FontWeight.w600,
              fontSize: 17.0,
              color: Colors.black87),
        ),
        SizedBox(
          height: 2.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(
              Icons.location_on,
              size: 18.0,
              color: Colors.black12,
            ),
            Text(
              data.localisation,
              style: TextStyle(
                  fontFamily: "Sofia",
                  fontWeight: FontWeight.w500,
                  fontSize: 15.0,
                  color: Colors.black26),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.star,
              size: 18.0,
              color: Colors.yellow,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 3.0),
              child: Text(
                data.prix + ' Fcfa',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontFamily: "Sofia",
                    fontSize: 13.0),
              ),
            ),
            SizedBox(
              width: 35.0,
            ),
            Container(
              height: 23.0,
              width: 62.0,
              decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              child: Center(
                child: Text(AppLocalizations.of(context).reduc,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 10.0)),
              ),
            )
          ],
        ),
      ],
    ),
  );
}

class cardCountry extends StatelessWidget {
  Color colorTop, colorBottom;
  String image, title;
  cardCountry({this.colorTop, this.colorBottom, this.title, this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 4.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(PageRouteBuilder(
              pageBuilder: (_, __, ___) => new destination(
                    title: this.title,
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 105.0,
              width: 105.0,
              decoration: BoxDecoration(
                boxShadow: [BoxShadow(blurRadius: 8.0, color: Colors.black12)],
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                gradient: LinearGradient(
                    colors: [colorTop, colorBottom],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight),
              ),
              child: Padding(
                padding: const EdgeInsets.only(right: 4.0),
                child: Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      image,
                      height: 60,
                      color: Colors.white,
                    )),
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Text(
                title,
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Sofia",
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600),
              ),
            )
          ],
        ),
      ),
    );
  }
}
