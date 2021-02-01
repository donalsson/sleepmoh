import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:devicelocale/devicelocale.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sleepmohapp/DataSample/HotelModel.dart';
import 'package:sleepmohapp/DataSample/mydata.dart';
import 'package:sleepmohapp/DataSample/ImagesModel.dart';
import 'package:sleepmohapp/UI/B1_Home/B1_Home_Screen/B1_Home_Screen.dart';
import 'package:sleepmohapp/UI/B1_Home/Hotel/Hotel_Detail_Concept_1/reviewDetail1.dart';
import 'package:sleepmohapp/UI/B1_Home/Hotel/Hotel_Detail_Concept_2/maps.dart';
import 'gallery.dart';

class hotelDetail extends StatefulWidget {
  String nom, profilh , destination, image, title, price, location, id;
  double ln, lat;
  hotelDetail({this.image, this.title, this.price, this.location, this.id, this.nom, this.destination, this.profilh, this.ln, this.lat });

  @override
  _hotelDetailState createState() => _hotelDetailState();
}
var listHotels = initlistHotel.map((model) => Hotelht.fromJson(model)).toList();
  var listImages = initlistImages.map((model) => Imagem.fromJson(model)).toList();
  
String currentLocale;
class _hotelDetailState extends State<hotelDetail> {
  @override
  double rating = 3.5;
  final Set<Marker> _markers = {};
  final LatLng _currentPosition = LatLng(40.7078523, -74.008981);
var listImage = listImages;


  @override
  void initState() {
    listImage = listImages.where((i) => i.cat_id == widget.id).toList();
    listHotels = listHotels.where((i) => i.nom == widget.nom).toList();
     initSaveData();
    _markers.add(
      Marker(
        markerId: MarkerId("40.7078523, -74.008981"),
        position: LatLng(widget.lat, widget.ln),
        icon: BitmapDescriptor.defaultMarker,
      ),
    );
    super.initState();
  }
  void initSaveData () async {
    log('detee');
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    currentLocale = await Devicelocale.currentLocale;
    var valuImage = sharedPrefs.get('listImages');
    var valuHotel = sharedPrefs.get('listHotel1');
print(valuImage);
setState(() {
     if (valuHotel != null){
       Iterable list1 = jsonDecode(valuHotel);
        listHotels = list1.map((model) => Hotelht.fromJson(model)).toList();
        listHotels = listHotels.where((i) => i.nom == widget.nom).toList();
     }
    if (valuImage != null){
      Iterable list0 = jsonDecode(valuImage);
      listImages = list0.map((model) => Imagem.fromJson(model)).toList();
      print(listImages);
      listImage = listImages.where((i) => i.cat_id == widget.id).toList();
      print(widget.id);
      print(listImage);
     }
});
  
  }

  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;

    var _icon = Container(
      height: 105.0,
      width: double.infinity,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: _infoCircle("assets/image/icon/wifi.png", "Free Wifi")),
            Padding(
                padding: const EdgeInsets.only(right: 0.0),
                child: _infoCircle("assets/image/icon/food.png", "Food")),
            Padding(
                padding: const EdgeInsets.only(right: 0.0),
                child: _infoCircle("assets/image/icon/clean.png", "Clean")),
            Padding(
                padding: const EdgeInsets.only(right: 0.0),
                child:
                    _infoCircle("assets/image/icon/monitor.png", "Television")),
            Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child:
                    _infoCircle("assets/image/icon/swimming.png", "Swimming")),
          ],
        ),
      ),
    );

    var _desc = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
              top: 20.0, left: 20.0, right: 20.0, bottom: 10.0),
          child: Text(
            "Description",
            style: TextStyle(
                fontFamily: "Sofia",
                fontSize: 20.0,
                fontWeight: FontWeight.w700),
            textAlign: TextAlign.justify,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              top: 0.0, left: 20.0, right: 20.0, bottom: 50.0),
          child: Text(widget.destination,
            style: TextStyle(
                fontFamily: "Sofia",
                color: Colors.black54,
                fontSize: 16.0,
                fontWeight: FontWeight.w400),
            textAlign: TextAlign.justify,
          ),
        ),
      ],
    );

    var _location = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
              top: 0.0, left: 20.0, right: 20.0, bottom: 20.0),
          child: Text(
            "Localisation",
            style: TextStyle(
                fontFamily: "Sofia",
                fontSize: 20.0,
                fontWeight: FontWeight.w700),
            textAlign: TextAlign.justify,
          ),
        ),
        Stack(
          children: <Widget>[
            Container(
              height: 190.0,
              child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                  target: LatLng(widget.lat, widget.ln),
                  zoom: 13.0,
                ),
                markers: _markers,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 135.0, right: 60.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                        PageRouteBuilder(pageBuilder: (_, __, ___) => maps()));
                  },
                  child: Container(
                    height: 35.0,
                    width: 95.0,
                    decoration: BoxDecoration(
                        color: Colors.black12.withOpacity(0.5),
                        borderRadius: BorderRadius.all(Radius.circular(30.0))),
                    child: Center(
                      child: Text("Voir la carte",
                          style: TextStyle(
                              color: Colors.white, fontFamily: "Sofia")),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );

    var _gallery = Column(  

      
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 40.0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Images",
                  style: TextStyle(
                      fontFamily: "Sofia",
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700),
                ),
              ]),
        ),
        SizedBox(
          height: 10.0,
        ),
         // _relatedPost("assets/image/room/room7.jpg", "The Cheeses Guide",
        Container(
          height: 200.0,
          child:ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                primary: false,
                itemBuilder: (ctx, index) {
                  return _galeriepost(listImage[index].imgh_name,context,listImage);
                },
                itemCount: listImage.length,
              ),
          
        )
       
      ],
   
    );

    var _ratting = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Container(
            width: 600.0,
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                color: Color(0xFF656565).withOpacity(0.15),
                blurRadius: 1.0,
                spreadRadius: 0.2,
              )
            ]),
            child: Padding(
              padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Reviews",
                        style: TextStyle(
                            fontFamily: "Sofia",
                            fontSize: 20.0,
                            fontWeight: FontWeight.w700),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, top: 15.0, bottom: 15.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            InkWell(
                              child: Padding(
                                  padding: EdgeInsets.only(top: 2.0),
                                  child: Text(
                                    "View All",
                                    style: TextStyle(
                                        color: Colors.indigoAccent,
                                        fontSize: 14.0),
                                  )),
                              onTap: () {
                                Navigator.of(context).push(PageRouteBuilder(
                                    pageBuilder: (_, __, ___) =>
                                        reviewDetail1()));
                              },
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 15.0, top: 2.0),
                              child: Icon(
                                Icons.arrow_forward_ios,
                                size: 18.0,
                                color: Colors.black54,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            StarRating(
                              size: 25.0,
                              starCount: 5,
                              rating: 4.0,
                              color: Colors.yellow,
                            ),
                            SizedBox(width: 5.0),
                            Text("8 Reviews")
                          ]),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 0.0, right: 20.0, top: 15.0, bottom: 7.0),
                    child: _line(),
                  ),
                  _buildRating("18 Nov 2018",
                      "Item Delivered in good condition. I will recommended to other buyer.",
                      (rating) {
                    setState(() {
                      this.rating = rating;
                    });
                  }, "assets/image/profile/profile1.jpg"),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 0.0, right: 20.0, top: 15.0, bottom: 7.0),
                    child: _line(),
                  ),
                  _buildRating("18 Nov 2018",
                      "Item Delivered in good condition. I will recommended to other buyer.",
                      (rating) {
                    setState(() {
                      this.rating = rating;
                    });
                  }, "assets/image/profile/profile2.jpg"),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 0.0, right: 20.0, top: 15.0, bottom: 7.0),
                    child: _line(),
                  ),
                  _buildRating("18 Nov 2018",
                      "Item Delivered in good condition. I will recommended to other buyer.",
                      (rating) {
                    setState(() {
                      this.rating = rating;
                    });
                  }, "assets/image/profile/profile3.jpg"),
                  Padding(padding: EdgeInsets.only(bottom: 20.0)),
                ],
              ),
            ),
          ),
        ),
      ],
    );

    var _relatedPostVar = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 40.0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Autres chambres de " + widget.nom,
                  style: TextStyle(
                      fontFamily: "Sofia",
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700),
                )
              ]),
        ),
        SizedBox(
          height: 10.0,
        ),
         // _relatedPost("assets/image/room/room7.jpg", "The Cheeses Guide",
        Container(
          height: 200.0,
          child:ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                primary: false,
                itemBuilder: (ctx, index) {
                  return _relatedPost(context, listHotels[index].imgh, listHotels[index].type, listHotels[index].localisation, listHotels[index].nombreetoile, listHotels[index]);
                },
                itemCount: listHotels.length,
              ),
          
      
        ),
        SizedBox(
          height: 40.0,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15.0),
          child: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              height: 55.0,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  gradient: LinearGradient(
                      colors: [
                        Colors.blue,
                        Colors.blue[300],
                      ],
                      begin: const FractionalOffset(0.0, 0.0),
                      end: const FractionalOffset(1.0, 0.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp)),
              child: Center(
                child: Text(
                  "Réserver",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 19.0,
                      fontFamily: "Sofia",
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 30.0,
        ),
      ],
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          scrollDirection: Axis.vertical,
          slivers: <Widget>[
            SliverPersistentHeader(
              /// Create Appbar
              delegate: MySliverAppBar(
                  expandedHeight: _height - 30.0,
                  img: widget.image,
                  nom: widget.nom,
                  id: widget.id,
                  title: widget.title,
                  price: widget.price,
                  location: widget.location),
              pinned: true,
            ),

            /// Create body
            SliverToBoxAdapter(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                  /// For icon row
                  _icon,

                  /// Desc
                  _desc,

                  /// Location
                  _location,

                  /// Gallery
                  _gallery,

                  /// Ratting
               //   _ratting,

                  ///Related Post
                  _relatedPostVar,
                ])),
          ],
        ),
      ),
    );
  }
}

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;

  String img, nom, id, title, price, location;

  MySliverAppBar(
      {@required this.expandedHeight,
      this.img,
      this.nom,
      this.id,
      this.title,
      this.price,
      this.location});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      overflow: Overflow.clip,
      children: [
        Container(
          height: 50.0,
          width: double.infinity,
          color: Colors.white,
        ),
        Align(
          alignment: Alignment.center,
          child: Text(
            nom,
            style: TextStyle(
              color: Colors.black,
              fontFamily: "Gotik",
              fontWeight: FontWeight.w700,
              fontSize: (expandedHeight / 40) - (shrinkOffset / 40) + 18,
            ),
          ),
        ),
        Opacity(
          opacity: (1 - shrinkOffset / expandedHeight),
          child: Hero(
            tag: 'hero-tag-${id}',
            child: new DecoratedBox(
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  fit: BoxFit.cover,
                  image: CachedNetworkImageProvider(img),
                ),
                shape: BoxShape.rectangle,
              ),
              child: Container(
                margin: EdgeInsets.only(top: 130.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: FractionalOffset(0.0, 0.0),
                    end: FractionalOffset(0.0, 1.0),
                    stops: [0.0, 1.0],
                    colors: <Color>[
                      Color(0x00FFFFFF),
                      Color(0xFFFFFFFF),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Opacity(
            opacity: (1 - shrinkOffset / expandedHeight),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width - 30,
                    child: Text(
                      title,
                      style: TextStyle(
                          color: Colors.black87.withOpacity(0.65),
                          fontSize: 30.5,
                          fontFamily: "Sofia",
                          fontWeight: FontWeight.w700),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.location_on,
                        size: 14.0,
                        color: Colors.black26,
                      ),
                      Text(
                        location,
                        style: TextStyle(
                            color: Colors.black26,
                            fontSize: 14.5,
                            fontFamily: "Popins",
                            fontWeight: FontWeight.w800),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, top: 10.0, bottom: 10.0),
                  child: Container(
                    child: Text(
                      price,
                      style: TextStyle(
                          color: Color(0xFF8F73F2),
                          fontSize: 25.5,
                          fontFamily: "Popins",
                          fontWeight: FontWeight.w800),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0, left: 20.0),
                      child: Container(
                          height: 35.0,
                          width: 35.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(40.0),
                            ),
                            color: Colors.white70,
                          ),
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                          )),
                    ))),
            SizedBox(
              width: 36.0,
            )
          ],
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}

Widget _photo(String image) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 110.0,
          width: 140.0,
          decoration: BoxDecoration(
              image:
                  DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
              color: Colors.black12,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              boxShadow: [
                BoxShadow(
                    blurRadius: 5.0,
                    color: Colors.black12.withOpacity(0.1),
                    spreadRadius: 2.0)
              ]),
        ),
        SizedBox(
          height: 5.0,
        ),
      ],
    ),
  );
}


Widget _relatedPost(BuildContext context, String image, title, location, ratting, Hotelht listhh) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: InkWell(
        onTap: () {
          Navigator.of(context).push(PageRouteBuilder(
              pageBuilder: (_, __, ___) => new hotelDetail(
                    title: listhh.type,
                    id: listhh.id,
                    image: listhh.imgh,
                    location: listhh.localisation,
                    price: listhh.prix.toString(),
                    nom: listhh.nom,
                    destination: listhh.description,
                    profilh: listhh.imghotel,
                    ln: listhh.ln,
                    lat: listhh.lat,
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
          height: 110.0,
          width: 180.0,
          decoration: BoxDecoration(
              image:
                  DecorationImage(image: CachedNetworkImageProvider(image), fit: BoxFit.cover),
              color: Colors.black12,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              boxShadow: [
                BoxShadow(
                    blurRadius: 5.0,
                    color: Colors.black12.withOpacity(0.1),
                    spreadRadius: 2.0)
              ]),
        ),
        SizedBox(
          height: 5.0,
        ),
        Text(
          title,
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
              location,
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
                listhh.prix + ' Fcfa' + ' /' + 'Jour',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontFamily: "Sofia",
                    fontSize: 13.0),
              ),
            ),

            // Text("(233 Rating)",style: TextStyle(fontWeight: FontWeight.w500,fontFamily: "Sofia",fontSize: 11.0,color: Colors.black45),),
            SizedBox(
              width: 35.0,
            ),
          ],
        ),
      ],
    ),
    ),
  );
}

/*
Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 110.0,
          width: 180.0,
          decoration: BoxDecoration(
              image:
                  DecorationImage(image: CachedNetworkImageProvider(image), fit: BoxFit.cover),
              color: Colors.black12,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              boxShadow: [
                BoxShadow(
                    blurRadius: 5.0,
                    color: Colors.black12.withOpacity(0.1),
                    spreadRadius: 2.0)
              ]),
        ),
        SizedBox(
          height: 5.0,
        ),
        Text(
          title,
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
              location,
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
                listhh.prix + ' Fcfa' + ' /' + 'Jour',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontFamily: "Sofia",
                    fontSize: 13.0),
              ),
            ),

            // Text("(233 Rating)",style: TextStyle(fontWeight: FontWeight.w500,fontFamily: "Sofia",fontSize: 11.0,color: Colors.black45),),
            SizedBox(
              width: 35.0,
            ),
          ],
        ),
      ],
    ),
*/

Widget _galeriepost(String image, BuildContext context, List<Imagem> listImage) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
         Container(
                 height: 180.0,
          width: 180.0,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: CachedNetworkImageProvider(
                            image,
                          ),
                          fit: BoxFit.cover)),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(PageRouteBuilder(
                          pageBuilder: (_, __, ___) => new gallery(
                            img: listImage,
                            )));
                    },
                    child: Container(
                      height: 10.0,
                      width: 10.0,
                      color: Colors.black54,
                      child: Center(
                        child: Text("See More",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Sofia",
                                fontWeight: FontWeight.w500,
                                fontSize: 16.0)),
                      ),
                    ),
                  ),
                ),
      ],
    ),
  );
}

Widget _infoCircle(String image, title) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Container(
          height: 45.0,
          width: 45.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(50.0)),
              color: Color(0xFFF0E5FB)),
          child: Center(
            child: Image.asset(
              image,
              height: 22.0,
              color: Colors.deepPurple,
            ),
          )),
      Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                  fontFamily: "Sofia",
                  fontWeight: FontWeight.w400,
                  color: Colors.black54,
                  fontSize: 11.0),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      )
    ],
  );
}

Widget _line() {
  return Container(
    height: 0.9,
    width: double.infinity,
    color: Colors.black12,
  );
}

Widget _buildRating(
    String date, String details, Function changeRating, String image) {
  return ListTile(
    leading: Container(
      height: 45.0,
      width: 45.0,
      decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
          borderRadius: BorderRadius.all(Radius.circular(50.0))),
    ),
    title: Row(
      children: <Widget>[
        StarRating(
            size: 20.0,
            rating: 3.5,
            starCount: 5,
            color: Colors.yellow,
            onRatingChanged: changeRating),
        SizedBox(width: 8.0),
        Text(
          date,
          style: TextStyle(fontSize: 12.0),
        )
      ],
    ),
    subtitle: Text(
      details,
      style: TextStyle(fontFamily: "Sofia", fontWeight: FontWeight.w300),
    ),
  );
}

class imageDetails extends StatelessWidget {
  String img;
  imageDetails({this.img});
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;

    return Padding(
      
      padding: const EdgeInsets.only(left: 18.0, top: 10.0, bottom: 8.0),
      child: InkWell(
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
                    tag: 'hero-tag-${img}',
                    child: Material(
                      child: Container(
                        height: 140.0,
                        width: 140.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(7.0),
                                topRight: Radius.circular(7.0)),
                            image: DecorationImage(
                                image: CachedNetworkImageProvider(img),
                                fit: BoxFit.cover)),
                      ),
                    ),
                  )
                
                ],
              ),
            ],
          ),
        ),
      ),
    
    );
  }
}

