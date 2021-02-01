import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'Chatting/chatting.dart';
import 'package:sleepmohapp/UI/B1_Home/Hotel/Hotel_Detail_Concept_2/hotelDetail_concept_2.dart';
import 'package:sleepmohapp/core/localizations.dart';
import 'package:sleepmohapp/DataSample/mydata.dart';
import 'package:sleepmohapp/Library/SupportingLibrary/Ratting/Rating.dart';
import 'package:sleepmohapp/DataSample/HebergementsModel.dart';
import 'package:sleepmohapp/DataSample/ConversMod.dart';
import 'package:sleepmohapp/DataSample/UserMod.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sleepmohapp/core/localizations.dart';
import 'package:sleepmohapp/core/preference.dart';


class travelGuide extends StatefulWidget {
 
  

  @override
  _travelGuideState createState() => _travelGuideState();
}
var listHebergements = initlisHebergement.map((model) => HerbergemntMod.fromJson(model)).toList();
String currentLocale;
int inde = 1;
var compteU;
var userconvers = new List<ConversMod>(); 
var userinfos = new List<UserMod>(); 

class _travelGuideState extends State<travelGuide> {


   @override
  void initState() {
    super.initState();
    
      initSaveData();
 }
void initSaveData () async {
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
compteU = false;

 await SharedPreferencesClass.restoreuser("userinfos").then((value) {
   setState(() {
     if(value != ""){
compteU = true;
      Iterable list0 = jsonDecode(value);
        userinfos = list0.map((model) => UserMod.fromJson(model)).toList();
     log('user_value :' + value);
     }
     
   });
     });

   await SharedPreferencesClass.restoreuser("listConversation").then((value) {
   setState(() {
     if(value != ""){
compteU = true;
        Iterable list0 = jsonDecode(value);
        userconvers = list0.map((model) => ConversMod.fromJson(model)).toList();

     }
     
   });
     });
     
   setState(() {
   //  log("message");
  
   currentLocale = (sharedPrefs.get('langue') ?? 'fr');
   
 print('currentLocale');
 print(currentLocale);
   var valuHheberge = sharedPrefs.get('listHebergement');
  
     //listHotels = jsonDecode(sharedPrefs.get('listHotel1'));
//print(valuHotel);
  //  print("listhPref");
     
     if (valuHheberge != null){
       Iterable list1 = jsonDecode(valuHheberge);
       listHebergements = list1.map((model) => HerbergemntMod.fromJson(model)).toList();
     }
      
   
   });
 }



  @override
  Widget build(BuildContext context) {
    var _item = Padding(
      padding: EdgeInsets.only(top: 0.0),
      child: Container(
        height: 200.0,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                primary: false,
                itemBuilder: (ctx, index) {
                  return cardLastActivity(listHebergements[index]);
                },
                itemCount: 10,
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      
      body: ListView.builder(itemBuilder: (context, inde) {
      return StickyHeader(
        header: Container(
          height: 269.0,          
          color: Colors.white,
          child: Column(          
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 20.0,
            ),
            _item,
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, bottom: 0.0),
              child: Text("Liste des conversations",
                  style: TextStyle(
                      fontFamily: "Sofia",
                      fontWeight: FontWeight.w300,
                      fontSize: 17.5,
                      color: Colors.black45)),
            )
            
          ],
        ),
        ),
        content: Column(
          children:<Widget>[
             ListView.builder(              
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                primary: false,
                itemBuilder: (ctx, index) {
                  return messageList(convers: userconvers[index]);
                },
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                itemCount: userconvers.length,
              ),
          ]
        ),
      );
    },
    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
    itemCount: 1,
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
    primary: false,
    ),
    
    );
  }
}
class cardLastActivity extends StatelessWidget {
  HerbergemntMod searchesModel;

  cardLastActivity(this.searchesModel);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0, top: 15.0, bottom: 8.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(PageRouteBuilder(
              pageBuilder: (_, __, ___) => new hotelDetail2(
                    title: searchesModel.typefr,
                    id: searchesModel.id,
                    image: searchesModel.imgh,
                    location: searchesModel.localisation,
                    price: searchesModel.prix,
                    description: searchesModel.description,
                    periode: searchesModel.perifr,
                    ln: searchesModel.ln,
                    lat: searchesModel.lat,
                    note: searchesModel.notefr,
                    acces: searchesModel.accesfr,
                    stanting: searchesModel.standingfr,
                    securi: searchesModel.securitefr,
                    ratting: searchesModel.note,
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
                        width: 150.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(7.0),
                                topRight: Radius.circular(7.0)),
                            image: DecorationImage(
                                image: CachedNetworkImageProvider(searchesModel.imgh),
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
                        currentLocale  == 'fr' ? searchesModel.typefr : searchesModel.typeen,
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
                        currentLocale  == 'fr' ? " / "+searchesModel.perifr : " / "+searchesModel.perien,
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
                              starRating: searchesModel.note,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: Text(
                                currentLocale  == 'fr' ? searchesModel.notefr : searchesModel.noteen,
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
                    Padding(padding: EdgeInsets.only(top: 5.0)),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: Container(
                      width: 130.0,
                      child: Text(
                      searchesModel.localisation,
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class card extends StatelessWidget {
  String profile;
  card({this.profile});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 280.0,
        width: 109.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          boxShadow: [
            BoxShadow(
                blurRadius: 3.0,
                color: Colors.black12.withOpacity(0.1),
                spreadRadius: 1.0)
          ],
          image: DecorationImage(image: AssetImage(profile), fit: BoxFit.cover),
        ),
      ),
    );
  }
}

class messageList extends StatelessWidget {
  ConversMod  convers;
  messageList({this.convers});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        log(convers.iddis);
        userinfos[0].login == convers.iddis
                  ?
        Navigator.of(context).push(PageRouteBuilder(
            pageBuilder: (_, __, ___) => new chatting(                 
                  name: convers.msgdis, 
                  nom: convers.nomdis, 
                  idconvers: convers.id,
                  userinfos: userinfos[0],
                  photoProfile: convers.taille, 
                  idbien: convers.dis1, 
                  typeb: convers.predis,                  
                )))
               :
                 Navigator.of(context).push(PageRouteBuilder(
            pageBuilder: (_, __, ___) => new chatting(
                 
                  name: convers.iddis,
                  idconvers: convers.id,
                  nom: convers.nomdis,
                  userinfos: userinfos[0],
                  photoProfile: convers.taille, 
                  idbien: convers.dis1, 
                  typeb: convers.predis, 
                  
                )));
      },
      child: new Container(
        padding: EdgeInsets.only(left: 0.0, top: 5.0),
        margin: EdgeInsets.only(left: 25.0),
  decoration: BoxDecoration(
    border: Border(bottom: BorderSide( //                   <--- left side
        color: Colors.black,
        width: 0.1,
      ),)
  ),
  child:   Padding(
        padding: const EdgeInsets.only(left: 0.0, bottom: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 50.0,
                  width: 50.0,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: CachedNetworkImageProvider("https://www.sleepmoh.com/manager/avatars/" +convers.taille), fit: BoxFit.cover),
                      color: Colors.black12,
                      borderRadius: BorderRadius.all(Radius.circular(50.0))),
                ),
                
                Padding(
                  padding: const EdgeInsets.only(left: 10.0,top: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    
                    children: <Widget>[
                      userinfos[0].login == convers.iddis
                  ?
                      Text(convers.nomdis,
                          style: TextStyle(
                              fontFamily: "Sofia",
                              fontWeight: FontWeight.w600,
                              fontSize: 15.5,
                              color: Colors.black))
                    :
                     Text(convers.nomdis,
                          style: TextStyle(
                              fontFamily: "Sofia",
                              fontWeight: FontWeight.w600,
                              fontSize: 15.5,
                              color: Colors.black)),


                              Container(
                      width: MediaQuery.of(context).size.width - 160.0,
                      child: Text(convers.message,
                          style: TextStyle(
                              fontFamily: "Sofia",
                              fontWeight: FontWeight.w400,
                              fontSize: 13.5,
                              color: Colors.black45),
                              overflow: TextOverflow.ellipsis,)
                    ),
                      
                    ],
                  ),
                ),
              ],
            ),
           /* Text(convers.surdis,
                style: TextStyle(
                    fontFamily: "Sofia",
                    fontWeight: FontWeight.w300,
                    fontSize: 13.5,
                    color: Colors.black45)),*/
                    Padding(
                  padding: const EdgeInsets.only(left: 10.0,top: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    
                    children: <Widget>[
                                       Text(convers.surdis,
                          style: TextStyle(
                              fontFamily: "Sofia",
                              fontWeight: FontWeight.w300,
                              fontSize: 13.5,
                              color: Colors.black)),

            int.parse(convers.nonlus) > 0
            ?

                              Container(
                      width: 20,
                      margin: EdgeInsets.only(left: 10.0,top: 5.0),
                      padding: EdgeInsets.only(top: 3),
                      height: 20,
                      decoration: BoxDecoration(
                      color: Colors.red,
                     
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                ),
                      child: Text(convers.nonlus,
                      textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: "Sofia",
                              
                              fontWeight: FontWeight.w400,
                              fontSize: 15.5,
                              color: Colors.white),
                              overflow: TextOverflow.ellipsis,)
                    )
                    :
                    Container(),
                      
                    ],
                  ),
                ),
            SizedBox(
              width: 5.0,
            )
          ],
        ),
      ),
)
      
      
      
    
    );
  }
}
