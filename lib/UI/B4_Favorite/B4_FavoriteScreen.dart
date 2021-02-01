import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sleepmohapp/DataSample/EntreMod.dart';
import 'package:sleepmohapp/DataSample/HotelModel.dart';
import 'package:sleepmohapp/DataSample/mydata.dart';
import 'package:sleepmohapp/Library/SupportingLibrary/Ratting/Rating.dart';
import 'package:sleepmohapp/UI/B1_Home/B1_Home_Screen/Search.dart';
import 'package:sleepmohapp/UI/B1_Home/Experience/experienceList.dart';
import 'package:sleepmohapp/UI/B1_Home/Hotel/Hotel_Detail_Concept_1/hotelDetail_concept_1.dart';
import 'package:sleepmohapp/UI/B1_Home/Hotel/Hotel_Detail_Concept_2/mapsrech.dart';
import 'package:sleepmohapp/UI/B1_Home/House/HouseList.dart';
import 'package:sleepmohapp/core/localizations.dart';
import 'package:sleepmohapp/core/preference.dart';
import 'package:sleepmohapp/core/util.dart';

class recommendation extends StatefulWidget {
  recommendation({Key key}) : super(key: key);

  @override
  _recommendationState createState() => _recommendationState();
}

var listEntres =
    initlistEtudiant.map((model) => EntreMod.fromJson(model)).toList();

class _recommendationState extends State<recommendation> {
  @override
  void initState() {
    initSaveData();
    // TODO: implement initState
    super.initState();
  }

  void initSaveData() async {
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();

    setState(() {
      //  log("message");
      var valuEntre = sharedPrefs.get('listEntre');
      //listHotels = jsonDecode(sharedPrefs.get('listHotel1'));
//print(valuHotel);
      //  print("listhPref");
      if (valuEntre != null) {
        Iterable list0 = jsonDecode(valuEntre);
        listEntres = list0.map((model) => EntreMod.fromJson(model)).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _widht = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: 210.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: CachedNetworkImageProvider(
                            "https://sleepmoh.com/flutterimg/hotel2.jpg",
                          ),
                          fit: BoxFit.cover)),
                  child: Container(
                    height: 210.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.black12.withOpacity(0.15),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 185.0, left: 20.0, right: 20.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(PageRouteBuilder(
                            pageBuilder: (_, __, ___) => new search()));
                      },
                      child: Container(
                        height: 44.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(color: Colors.black12.withOpacity(0.1))
                            ],
                            borderRadius:
                                BorderRadius.all(Radius.circular(40.0)),
                            color: Colors.white),
                        child: Center(
                          child: InkWell(
                            onTap: () =>
                                Navigator.of(context).push(PageRouteBuilder(
                              pageBuilder: (_, __, ___) => new mapsrecher(),
                              transitionsBuilder: (_,
                                  Animation<double> animation,
                                  __,
                                  Widget child) {
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(9.0)),
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
                                      child: Text(
                                          AppLocalizations.of(context).well,
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
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 30.0),
              child: Container(
                height: 120.0,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: Colors.black12.withOpacity(0.05))
                    ]),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      _icon(
                          "Bureau",
                          "airline_seat_individual_suite",
                          Color(0xFFF07DA4),
                          Color(0xFFF5AE87),
                          Icons.desktop_windows),
                      _icon("Hotspot", "Hotspot", Color(0xFF63CCD1),
                          Color(0xFF75E3AC), Icons.settings_input_antenna),
                      _icon("Accesible", "Nearby", Color(0xFF9183FC),
                          Color(0xFFDB8EF6), Icons.track_changes),
                      _icon("Calme", "Relax", Color(0xFF56B4EE),
                          Color(0xFF59CCE1), Icons.spa),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 20.0, top: 35.0, bottom: 10.0),
              child: Text(
                AppLocalizations.of(context).forstu,
                style: TextStyle(
                    fontFamily: "Sofia",
                    fontWeight: FontWeight.w800,
                    fontSize: 27.0),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(left: 0.0, right: 0.0),
                child: Container(color: Colors.white, child: cardGrid()))
          ],
        ),
      ),
    );
  }

  Widget _icon(
      String _text, _nameAppbar, Color _color, _color2, IconData _icon) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(PageRouteBuilder(
            pageBuilder: (_, __, ___) => new houseList(
                  nameAppbar: _nameAppbar,
                )));
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 50.0,
            width: 50.0,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [_color, _color2]),
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            child: Center(
                child: Icon(
              _icon,
              color: Colors.white,
            )),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            _text,
            style: TextStyle(fontFamily: "Sofia"),
          )
        ],
      ),
    );
  }
}

class cardGrid extends StatelessWidget {
  const cardGrid({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
      childAspectRatio: mediaQueryData.size.height / 1100,
      crossAxisSpacing: 0.0,
      mainAxisSpacing: 0.0,
      primary: false,
      children: List.generate(
        /// Get data in flashSaleItem.dart (ListItem folder)
        listEntres.length > 8 ? 8 : listEntres.length,
        (index) => itemGrid(listEntres[index]),
      ),
    );
  }
}

class itemGrid extends StatelessWidget {
  EntreMod hotelData;
  itemGrid(this.hotelData);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(
              onTap: () {
                Navigator.of(context).push(PageRouteBuilder(
                    pageBuilder: (_, __, ___) => new hotelDetail(
                          title: hotelData.typefr,
                          id: hotelData.ide,
                          image: hotelData.imgh,
                          location: hotelData.localisation,
                          price: hotelData.prix,
                          nom: hotelData.nom,
                          destination: hotelData.description,
                          profilh: hotelData.imghotel,
                          ln: hotelData.ln,
                          lat: hotelData.lat,
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
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                      color: Colors.black12.withOpacity(0.1),
                      spreadRadius: 0.2,
                      blurRadius: 0.5)
                ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Hero(
                      tag: "hero-flashsale-${hotelData.ide}",
                      child: Material(
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(PageRouteBuilder(
                                opaque: false,
                                pageBuilder: (BuildContext context, _, __) {
                                  return new Material(
                                    color: Colors.black54,
                                    child: Container(
                                      padding: EdgeInsets.all(30.0),
                                      child: InkWell(
                                        child: Hero(
                                            tag:
                                                "hero-flashsale-${hotelData.ide}",
                                            child: Image.network(
                                              hotelData.imgh,
                                              width: 300.0,
                                              height: 400.0,
                                              alignment: Alignment.center,
                                              fit: BoxFit.contain,
                                            )),
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ),
                                  );
                                },
                                transitionDuration:
                                    Duration(milliseconds: 500)));
                          },
                          child: SizedBox(
                            child: Image.network(
                              hotelData.imgh,
                              fit: BoxFit.cover,
                              height: 140.0,
                              width: mediaQueryData.size.width / 2.1,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(left: 8.0, right: 3.0, top: 15.0),
                      child: Container(
                        width: mediaQueryData.size.width / 2.7,
                        child: Text(
                          hotelData.typefr,
                          style: TextStyle(
                              fontSize: 14.5,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Sofia"),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10.0, top: 5.0),
                      child: Text(hotelData.prix + ' Fcfa',
                          style: TextStyle(
                              fontSize: 15.5,
                              color: Colors.black54,
                              fontWeight: FontWeight.w800,
                              fontFamily: "Sans")),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, top: 5.0),
                      child: Row(
                        children: <Widget>[
                          ratingbar(
                            starRating: 4,
                            color: Colors.blue[300],
                          ),
                          Padding(padding: EdgeInsets.only(left: 5.0)),
                          Text(
                            "(" + hotelData.nombreetoile.toString() + ")",
                            style: TextStyle(
                              color: Colors.black26,
                              fontFamily: "Gotik",
                              fontSize: 12.5,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, top: 5.0, bottom: 15.0),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.location_on,
                            size: 11.0,
                            color: Colors.black38,
                          ),
                          Text(
                            hotelData.localisation,
                            style: TextStyle(
                                fontSize: 10.0,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Sans",
                                color: Colors.black38),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
