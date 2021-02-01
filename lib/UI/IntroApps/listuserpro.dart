import 'dart:async';
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:devicelocale/devicelocale.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sleepmohapp/DataSample/HotelListData.dart';
import 'package:sleepmohapp/DataSample/HebergementsModel.dart';
import 'package:sleepmohapp/DataSample/mydata.dart';
import 'package:sleepmohapp/Library/SupportingLibrary/Ratting/Rating.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sleepmohapp/core/localizations.dart';

import 'package:sleepmohapp/UI/Bottom_Nav_Bar/bottomNavBar.dart';
import 'package:sleepmohapp/UI/B1_Home/Hotel/Hotel_Detail_Concept_2/hotelDetail_concept_2.dart';
import 'package:sleepmohapp/UI/B1_Home/B1_Home_Screen/Search.dart';
import 'package:sleepmohapp/core/preference.dart';
import 'package:sleepmohapp/DataSample/UserMod.dart';

class Listprouser extends StatefulWidget {
  UserMod userinfo;
  Listprouser(this.userinfo);

  @override
  _ListprouserState createState() => _ListprouserState();
}

String currentLocale;
var compteU;
bool hisdata = false;
var listHotels =
    initlistHotel.map((model) => HerbergemntMod.fromJson(model)).toList();

class _ListprouserState extends State<Listprouser> {
  @override
  static hotelListData hotelData;
  bool loadImage = true;
  bool colorIconCard = false;
  bool chosseCard = false;
  bool colorIconCard2 = true;

  var loadImageAnimation = Container(
      color: Colors.white,
      child: ListView.builder(
        itemBuilder: (ctx, index) => cardLoading(hotelDataDummy[index]),
        itemCount: listHotels.length,
      ));

  var imageNetwork = NetworkImage(
      "https://github.com/flutter/website/blob/master/src/_includes/code/layout/lakes/images/lake.jpg?raw=true");

  var imageLoaded = Container(
      color: Colors.white,
      child: ListView.builder(
        itemBuilder: (ctx, index) => cardList(listHotels[index]),
        itemCount: listHotels.length,
      ));

  @override
  void initState() {
    Timer(Duration(seconds: 3), () {
      setState(() {
        loadImage = false;
      });
    });

    initSaveData();
    // TODO: implement initState
    super.initState();
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
      var valuHotel = sharedPrefs.get('listHebergementuser');
      //listHotels = jsonDecode(sharedPrefs.get('listHotel1'));
      print('valuHotel');
      print(valuHotel);
      //  print("listhPref");
      if (valuHotel != null) {
        //  hisdata = true;
        Iterable list0 = jsonDecode(valuHotel);

        listHotels =
            list0.map((model) => HerbergemntMod.fromJson(model)).toList();

        print(listHotels.length.toString());
        if (listHotels.length > 0) {
          hisdata = true;
        }
      } else {
        listHotels.clear();
      }
    });
  }

  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: hisdata
          ? Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 45.0),
                  child: Container(
                      color: Colors.white,
                      child: loadImage
                          ? Container(
                              color: Colors.white,
                              child: ListView.builder(
                                itemBuilder: (ctx, index) =>
                                    cardLoading(hotelDataDummy[index]),
                                itemCount: listHotels.length,
                              ))
                          : Container(
                              color: Colors.white,
                              child: ListView.builder(
                                itemBuilder: (ctx, index) =>
                                    cardList(listHotels[index]),
                                itemCount: listHotels.length,
                              ))),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                    color: Colors.white,
                    height: 77.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            InkWell(
                                onTap: () {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            new bottomNavBar()),
                                    (Route<dynamic> route) => false,
                                  );
                                },
                                child: Padding(
                                    padding:
                                        EdgeInsets.only(top: 35.0, left: 15.0),
                                    child: Icon(
                                      Icons.clear,
                                      size: 30.0,
                                    ))),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 35.0, left: 30.0, right: 15.0),
                              child: Text(
                                "Liste de vos Proprieter",
                                style: TextStyle(
                                    fontFamily: "Sofia",
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.w800),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          : Stack(
              children: <Widget>[
                Row(
                  children: [
                    InkWell(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, '/welcome',
                              arguments: <String, dynamic>{});
                        },
                        child: Padding(
                            padding: EdgeInsets.only(top: 35.0, left: 15.0),
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              size: 30.0,
                            ))),
                    InkWell(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, '/welcome',
                              arguments: <String, dynamic>{});
                        },
                        child: Container(
                            width: MediaQuery.of(context).size.width - 70,
                            alignment: Alignment.topRight,
                            padding: EdgeInsets.only(top: 35.0, left: 15.0),
                            child: Text(
                              "En",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15),
                            ))),
                  ],
                ),
                Image(
                  image: CachedNetworkImageProvider(
                      'https://sleepmoh.com/flutterimg/destination1.jpg'),
                  height: _height,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 240.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 20.0,
                                color: Colors.black12.withOpacity(0.08))
                          ]),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 20.0, bottom: 20.0),
                            child: Text(
                              AppLocalizations.of(context).nomess,
                              style: TextStyle(
                                  fontFamily: "Sofia",
                                  fontSize: 21.0,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 20.0),
                            child: Text(
                              AppLocalizations.of(context).nomesdesc,
                              style: TextStyle(
                                  color: Colors.black26, fontFamily: "Sofia"),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          InkWell(
                            onTap: () {},
                            child: Container(
                              height: 45.0,
                              width: 180.0,
                              color: Colors.blue[400],
                              child: Center(
                                child: Text(
                                  "Nous écrire",
                                  style: TextStyle(
                                      color: Colors.white, fontFamily: "Sofia"),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
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
        listHotels.length,
        (index) => itemGrid(listHotels[index]),
      ),
    );
  }
}

/// Component Card item in gridView after done loading image
class itemGrid extends StatelessWidget {
  HerbergemntMod hotelData;
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
              onTap: () {},
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
                      tag: "hero-flashsale-${hotelData.id}",
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
                                                "hero-flashsale-${hotelData.id}",
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
                          hotelData.nom,
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
                      child: Text("\$" + hotelData.prix,
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
                            starRating: hotelData.nombreetoile,
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

  HerbergemntMod hotelData;

  cardList(this.hotelData);
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(PageRouteBuilder(
              pageBuilder: (_, __, ___) => new hotelDetail2(
                    title: hotelData.typefr,
                    id: hotelData.id,
                    image: hotelData.imgh,
                    location: hotelData.localisation,
                    price: hotelData.prix,
                    description: hotelData.description,
                    periode: hotelData.perifr,
                    ln: hotelData.ln,
                    lat: hotelData.lat,
                    note: hotelData.notefr,
                    acces: hotelData.accesfr,
                    stanting: hotelData.standingfr,
                    securi: hotelData.securitefr,
                    ratting: hotelData.note,
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
          height: 250.0,
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
            Container(
              height: 165.0,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10.0),
                    topLeft: Radius.circular(10.0)),
                image: DecorationImage(
                    image: CachedNetworkImageProvider(hotelData.imgh),
                    fit: BoxFit.cover),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0, right: 10.0),
                child: CircleAvatar(
                    radius: 20.0,
                    backgroundColor: Colors.black12,
                    child: Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                    )),
              ),
              alignment: Alignment.topRight,
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
                              currentLocale == "fr_FR"
                                  ? hotelData.typefr
                                  : hotelData.typeen,
                              style: _txtStyleTitle,
                              overflow: TextOverflow.ellipsis,
                            )),
                        Padding(padding: EdgeInsets.only(top: 5.0)),
                        Row(
                          children: <Widget>[
                            ratingbar(
                              starRating: hotelData.note,
                              color: Colors.blue[300],
                            ),
                            Padding(padding: EdgeInsets.only(left: 5.0)),
                            Text(
                              "(" + hotelData.note.toString() + ")",
                              style: _txtStyleSub,
                            )
                          ],
                        ),
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
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(hotelData.localisation,
                                    style: _txtStyleSub),
                              ),
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
                          hotelData.prix + "\ Fcfa",
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.blue[300],
                              fontWeight: FontWeight.w500,
                              fontFamily: "Gotik"),
                        ),
                        Text(
                            currentLocale == "fr_FR"
                                ? hotelData.perifr
                                : hotelData.perien,
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

class cardLoading extends StatelessWidget {
  @override
  hotelListData data;
  cardLoading(this.data);
  final color = Colors.black38;
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
      child: Container(
        height: 250.0,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black12.withOpacity(0.1),
                  blurRadius: 3.0,
                  spreadRadius: 1.0)
            ]),
        child: Shimmer.fromColors(
          baseColor: color,
          highlightColor: Colors.white,
          child: Column(children: [
            Container(
              height: 165.0,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10.0),
                    topLeft: Radius.circular(10.0)),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0, right: 10.0),
                child: CircleAvatar(
                    radius: 20.0,
                    backgroundColor: Colors.black12,
                    child: Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                    )),
              ),
              alignment: Alignment.topRight,
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
                          height: 25.0,
                          color: Colors.black12,
                        ),
                        Padding(padding: EdgeInsets.only(top: 5.0)),
                        Container(
                          height: 15.0,
                          width: 100.0,
                          color: Colors.black12,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.9),
                          child: Container(
                            height: 12.0,
                            width: 140.0,
                            color: Colors.black12,
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
                        Container(
                          height: 35.0,
                          width: 55.0,
                          color: Colors.black12,
                        ),
                        Padding(padding: EdgeInsets.only(top: 8.0)),
                        Container(
                          height: 10.0,
                          width: 55.0,
                          color: Colors.black12,
                        ),
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
