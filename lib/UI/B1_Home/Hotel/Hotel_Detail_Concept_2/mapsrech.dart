import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flutter/services.dart' show rootBundle;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sleepmohapp/DataSample/EntreMod.dart';
import 'package:sleepmohapp/DataSample/HebergementsModel.dart';
import 'package:sleepmohapp/DataSample/HotelModel.dart';
import 'package:sleepmohapp/DataSample/ImmobModel.dart';
import 'package:sleepmohapp/DataSample/MaisonModel.dart';
import 'package:sleepmohapp/DataSample/RecherMod.dart';
import 'package:sleepmohapp/DataSample/TerrainModel.dart';
import 'package:sleepmohapp/DataSample/TourismeModel.dart';
import 'package:sleepmohapp/Library/SupportingLibrary/Ratting/Rating.dart';
import 'package:sleepmohapp/UI/B1_Home/Hotel/Hotel_Detail_Concept_1/hotelDetail_concept_1.dart';
import 'package:sleepmohapp/UI/B1_Home/Hotel/Hotel_Detail_Concept_2/maisondetails.dart';
import 'package:sleepmohapp/UI/B1_Home/Hotel/Hotel_Detail_Concept_2/terrainsdetails.dart';

import 'package:sleepmohapp/core/localizations.dart';
import 'hotelDetail_concept_2.dart';
import 'immodelails.dart';

class mapsrecher extends StatefulWidget {
  mapsrecher({Key key}) : super(key: key);
  @override
  _mapsrecherState createState() => _mapsrecherState();
}

class _mapsrecherState extends State<mapsrecher> {
  String currentLocale;
  GoogleMapController _controller;
  BitmapDescriptor customIcon;
  bool isMapCreated = false;
  String _mapStyle;
  List<Marker> allMarkers = [];
  PageController _pageController;
  PageController _pageControllerhebergement;
  PageController _pageControllerImmo;
  PageController _pageControllerTerrain;
  PageController _pageControllerEtudiant;
  PageController _pageControllerheMaison;
  PageController _pageControllerheTourisme;
  int prevPage;
  int i = 0;
  int ii = 0;

  String dropdownValue;
  String dropdownscat;
  String dropdownsprixt;

  var listHotels = new List<Hotelht>();
  var listHebergement = new List<HerbergemntMod>();

  var listTourisme = new List<Tourisme>();
  var listImmo = new List<ImmobMod>();
  var listEtudiant = new List<EntreMod>();
  var listMaison = new List<MaisonMod>();
  var listTerrain = new List<TerrainMod>();

  RecherMod element;
  List<String> _items;

  List<String> _items0;

  List<String> _items1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setCustomMapPin();
    print("mappp");

    listMarkersli(context);
    _pageController = PageController(initialPage: 1, viewportFraction: 0.8)
      ..addListener(_onScroll);
    _pageControllerhebergement =
        PageController(initialPage: 1, viewportFraction: 0.8)
          ..addListener(_onScrollheber);
    _pageControllerImmo = PageController(initialPage: 1, viewportFraction: 0.8)
      ..addListener(_onScrollimmo);
    _pageControllerTerrain =
        PageController(initialPage: 1, viewportFraction: 0.8)
          ..addListener(_onScrollterr);
    _pageControllerEtudiant =
        PageController(initialPage: 1, viewportFraction: 0.8)
          ..addListener(_onScrolletud);
    _pageControllerheMaison =
        PageController(initialPage: 1, viewportFraction: 0.8)
          ..addListener(_onScrollmaiso);
    _pageControllerheTourisme =
        PageController(initialPage: 1, viewportFraction: 0.8)
          ..addListener(_onScrolltouris);
  }

  Future<void> listMarkersli(BuildContext context) async {
    print("listmap");

    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    setState(() {
      currentLocale = (sharedPrefs.get('langue') ?? 'fr');

      Iterable list = jsonDecode(sharedPrefs.get('listHotel1'));
      listHotels = list.map((model) => Hotelht.fromJson(model)).toList();

      Iterable list0 = jsonDecode(sharedPrefs.get('listHebergement'));
      listHebergement =
          list0.map((model) => HerbergemntMod.fromJson(model)).toList();

      Iterable list1 = jsonDecode(sharedPrefs.get('listTourisme'));
      listTourisme = list1.map((model) => Tourisme.fromJson(model)).toList();

      Iterable list2 = jsonDecode(sharedPrefs.get('listImobi'));
      listImmo = list2.map((model) => ImmobMod.fromJson(model)).toList();

      Iterable list3 = jsonDecode(sharedPrefs.get('listTerrain'));
      listTerrain = list3.map((model) => TerrainMod.fromJson(model)).toList();

      Iterable list4 = jsonDecode(sharedPrefs.get('listMaison'));
      listMaison = list4.map((model) => MaisonMod.fromJson(model)).toList();

      Iterable list5 = jsonDecode(sharedPrefs.get('listEntre'));
      listEtudiant = list5.map((model) => EntreMod.fromJson(model)).toList();

      if (dropdownscat == AppLocalizations.of(context).chamm) {
        // listHebergement = listHebergement.where((element) => element.type == "chm").toList();
        if (dropdownsprixt == AppLocalizations.of(context).zcinq) {
          listHebergement = listHebergement
              .where((element) =>
                  element.type == "chm" && int.parse(element.prix) <= 50000)
              .toList();
        } else {
          if (dropdownsprixt == AppLocalizations.of(context).cindeux) {
            listHebergement = listHebergement
                .where((element) =>
                    element.type == "chm" &&
                    int.parse(element.prix) >= 50001 &&
                    int.parse(element.prix) <= 200000)
                .toList();
          } else {
            if (dropdownsprixt == AppLocalizations.of(context).deuxcin) {
              listHebergement = listHebergement
                  .where((element) =>
                      element.type == "chm" &&
                      int.parse(element.prix) >= 200001 &&
                      int.parse(element.prix) <= 500000)
                  .toList();
            } else {
              if (dropdownsprixt == AppLocalizations.of(context).cindun) {
                listHebergement = listHebergement
                    .where((element) =>
                        element.type == "chm" &&
                        int.parse(element.prix) >= 500001 &&
                        int.parse(element.prix) <= 1000000)
                    .toList();
              } else {
                if (dropdownsprixt == AppLocalizations.of(context).supun) {
                  listHebergement = listHebergement
                      .where((element) =>
                          element.type == "chm" &&
                          int.parse(element.prix) > 1000000)
                      .toList();
                } else {
                  listHebergement = listHebergement
                      .where((element) => element.type == "chm")
                      .toList();
                }
              }
            }
          }
        }
      }

      if (dropdownscat == AppLocalizations.of(context).chamnm) {
        if (dropdownsprixt == AppLocalizations.of(context).zcinq) {
          listHebergement = listHebergement
              .where((element) =>
                  element.type == "chnm" && int.parse(element.prix) <= 50000)
              .toList();
        } else {
          if (dropdownsprixt == AppLocalizations.of(context).cindeux) {
            listHebergement = listHebergement
                .where((element) =>
                    element.type == "chnm" &&
                    int.parse(element.prix) >= 50001 &&
                    int.parse(element.prix) <= 200000)
                .toList();
          } else {
            if (dropdownsprixt == AppLocalizations.of(context).deuxcin) {
              listHebergement = listHebergement
                  .where((element) =>
                      element.type == "chnm" &&
                      int.parse(element.prix) >= 200001 &&
                      int.parse(element.prix) <= 500000)
                  .toList();
            } else {
              if (dropdownsprixt == AppLocalizations.of(context).cindun) {
                listHebergement = listHebergement
                    .where((element) =>
                        element.type == "chnm" &&
                        int.parse(element.prix) >= 500001 &&
                        int.parse(element.prix) <= 1000000)
                    .toList();
              } else {
                if (dropdownsprixt == AppLocalizations.of(context).supun) {
                  listHebergement = listHebergement
                      .where((element) =>
                          element.type == "chnm" &&
                          int.parse(element.prix) > 1000000)
                      .toList();
                } else {
                  listHebergement = listHebergement
                      .where((element) => element.type == "chnm")
                      .toList();
                }
              }
            }
          }
        }
      }

      if (dropdownscat == AppLocalizations.of(context).stum) {
        // listHebergement = listHebergement.where((element) => element.type == "stm").toList();
        if (dropdownsprixt == AppLocalizations.of(context).zcinq) {
          listHebergement = listHebergement
              .where((element) =>
                  element.type == "stm" && int.parse(element.prix) <= 50000)
              .toList();
        } else {
          if (dropdownsprixt == AppLocalizations.of(context).cindeux) {
            listHebergement = listHebergement
                .where((element) =>
                    element.type == "stm" &&
                    int.parse(element.prix) >= 50001 &&
                    int.parse(element.prix) <= 200000)
                .toList();
          } else {
            if (dropdownsprixt == AppLocalizations.of(context).deuxcin) {
              listHebergement = listHebergement
                  .where((element) =>
                      element.type == "stm" &&
                      int.parse(element.prix) >= 200001 &&
                      int.parse(element.prix) <= 500000)
                  .toList();
            } else {
              if (dropdownsprixt == AppLocalizations.of(context).cindun) {
                listHebergement = listHebergement
                    .where((element) =>
                        element.type == "stm" &&
                        int.parse(element.prix) >= 500001 &&
                        int.parse(element.prix) <= 1000000)
                    .toList();
              } else {
                if (dropdownsprixt == AppLocalizations.of(context).supun) {
                  listHebergement = listHebergement
                      .where((element) =>
                          element.type == "stm" &&
                          int.parse(element.prix) > 1000000)
                      .toList();
                } else {
                  listHebergement = listHebergement
                      .where((element) => element.type == "stm")
                      .toList();
                }
              }
            }
          }
        }
      }

      if (dropdownscat == AppLocalizations.of(context).stunm) {
        listHebergement =
            listHebergement.where((element) => element.type == "stnm").toList();
        if (dropdownsprixt == AppLocalizations.of(context).zcinq) {
          listHebergement = listHebergement
              .where((element) =>
                  element.type == "stnm" && int.parse(element.prix) <= 50000)
              .toList();
        } else {
          if (dropdownsprixt == AppLocalizations.of(context).cindeux) {
            listHebergement = listHebergement
                .where((element) =>
                    element.type == "stnm" &&
                    int.parse(element.prix) >= 50001 &&
                    int.parse(element.prix) <= 200000)
                .toList();
          } else {
            if (dropdownsprixt == AppLocalizations.of(context).deuxcin) {
              listHebergement = listHebergement
                  .where((element) =>
                      element.type == "stnm" &&
                      int.parse(element.prix) >= 200001 &&
                      int.parse(element.prix) <= 500000)
                  .toList();
            } else {
              if (dropdownsprixt == AppLocalizations.of(context).cindun) {
                listHebergement = listHebergement
                    .where((element) =>
                        element.type == "stnm" &&
                        int.parse(element.prix) >= 500001 &&
                        int.parse(element.prix) <= 1000000)
                    .toList();
              } else {
                if (dropdownsprixt == AppLocalizations.of(context).supun) {
                  listHebergement = listHebergement
                      .where((element) =>
                          element.type == "stnm" &&
                          int.parse(element.prix) > 1000000)
                      .toList();
                } else {
                  listHebergement = listHebergement
                      .where((element) => element.type == "stm")
                      .toList();
                }
              }
            }
          }
        }
      }

      if (dropdownscat == AppLocalizations.of(context).appnm) {
        if (dropdownsprixt == AppLocalizations.of(context).zcinq) {
          listHebergement = listHebergement
              .where((element) =>
                  element.type == "apnm" && int.parse(element.prix) <= 50000)
              .toList();
        } else {
          if (dropdownsprixt == AppLocalizations.of(context).cindeux) {
            listHebergement = listHebergement
                .where((element) =>
                    element.type == "apnm" &&
                    int.parse(element.prix) >= 50001 &&
                    int.parse(element.prix) <= 200000)
                .toList();
          } else {
            if (dropdownsprixt == AppLocalizations.of(context).deuxcin) {
              listHebergement = listHebergement
                  .where((element) =>
                      element.type == "apnm" &&
                      int.parse(element.prix) >= 200001 &&
                      int.parse(element.prix) <= 500000)
                  .toList();
            } else {
              if (dropdownsprixt == AppLocalizations.of(context).cindun) {
                listHebergement = listHebergement
                    .where((element) =>
                        element.type == "apnm" &&
                        int.parse(element.prix) >= 500001 &&
                        int.parse(element.prix) <= 1000000)
                    .toList();
              } else {
                if (dropdownsprixt == AppLocalizations.of(context).supun) {
                  listHebergement = listHebergement
                      .where((element) =>
                          element.type == "apnm" &&
                          int.parse(element.prix) > 1000000)
                      .toList();
                } else {
                  listHebergement = listHebergement
                      .where((element) => element.type == "apnm")
                      .toList();
                }
              }
            }
          }
        }
      }

      if (dropdownscat == AppLocalizations.of(context).appm) {
        if (dropdownsprixt == AppLocalizations.of(context).zcinq) {
          listHebergement = listHebergement
              .where((element) =>
                  element.type == "apm" && int.parse(element.prix) <= 50000)
              .toList();
        } else {
          if (dropdownsprixt == AppLocalizations.of(context).cindeux) {
            listHebergement = listHebergement
                .where((element) =>
                    element.type == "apm" &&
                    int.parse(element.prix) >= 50001 &&
                    int.parse(element.prix) <= 200000)
                .toList();
          } else {
            if (dropdownsprixt == AppLocalizations.of(context).deuxcin) {
              listHebergement = listHebergement
                  .where((element) =>
                      element.type == "apm" &&
                      int.parse(element.prix) >= 200001 &&
                      int.parse(element.prix) <= 500000)
                  .toList();
            } else {
              if (dropdownsprixt == AppLocalizations.of(context).cindun) {
                listHebergement = listHebergement
                    .where((element) =>
                        element.type == "apm" &&
                        int.parse(element.prix) >= 500001 &&
                        int.parse(element.prix) <= 1000000)
                    .toList();
              } else {
                if (dropdownsprixt == AppLocalizations.of(context).supun) {
                  listHebergement = listHebergement
                      .where((element) =>
                          element.type == "apm" &&
                          int.parse(element.prix) > 1000000)
                      .toList();
                } else {
                  listHebergement = listHebergement
                      .where((element) => element.type == "apm")
                      .toList();
                }
              }
            }
          }
        }
      }
/*
   if (dropdownsprixt == AppLocalizations.of(context).zcinq){

    }else{
      if (dropdownsprixt == AppLocalizations.of(context).cindeux){

      }else{
         if (dropdownsprixt == AppLocalizations.of(context).deuxcin){

          }else{
              if (dropdownsprixt == AppLocalizations.of(context).cindun){

              }else{
                  if (dropdownsprixt == AppLocalizations.of(context).supun){

                  }else{
                    
                  }
              }
          }
      }
    }
*/

      if (dropdownscat == AppLocalizations.of(context).salf) {
        //print("dddde");
        if (dropdownsprixt == AppLocalizations.of(context).zcinq) {
          //  print("object");
          listImmo = listImmo
              .where((element) =>
                  element.type == "salf" && int.parse(element.prix) <= 50000)
              .toList();
        } else {
          if (dropdownsprixt == AppLocalizations.of(context).cindeux) {
            listImmo = listImmo
                .where((element) =>
                    element.type == "salf" &&
                    int.parse(element.prix) >= 50001 &&
                    int.parse(element.prix) <= 200000)
                .toList();
          } else {
            if (dropdownsprixt == AppLocalizations.of(context).deuxcin) {
              listImmo = listImmo
                  .where((element) =>
                      element.type == "salf" &&
                      int.parse(element.prix) >= 200001 &&
                      int.parse(element.prix) <= 500000)
                  .toList();
            } else {
              if (dropdownsprixt == AppLocalizations.of(context).cindun) {
                listImmo = listImmo
                    .where((element) =>
                        element.type == "salf" &&
                        int.parse(element.prix) >= 500001 &&
                        int.parse(element.prix) <= 1000000)
                    .toList();
              } else {
                if (dropdownsprixt == AppLocalizations.of(context).supun) {
                  listImmo = listImmo
                      .where((element) =>
                          element.type == "salf" &&
                          int.parse(element.prix) > 1000000)
                      .toList();
                } else {
                  listImmo = listImmo
                      .where((element) => element.type == "salf")
                      .toList();
                }
              }
            }
          }
        }
      }

      if (dropdownscat == AppLocalizations.of(context).magg) {
        //print("dddde");
        if (dropdownsprixt == AppLocalizations.of(context).zcinq) {
          //  print("object");
          listImmo = listImmo
              .where((element) =>
                  element.type == "mag" && int.parse(element.prix) <= 50000)
              .toList();
        } else {
          if (dropdownsprixt == AppLocalizations.of(context).cindeux) {
            listImmo = listImmo
                .where((element) =>
                    element.type == "mag" &&
                    int.parse(element.prix) >= 50001 &&
                    int.parse(element.prix) <= 200000)
                .toList();
          } else {
            if (dropdownsprixt == AppLocalizations.of(context).deuxcin) {
              listImmo = listImmo
                  .where((element) =>
                      element.type == "mag" &&
                      int.parse(element.prix) >= 200001 &&
                      int.parse(element.prix) <= 500000)
                  .toList();
            } else {
              if (dropdownsprixt == AppLocalizations.of(context).cindun) {
                listImmo = listImmo
                    .where((element) =>
                        element.type == "mag" &&
                        int.parse(element.prix) >= 500001 &&
                        int.parse(element.prix) <= 1000000)
                    .toList();
              } else {
                if (dropdownsprixt == AppLocalizations.of(context).supun) {
                  listImmo = listImmo
                      .where((element) =>
                          element.type == "mag" &&
                          int.parse(element.prix) > 1000000)
                      .toList();
                } else {
                  listImmo = listImmo
                      .where((element) => element.type == "mag")
                      .toList();
                }
              }
            }
          }
        }
      }

      if (dropdownscat == AppLocalizations.of(context).terra) {
        //print("dddde");
        if (dropdownsprixt == AppLocalizations.of(context).zcinq) {
          //  print("object");
          listImmo = listImmo
              .where((element) =>
                  element.type == "trs" && int.parse(element.prix) <= 50000)
              .toList();
        } else {
          if (dropdownsprixt == AppLocalizations.of(context).cindeux) {
            listImmo = listImmo
                .where((element) =>
                    element.type == "trs" &&
                    int.parse(element.prix) >= 50001 &&
                    int.parse(element.prix) <= 200000)
                .toList();
          } else {
            if (dropdownsprixt == AppLocalizations.of(context).deuxcin) {
              listImmo = listImmo
                  .where((element) =>
                      element.type == "trs" &&
                      int.parse(element.prix) >= 200001 &&
                      int.parse(element.prix) <= 500000)
                  .toList();
            } else {
              if (dropdownsprixt == AppLocalizations.of(context).cindun) {
                listImmo = listImmo
                    .where((element) =>
                        element.type == "trs" &&
                        int.parse(element.prix) >= 500001 &&
                        int.parse(element.prix) <= 1000000)
                    .toList();
              } else {
                if (dropdownsprixt == AppLocalizations.of(context).supun) {
                  listImmo = listImmo
                      .where((element) =>
                          element.type == "trs" &&
                          int.parse(element.prix) > 1000000)
                      .toList();
                } else {
                  listImmo = listImmo
                      .where((element) => element.type == "trs")
                      .toList();
                }
              }
            }
          }
        }
      }

      if (dropdownscat == AppLocalizations.of(context).burr) {
        //print("dddde");
        if (dropdownsprixt == AppLocalizations.of(context).zcinq) {
          //  print("object");
          listImmo = listImmo
              .where((element) =>
                  element.type == "bur" && int.parse(element.prix) <= 50000)
              .toList();
        } else {
          if (dropdownsprixt == AppLocalizations.of(context).cindeux) {
            listImmo = listImmo
                .where((element) =>
                    element.type == "bur" &&
                    int.parse(element.prix) >= 50001 &&
                    int.parse(element.prix) <= 200000)
                .toList();
          } else {
            if (dropdownsprixt == AppLocalizations.of(context).deuxcin) {
              listImmo = listImmo
                  .where((element) =>
                      element.type == "bur" &&
                      int.parse(element.prix) >= 200001 &&
                      int.parse(element.prix) <= 500000)
                  .toList();
            } else {
              if (dropdownsprixt == AppLocalizations.of(context).cindun) {
                listImmo = listImmo
                    .where((element) =>
                        element.type == "bur" &&
                        int.parse(element.prix) >= 500001 &&
                        int.parse(element.prix) <= 1000000)
                    .toList();
              } else {
                if (dropdownsprixt == AppLocalizations.of(context).supun) {
                  listImmo = listImmo
                      .where((element) =>
                          element.type == "bur" &&
                          int.parse(element.prix) > 1000000)
                      .toList();
                } else {
                  listImmo = listImmo
                      .where((element) => element.type == "bur")
                      .toList();
                }
              }
            }
          }
        }
      }
/*
   if (dropdownsprixt == AppLocalizations.of(context).zcinq){

    }else{
      if (dropdownsprixt == AppLocalizations.of(context).cindeux){

      }else{
         if (dropdownsprixt == AppLocalizations.of(context).deuxcin){

          }else{
              if (dropdownsprixt == AppLocalizations.of(context).cindun){

              }else{
                  if (dropdownsprixt == AppLocalizations.of(context).supun){

                  }else{
                    
                  }
              }
          }
      }
    }
*/
      if (dropdownscat == AppLocalizations.of(context).park) {
        //print("dddde");
        if (dropdownsprixt == AppLocalizations.of(context).zcinq) {
          //  print("object");
          listTourisme = listTourisme
              .where((element) =>
                  element.type == "Pack Nationnal" &&
                  int.parse(element.prix) <= 50000)
              .toList();
        } else {
          if (dropdownsprixt == AppLocalizations.of(context).cindeux) {
            listTourisme = listTourisme
                .where((element) =>
                    element.type == "Pack Nationnal" &&
                    int.parse(element.prix) >= 50001 &&
                    int.parse(element.prix) <= 200000)
                .toList();
          } else {
            if (dropdownsprixt == AppLocalizations.of(context).deuxcin) {
              listTourisme = listTourisme
                  .where((element) =>
                      element.type == "Pack Nationnal" &&
                      int.parse(element.prix) >= 200001 &&
                      int.parse(element.prix) <= 500000)
                  .toList();
            } else {
              if (dropdownsprixt == AppLocalizations.of(context).cindun) {
                listTourisme = listTourisme
                    .where((element) =>
                        element.type == "Pack Nationnal" &&
                        int.parse(element.prix) >= 500001 &&
                        int.parse(element.prix) <= 1000000)
                    .toList();
              } else {
                if (dropdownsprixt == AppLocalizations.of(context).supun) {
                  listTourisme = listTourisme
                      .where((element) =>
                          element.type == "Pack Nationnal" &&
                          int.parse(element.prix) > 1000000)
                      .toList();
                } else {
                  listTourisme = listTourisme
                      .where((element) => element.type == "Pack Nationnal")
                      .toList();
                }
              }
            }
          }
        }
      }

      if (dropdownscat == AppLocalizations.of(context).sitet) {
        //print("dddde");
        if (dropdownsprixt == AppLocalizations.of(context).zcinq) {
          //  print("object");
          listTourisme = listTourisme
              .where((element) =>
                  element.type == "Site touristique" &&
                  int.parse(element.prix) <= 50000)
              .toList();
        } else {
          if (dropdownsprixt == AppLocalizations.of(context).cindeux) {
            listTourisme = listTourisme
                .where((element) =>
                    element.type == "Site touristique" &&
                    int.parse(element.prix) >= 50001 &&
                    int.parse(element.prix) <= 200000)
                .toList();
          } else {
            if (dropdownsprixt == AppLocalizations.of(context).deuxcin) {
              listTourisme = listTourisme
                  .where((element) =>
                      element.type == "Site touristique" &&
                      int.parse(element.prix) >= 200001 &&
                      int.parse(element.prix) <= 500000)
                  .toList();
            } else {
              if (dropdownsprixt == AppLocalizations.of(context).cindun) {
                listTourisme = listTourisme
                    .where((element) =>
                        element.type == "Site touristique" &&
                        int.parse(element.prix) >= 500001 &&
                        int.parse(element.prix) <= 1000000)
                    .toList();
              } else {
                if (dropdownsprixt == AppLocalizations.of(context).supun) {
                  listTourisme = listTourisme
                      .where((element) =>
                          element.type == "Site touristique" &&
                          int.parse(element.prix) > 1000000)
                      .toList();
                } else {
                  listTourisme = listTourisme
                      .where((element) => element.type == "Site touristique")
                      .toList();
                }
              }
            }
          }
        }
      }

      if (dropdownscat == AppLocalizations.of(context).rest) {
        //print("dddde");
        if (dropdownsprixt == AppLocalizations.of(context).zcinq) {
          //  print("object");
          listTourisme = listTourisme
              .where((element) =>
                  element.type == "Restaurant" &&
                  int.parse(element.prix) <= 50000)
              .toList();
        } else {
          if (dropdownsprixt == AppLocalizations.of(context).cindeux) {
            listTourisme = listTourisme
                .where((element) =>
                    element.type == "Restaurant" &&
                    int.parse(element.prix) >= 50001 &&
                    int.parse(element.prix) <= 200000)
                .toList();
          } else {
            if (dropdownsprixt == AppLocalizations.of(context).deuxcin) {
              listTourisme = listTourisme
                  .where((element) =>
                      element.type == "Restaurant" &&
                      int.parse(element.prix) >= 200001 &&
                      int.parse(element.prix) <= 500000)
                  .toList();
            } else {
              if (dropdownsprixt == AppLocalizations.of(context).cindun) {
                listTourisme = listTourisme
                    .where((element) =>
                        element.type == "Restaurant" &&
                        int.parse(element.prix) >= 500001 &&
                        int.parse(element.prix) <= 1000000)
                    .toList();
              } else {
                if (dropdownsprixt == AppLocalizations.of(context).supun) {
                  listTourisme = listTourisme
                      .where((element) =>
                          element.type == "Restaurant" &&
                          int.parse(element.prix) > 1000000)
                      .toList();
                } else {
                  listTourisme = listTourisme
                      .where((element) => element.type == "Restaurant")
                      .toList();
                }
              }
            }
          }
        }
      }

      if (dropdownscat == AppLocalizations.of(context).lois) {
        //print("dddde");
        if (dropdownsprixt == AppLocalizations.of(context).zcinq) {
          //  print("object");
          listTourisme = listTourisme
              .where((element) =>
                  element.type == "loisir" && int.parse(element.prix) <= 50000)
              .toList();
        } else {
          if (dropdownsprixt == AppLocalizations.of(context).cindeux) {
            listTourisme = listTourisme
                .where((element) =>
                    element.type == "loisir" &&
                    int.parse(element.prix) >= 50001 &&
                    int.parse(element.prix) <= 200000)
                .toList();
          } else {
            if (dropdownsprixt == AppLocalizations.of(context).deuxcin) {
              listTourisme = listTourisme
                  .where((element) =>
                      element.type == "loisir" &&
                      int.parse(element.prix) >= 200001 &&
                      int.parse(element.prix) <= 500000)
                  .toList();
            } else {
              if (dropdownsprixt == AppLocalizations.of(context).cindun) {
                listTourisme = listTourisme
                    .where((element) =>
                        element.type == "loisir" &&
                        int.parse(element.prix) >= 500001 &&
                        int.parse(element.prix) <= 1000000)
                    .toList();
              } else {
                if (dropdownsprixt == AppLocalizations.of(context).supun) {
                  listTourisme = listTourisme
                      .where((element) =>
                          element.type == "loisir" &&
                          int.parse(element.prix) > 1000000)
                      .toList();
                } else {
                  listTourisme = listTourisme
                      .where((element) => element.type == "loisir")
                      .toList();
                }
              }
            }
          }
        }
      }
/*
   if (dropdownsprixt == AppLocalizations.of(context).zcinq){

    }else{
      if (dropdownsprixt == AppLocalizations.of(context).cindeux){

      }else{
         if (dropdownsprixt == AppLocalizations.of(context).deuxcin){

          }else{
              if (dropdownsprixt == AppLocalizations.of(context).cindun){

              }else{
                  if (dropdownsprixt == AppLocalizations.of(context).supun){

                  }else{
                    
                  }
              }
          }
      }
    }
*/

      if (dropdownscat == AppLocalizations.of(context).dupp) {
        //print("dddde");
        if (dropdownsprixt == AppLocalizations.of(context).zcinq) {
          //  print("object");
          listMaison = listMaison
              .where((element) =>
                  element.typemaison == "D" && int.parse(element.prix) <= 50000)
              .toList();
        } else {
          if (dropdownsprixt == AppLocalizations.of(context).cindeux) {
            listMaison = listMaison
                .where((element) =>
                    element.typemaison == "D" &&
                    int.parse(element.prix) >= 50001 &&
                    int.parse(element.prix) <= 200000)
                .toList();
          } else {
            if (dropdownsprixt == AppLocalizations.of(context).deuxcin) {
              listMaison = listMaison
                  .where((element) =>
                      element.typemaison == "D" &&
                      int.parse(element.prix) >= 200001 &&
                      int.parse(element.prix) <= 500000)
                  .toList();
            } else {
              if (dropdownsprixt == AppLocalizations.of(context).cindun) {
                listMaison = listMaison
                    .where((element) =>
                        element.typemaison == "D" &&
                        int.parse(element.prix) >= 500001 &&
                        int.parse(element.prix) <= 1000000)
                    .toList();
              } else {
                if (dropdownsprixt == AppLocalizations.of(context).supun) {
                  listMaison = listMaison
                      .where((element) =>
                          element.typemaison == "D" &&
                          int.parse(element.prix) > 1000000)
                      .toList();
                } else {
                  listMaison = listMaison
                      .where((element) => element.typemaison == "D")
                      .toList();
                }
              }
            }
          }
        }
      }

      if (dropdownscat == AppLocalizations.of(context).mais) {
        //print("dddde");
        if (dropdownsprixt == AppLocalizations.of(context).zcinq) {
          //  print("object");
          listMaison = listMaison
              .where((element) =>
                  element.typemaison == "M" && int.parse(element.prix) <= 50000)
              .toList();
        } else {
          if (dropdownsprixt == AppLocalizations.of(context).cindeux) {
            listMaison = listMaison
                .where((element) =>
                    element.typemaison == "M" &&
                    int.parse(element.prix) >= 50001 &&
                    int.parse(element.prix) <= 200000)
                .toList();
          } else {
            if (dropdownsprixt == AppLocalizations.of(context).deuxcin) {
              listMaison = listMaison
                  .where((element) =>
                      element.typemaison == "M" &&
                      int.parse(element.prix) >= 200001 &&
                      int.parse(element.prix) <= 500000)
                  .toList();
            } else {
              if (dropdownsprixt == AppLocalizations.of(context).cindun) {
                listMaison = listMaison
                    .where((element) =>
                        element.typemaison == "M" &&
                        int.parse(element.prix) >= 500001 &&
                        int.parse(element.prix) <= 1000000)
                    .toList();
              } else {
                if (dropdownsprixt == AppLocalizations.of(context).supun) {
                  listMaison = listMaison
                      .where((element) =>
                          element.typemaison == "M" &&
                          int.parse(element.prix) > 1000000)
                      .toList();
                } else {
                  listMaison = listMaison
                      .where((element) => element.typemaison == "M")
                      .toList();
                }
              }
            }
          }
        }
      }

      if (dropdownscat == AppLocalizations.of(context).vill) {
        //print("dddde");
        if (dropdownsprixt == AppLocalizations.of(context).zcinq) {
          //  print("object");
          listMaison = listMaison
              .where((element) =>
                  element.typemaison == "V" && int.parse(element.prix) <= 50000)
              .toList();
        } else {
          if (dropdownsprixt == AppLocalizations.of(context).cindeux) {
            listMaison = listMaison
                .where((element) =>
                    element.typemaison == "V" &&
                    int.parse(element.prix) >= 50001 &&
                    int.parse(element.prix) <= 200000)
                .toList();
          } else {
            if (dropdownsprixt == AppLocalizations.of(context).deuxcin) {
              listMaison = listMaison
                  .where((element) =>
                      element.typemaison == "V" &&
                      int.parse(element.prix) >= 200001 &&
                      int.parse(element.prix) <= 500000)
                  .toList();
            } else {
              if (dropdownsprixt == AppLocalizations.of(context).cindun) {
                listMaison = listMaison
                    .where((element) =>
                        element.typemaison == "V" &&
                        int.parse(element.prix) >= 500001 &&
                        int.parse(element.prix) <= 1000000)
                    .toList();
              } else {
                if (dropdownsprixt == AppLocalizations.of(context).supun) {
                  listMaison = listMaison
                      .where((element) =>
                          element.typemaison == "V" &&
                          int.parse(element.prix) > 1000000)
                      .toList();
                } else {
                  listMaison = listMaison
                      .where((element) => element.typemaison == "V")
                      .toList();
                }
              }
            }
          }
        }
      }

      if (dropdownscat == AppLocalizations.of(context).chat) {
        //print("dddde");
        if (dropdownsprixt == AppLocalizations.of(context).zcinq) {
          //  print("object");
          listMaison = listMaison
              .where((element) =>
                  element.typemaison == "Ch" &&
                  int.parse(element.prix) <= 50000)
              .toList();
        } else {
          if (dropdownsprixt == AppLocalizations.of(context).cindeux) {
            listMaison = listMaison
                .where((element) =>
                    element.typemaison == "Ch" &&
                    int.parse(element.prix) >= 50001 &&
                    int.parse(element.prix) <= 200000)
                .toList();
          } else {
            if (dropdownsprixt == AppLocalizations.of(context).deuxcin) {
              listMaison = listMaison
                  .where((element) =>
                      element.typemaison == "Ch" &&
                      int.parse(element.prix) >= 200001 &&
                      int.parse(element.prix) <= 500000)
                  .toList();
            } else {
              if (dropdownsprixt == AppLocalizations.of(context).cindun) {
                listMaison = listMaison
                    .where((element) =>
                        element.typemaison == "Ch" &&
                        int.parse(element.prix) >= 500001 &&
                        int.parse(element.prix) <= 1000000)
                    .toList();
              } else {
                if (dropdownsprixt == AppLocalizations.of(context).supun) {
                  listMaison = listMaison
                      .where((element) =>
                          element.typemaison == "Ch" &&
                          int.parse(element.prix) > 1000000)
                      .toList();
                } else {
                  listMaison = listMaison
                      .where((element) => element.typemaison == "Ch")
                      .toList();
                }
              }
            }
          }
        }
      }
/*
   if (dropdownsprixt == AppLocalizations.of(context).zcinq){

    }else{
      if (dropdownsprixt == AppLocalizations.of(context).cindeux){

      }else{
         if (dropdownsprixt == AppLocalizations.of(context).deuxcin){

          }else{
              if (dropdownsprixt == AppLocalizations.of(context).cindun){

              }else{
                  if (dropdownsprixt == AppLocalizations.of(context).supun){

                  }else{
                    
                  }
              }
          }
      }
    }
*/

      if (dropdownscat == AppLocalizations.of(context).champ) {
        //print("dddde");
        if (dropdownsprixt == AppLocalizations.of(context).zcinq) {
          //  print("object");
          listEtudiant = listEtudiant
              .where((element) =>
                  element.type == "Cp" && int.parse(element.prix) <= 50000)
              .toList();
        } else {
          if (dropdownsprixt == AppLocalizations.of(context).cindeux) {
            listEtudiant = listEtudiant
                .where((element) =>
                    element.type == "Cp" &&
                    int.parse(element.prix) >= 50001 &&
                    int.parse(element.prix) <= 200000)
                .toList();
          } else {
            if (dropdownsprixt == AppLocalizations.of(context).deuxcin) {
              listEtudiant = listEtudiant
                  .where((element) =>
                      element.type == "Cp" &&
                      int.parse(element.prix) >= 200001 &&
                      int.parse(element.prix) <= 500000)
                  .toList();
            } else {
              if (dropdownsprixt == AppLocalizations.of(context).cindun) {
                listEtudiant = listEtudiant
                    .where((element) =>
                        element.type == "Cp" &&
                        int.parse(element.prix) >= 500001 &&
                        int.parse(element.prix) <= 1000000)
                    .toList();
              } else {
                if (dropdownsprixt == AppLocalizations.of(context).supun) {
                  listEtudiant = listEtudiant
                      .where((element) =>
                          element.type == "Cp" &&
                          int.parse(element.prix) > 1000000)
                      .toList();
                } else {
                  listEtudiant = listEtudiant
                      .where((element) => element.type == "Cp")
                      .toList();
                }
              }
            }
          }
        }
      }

      if (dropdownscat == AppLocalizations.of(context).champp) {
        //print("dddde");
        if (dropdownsprixt == AppLocalizations.of(context).zcinq) {
          //  print("object");
          listEtudiant = listEtudiant
              .where((element) =>
                  element.type == "Cpa" && int.parse(element.prix) <= 50000)
              .toList();
        } else {
          if (dropdownsprixt == AppLocalizations.of(context).cindeux) {
            listEtudiant = listEtudiant
                .where((element) =>
                    element.type == "Cpa" &&
                    int.parse(element.prix) >= 50001 &&
                    int.parse(element.prix) <= 200000)
                .toList();
          } else {
            if (dropdownsprixt == AppLocalizations.of(context).deuxcin) {
              listEtudiant = listEtudiant
                  .where((element) =>
                      element.type == "Cpa" &&
                      int.parse(element.prix) >= 200001 &&
                      int.parse(element.prix) <= 500000)
                  .toList();
            } else {
              if (dropdownsprixt == AppLocalizations.of(context).cindun) {
                listEtudiant = listEtudiant
                    .where((element) =>
                        element.type == "Cpa" &&
                        int.parse(element.prix) >= 500001 &&
                        int.parse(element.prix) <= 1000000)
                    .toList();
              } else {
                if (dropdownsprixt == AppLocalizations.of(context).supun) {
                  listEtudiant = listEtudiant
                      .where((element) =>
                          element.type == "Cpa" &&
                          int.parse(element.prix) > 1000000)
                      .toList();
                } else {
                  listEtudiant = listEtudiant
                      .where((element) => element.type == "Cpa")
                      .toList();
                }
              }
            }
          }
        }
      }

/*
   if (dropdownsprixt == AppLocalizations.of(context).zcinq){

    }else{
      if (dropdownsprixt == AppLocalizations.of(context).cindeux){

      }else{
         if (dropdownsprixt == AppLocalizations.of(context).deuxcin){

          }else{
              if (dropdownsprixt == AppLocalizations.of(context).cindun){

              }else{
                  if (dropdownsprixt == AppLocalizations.of(context).supun){

                  }else{
                    
                  }
              }
          }
      }
    }
*/
      if (dropdownscat == '1 ' + AppLocalizations.of(context).ett) {
        //print("dddde");
        if (dropdownsprixt == AppLocalizations.of(context).zcinq) {
          //  print("object");
          listHotels = listHotels
              .where((element) =>
                  element.nombreetoile > 1 &&
                  element.nombreetoile < 2 &&
                  int.parse(element.prix) <= 50000)
              .toList();
        } else {
          if (dropdownsprixt == AppLocalizations.of(context).cindeux) {
            listHotels = listHotels
                .where((element) =>
                    element.nombreetoile > 1 &&
                    element.nombreetoile < 2 &&
                    int.parse(element.prix) >= 50001 &&
                    int.parse(element.prix) <= 200000)
                .toList();
          } else {
            if (dropdownsprixt == AppLocalizations.of(context).deuxcin) {
              listHotels = listHotels
                  .where((element) =>
                      element.nombreetoile > 1 &&
                      element.nombreetoile < 2 &&
                      int.parse(element.prix) >= 200001 &&
                      int.parse(element.prix) <= 500000)
                  .toList();
            } else {
              if (dropdownsprixt == AppLocalizations.of(context).cindun) {
                listHotels = listHotels
                    .where((element) =>
                        element.nombreetoile > 1 &&
                        element.nombreetoile < 2 &&
                        int.parse(element.prix) >= 500001 &&
                        int.parse(element.prix) <= 1000000)
                    .toList();
              } else {
                if (dropdownsprixt == AppLocalizations.of(context).supun) {
                  listHotels = listHotels
                      .where((element) =>
                          element.nombreetoile > 1 &&
                          element.nombreetoile < 2 &&
                          int.parse(element.prix) > 1000000)
                      .toList();
                } else {
                  listHotels = listHotels
                      .where((element) =>
                          element.nombreetoile > 1 && element.nombreetoile < 2)
                      .toList();
                }
              }
            }
          }
        }
      }
      if (dropdownscat == '2 ' + AppLocalizations.of(context).etts) {
        if (dropdownsprixt == AppLocalizations.of(context).zcinq) {
          listHotels = listHotels
              .where((element) =>
                  element.nombreetoile > 2 &&
                  element.nombreetoile < 3 &&
                  int.parse(element.prix) <= 50000)
              .toList();
        } else {
          if (dropdownsprixt == AppLocalizations.of(context).cindeux) {
            listHotels = listHotels
                .where((element) =>
                    element.nombreetoile > 2 &&
                    element.nombreetoile < 3 &&
                    int.parse(element.prix) >= 50001 &&
                    int.parse(element.prix) <= 200000)
                .toList();
          } else {
            if (dropdownsprixt == AppLocalizations.of(context).deuxcin) {
              listHotels = listHotels
                  .where((element) =>
                      element.nombreetoile > 2 &&
                      element.nombreetoile < 3 &&
                      int.parse(element.prix) >= 200001 &&
                      int.parse(element.prix) <= 500000)
                  .toList();
            } else {
              if (dropdownsprixt == AppLocalizations.of(context).cindun) {
                listHotels = listHotels
                    .where((element) =>
                        element.nombreetoile > 2 &&
                        element.nombreetoile < 3 &&
                        int.parse(element.prix) >= 500001 &&
                        int.parse(element.prix) <= 1000000)
                    .toList();
              } else {
                if (dropdownsprixt == AppLocalizations.of(context).supun) {
                  listHotels = listHotels
                      .where((element) =>
                          element.nombreetoile > 2 &&
                          element.nombreetoile < 3 &&
                          int.parse(element.prix) > 1000000)
                      .toList();
                } else {
                  listHotels = listHotels
                      .where((element) =>
                          element.nombreetoile > 2 && element.nombreetoile < 3)
                      .toList();
                }
              }
            }
          }
        }
      }
      if (dropdownscat == '3 ' + AppLocalizations.of(context).etts) {
        if (dropdownsprixt == AppLocalizations.of(context).zcinq) {
          listHotels = listHotels
              .where((element) =>
                  element.nombreetoile > 3 &&
                  element.nombreetoile < 4 &&
                  int.parse(element.prix) <= 50000)
              .toList();
        } else {
          if (dropdownsprixt == AppLocalizations.of(context).cindeux) {
            listHotels = listHotels
                .where((element) =>
                    element.nombreetoile > 3 &&
                    element.nombreetoile < 4 &&
                    int.parse(element.prix) >= 50001 &&
                    int.parse(element.prix) <= 200000)
                .toList();
          } else {
            if (dropdownsprixt == AppLocalizations.of(context).deuxcin) {
              listHotels = listHotels
                  .where((element) =>
                      element.nombreetoile > 3 &&
                      element.nombreetoile < 4 &&
                      int.parse(element.prix) >= 200001 &&
                      int.parse(element.prix) <= 500000)
                  .toList();
            } else {
              if (dropdownsprixt == AppLocalizations.of(context).cindun) {
                listHotels = listHotels
                    .where((element) =>
                        element.nombreetoile > 3 &&
                        element.nombreetoile < 4 &&
                        int.parse(element.prix) >= 500001 &&
                        int.parse(element.prix) <= 1000000)
                    .toList();
              } else {
                if (dropdownsprixt == AppLocalizations.of(context).supun) {
                  listHotels = listHotels
                      .where((element) =>
                          element.nombreetoile > 3 &&
                          element.nombreetoile < 4 &&
                          int.parse(element.prix) > 1000000)
                      .toList();
                } else {
                  listHotels = listHotels
                      .where((element) =>
                          element.nombreetoile > 3 && element.nombreetoile < 4)
                      .toList();
                }
              }
            }
          }
        }
      }
      if (dropdownscat == '4 ' + AppLocalizations.of(context).etts) {
        if (dropdownsprixt == AppLocalizations.of(context).zcinq) {
          listHotels = listHotels
              .where((element) =>
                  element.nombreetoile > 4 &&
                  element.nombreetoile < 5 &&
                  int.parse(element.prix) <= 50000)
              .toList();
        } else {
          if (dropdownsprixt == AppLocalizations.of(context).cindeux) {
            listHotels = listHotels
                .where((element) =>
                    element.nombreetoile > 4 &&
                    element.nombreetoile < 5 &&
                    int.parse(element.prix) >= 50001 &&
                    int.parse(element.prix) <= 200000)
                .toList();
          } else {
            if (dropdownsprixt == AppLocalizations.of(context).deuxcin) {
              listHotels = listHotels
                  .where((element) =>
                      element.nombreetoile > 4 &&
                      element.nombreetoile < 5 &&
                      int.parse(element.prix) >= 200001 &&
                      int.parse(element.prix) <= 500000)
                  .toList();
            } else {
              if (dropdownsprixt == AppLocalizations.of(context).cindun) {
                listHotels = listHotels
                    .where((element) =>
                        element.nombreetoile > 4 &&
                        element.nombreetoile < 5 &&
                        int.parse(element.prix) >= 500001 &&
                        int.parse(element.prix) <= 1000000)
                    .toList();
              } else {
                if (dropdownsprixt == AppLocalizations.of(context).supun) {
                  listHotels = listHotels
                      .where((element) =>
                          element.nombreetoile > 4 &&
                          element.nombreetoile < 5 &&
                          int.parse(element.prix) > 1000000)
                      .toList();
                } else {
                  listHotels = listHotels
                      .where((element) =>
                          element.nombreetoile > 4 && element.nombreetoile < 5)
                      .toList();
                }
              }
            }
          }
        }
      }
      if (dropdownscat == '5 ' + AppLocalizations.of(context).etts) {
        if (dropdownsprixt == AppLocalizations.of(context).zcinq) {
          listHotels = listHotels
              .where((element) =>
                  element.nombreetoile > 5 && int.parse(element.prix) <= 50000)
              .toList();
        } else {
          if (dropdownsprixt == AppLocalizations.of(context).cindeux) {
            listHotels = listHotels
                .where((element) =>
                    element.nombreetoile > 5 &&
                    int.parse(element.prix) >= 50001 &&
                    int.parse(element.prix) <= 200000)
                .toList();
          } else {
            if (dropdownsprixt == AppLocalizations.of(context).deuxcin) {
              listHotels = listHotels
                  .where((element) =>
                      element.nombreetoile > 5 &&
                      int.parse(element.prix) >= 200001 &&
                      int.parse(element.prix) <= 500000)
                  .toList();
            } else {
              if (dropdownsprixt == AppLocalizations.of(context).cindun) {
                listHotels = listHotels
                    .where((element) =>
                        element.nombreetoile > 5 &&
                        int.parse(element.prix) >= 500001 &&
                        int.parse(element.prix) <= 1000000)
                    .toList();
              } else {
                if (dropdownsprixt == AppLocalizations.of(context).supun) {
                  listHotels = listHotels
                      .where((element) =>
                          element.nombreetoile > 5 &&
                          int.parse(element.prix) > 1000000)
                      .toList();
                } else {
                  listHotels = listHotels
                      .where((element) => element.nombreetoile > 5)
                      .toList();
                }
              }
            }
          }
        }
      }

      if ((dropdownscat == AppLocalizations.of(context).scat &&
              dropdownValue == AppLocalizations.of(context).hotels) ||
          ((dropdownscat == AppLocalizations.of(context).scat &&
              dropdownValue == AppLocalizations.of(context).sscat))) {
        //print("dddde");
        if (dropdownsprixt == AppLocalizations.of(context).zcinq) {
          //  print("object");
          listHotels = listHotels
              .where((element) => int.parse(element.prix) <= 50000)
              .toList();
        } else {
          if (dropdownsprixt == AppLocalizations.of(context).cindeux) {
            listHotels = listHotels
                .where((element) =>
                    int.parse(element.prix) >= 50001 &&
                    int.parse(element.prix) <= 200000)
                .toList();
          } else {
            if (dropdownsprixt == AppLocalizations.of(context).deuxcin) {
              listHotels = listHotels
                  .where((element) =>
                      int.parse(element.prix) >= 200001 &&
                      int.parse(element.prix) <= 500000)
                  .toList();
            } else {
              if (dropdownsprixt == AppLocalizations.of(context).cindun) {
                listHotels = listHotels
                    .where((element) =>
                        int.parse(element.prix) >= 500001 &&
                        int.parse(element.prix) <= 1000000)
                    .toList();
              } else {
                if (dropdownsprixt == AppLocalizations.of(context).supun) {
                  listHotels = listHotels
                      .where((element) => int.parse(element.prix) > 1000000)
                      .toList();
                } else {
                  listHotels = listHotels;
                }
              }
            }
          }
        }
      }

      if ((dropdownscat == AppLocalizations.of(context).scat &&
              dropdownValue == AppLocalizations.of(context).hebergement) ||
          ((dropdownscat == AppLocalizations.of(context).scat &&
              dropdownValue == AppLocalizations.of(context).sscat))) {
        //print("dddde");
        if (dropdownsprixt == AppLocalizations.of(context).zcinq) {
          //  print("object");
          listHebergement = listHebergement
              .where((element) => int.parse(element.prix) <= 50000)
              .toList();
        } else {
          if (dropdownsprixt == AppLocalizations.of(context).cindeux) {
            listHebergement = listHebergement
                .where((element) =>
                    int.parse(element.prix) >= 50001 &&
                    int.parse(element.prix) <= 200000)
                .toList();
          } else {
            if (dropdownsprixt == AppLocalizations.of(context).deuxcin) {
              listHebergement = listHebergement
                  .where((element) =>
                      int.parse(element.prix) >= 200001 &&
                      int.parse(element.prix) <= 500000)
                  .toList();
            } else {
              if (dropdownsprixt == AppLocalizations.of(context).cindun) {
                listHebergement = listHebergement
                    .where((element) =>
                        int.parse(element.prix) >= 500001 &&
                        int.parse(element.prix) <= 1000000)
                    .toList();
              } else {
                if (dropdownsprixt == AppLocalizations.of(context).supun) {
                  listHebergement = listHebergement
                      .where((element) => int.parse(element.prix) > 1000000)
                      .toList();
                } else {
                  listHebergement = listHebergement;
                }
              }
            }
          }
        }
      }

      if ((dropdownscat == AppLocalizations.of(context).scat &&
              dropdownValue == AppLocalizations.of(context).immo) ||
          ((dropdownscat == AppLocalizations.of(context).scat &&
              dropdownValue == AppLocalizations.of(context).sscat))) {
        //print("dddde");
        if (dropdownsprixt == AppLocalizations.of(context).zcinq) {
          //  print("object");
          listImmo = listImmo
              .where((element) => int.parse(element.prix) <= 50000)
              .toList();
        } else {
          if (dropdownsprixt == AppLocalizations.of(context).cindeux) {
            listImmo = listImmo
                .where((element) =>
                    int.parse(element.prix) >= 50001 &&
                    int.parse(element.prix) <= 200000)
                .toList();
          } else {
            if (dropdownsprixt == AppLocalizations.of(context).deuxcin) {
              listImmo = listImmo
                  .where((element) =>
                      int.parse(element.prix) >= 200001 &&
                      int.parse(element.prix) <= 500000)
                  .toList();
            } else {
              if (dropdownsprixt == AppLocalizations.of(context).cindun) {
                listImmo = listImmo
                    .where((element) =>
                        int.parse(element.prix) >= 500001 &&
                        int.parse(element.prix) <= 1000000)
                    .toList();
              } else {
                if (dropdownsprixt == AppLocalizations.of(context).supun) {
                  listImmo = listImmo
                      .where((element) => int.parse(element.prix) > 1000000)
                      .toList();
                } else {
                  listImmo = listImmo;
                }
              }
            }
          }
        }
      }

      if ((dropdownscat == AppLocalizations.of(context).scat &&
              dropdownValue == AppLocalizations.of(context).touris) ||
          ((dropdownscat == AppLocalizations.of(context).scat &&
              dropdownValue == AppLocalizations.of(context).sscat))) {
        //print("dddde");
        if (dropdownsprixt == AppLocalizations.of(context).zcinq) {
          //  print("object");
          listTourisme = listTourisme
              .where((element) => int.parse(element.prix) <= 50000)
              .toList();
        } else {
          if (dropdownsprixt == AppLocalizations.of(context).cindeux) {
            listTourisme = listTourisme
                .where((element) =>
                    int.parse(element.prix) >= 50001 &&
                    int.parse(element.prix) <= 200000)
                .toList();
          } else {
            if (dropdownsprixt == AppLocalizations.of(context).deuxcin) {
              listTourisme = listTourisme
                  .where((element) =>
                      int.parse(element.prix) >= 200001 &&
                      int.parse(element.prix) <= 500000)
                  .toList();
            } else {
              if (dropdownsprixt == AppLocalizations.of(context).cindun) {
                listTourisme = listTourisme
                    .where((element) =>
                        int.parse(element.prix) >= 500001 &&
                        int.parse(element.prix) <= 1000000)
                    .toList();
              } else {
                if (dropdownsprixt == AppLocalizations.of(context).supun) {
                  listTourisme = listTourisme
                      .where((element) => int.parse(element.prix) > 1000000)
                      .toList();
                } else {
                  listTourisme = listTourisme;
                }
              }
            }
          }
        }
      }

      if ((dropdownscat == AppLocalizations.of(context).scat &&
              dropdownValue == AppLocalizations.of(context).terr) ||
          ((dropdownscat == AppLocalizations.of(context).scat &&
              dropdownValue == AppLocalizations.of(context).sscat))) {
        //print("dddde");
        if (dropdownsprixt == AppLocalizations.of(context).zcinq) {
          //  print("object");
          listTerrain = listTerrain
              .where((element) => int.parse(element.prixt) <= 50000)
              .toList();
        } else {
          if (dropdownsprixt == AppLocalizations.of(context).cindeux) {
            listTerrain = listTerrain
                .where((element) =>
                    int.parse(element.prixt) >= 50001 &&
                    int.parse(element.prixt) <= 200000)
                .toList();
          } else {
            if (dropdownsprixt == AppLocalizations.of(context).deuxcin) {
              listTerrain = listTerrain
                  .where((element) =>
                      int.parse(element.prixt) >= 200001 &&
                      int.parse(element.prixt) <= 500000)
                  .toList();
            } else {
              if (dropdownsprixt == AppLocalizations.of(context).cindun) {
                listTerrain = listTerrain
                    .where((element) =>
                        int.parse(element.prixt) >= 500001 &&
                        int.parse(element.prixt) <= 1000000)
                    .toList();
              } else {
                if (dropdownsprixt == AppLocalizations.of(context).supun) {
                  listTerrain = listTerrain
                      .where((element) => int.parse(element.prixt) > 1000000)
                      .toList();
                } else {
                  listTerrain = listTerrain;
                }
              }
            }
          }
        }
      }

      if ((dropdownscat == AppLocalizations.of(context).scat &&
              dropdownValue == AppLocalizations.of(context).mais) ||
          ((dropdownscat == AppLocalizations.of(context).scat &&
              dropdownValue == AppLocalizations.of(context).sscat))) {
        //print("dddde");
        if (dropdownsprixt == AppLocalizations.of(context).zcinq) {
          //  print("object");
          listMaison = listMaison
              .where((element) => int.parse(element.prix) <= 50000)
              .toList();
        } else {
          if (dropdownsprixt == AppLocalizations.of(context).cindeux) {
            listMaison = listMaison
                .where((element) =>
                    int.parse(element.prix) >= 50001 &&
                    int.parse(element.prix) <= 200000)
                .toList();
          } else {
            if (dropdownsprixt == AppLocalizations.of(context).deuxcin) {
              listMaison = listMaison
                  .where((element) =>
                      int.parse(element.prix) >= 200001 &&
                      int.parse(element.prix) <= 500000)
                  .toList();
            } else {
              if (dropdownsprixt == AppLocalizations.of(context).cindun) {
                listMaison = listMaison
                    .where((element) =>
                        int.parse(element.prix) >= 500001 &&
                        int.parse(element.prix) <= 1000000)
                    .toList();
              } else {
                if (dropdownsprixt == AppLocalizations.of(context).supun) {
                  listMaison = listMaison
                      .where((element) => int.parse(element.prix) > 1000000)
                      .toList();
                } else {
                  listMaison = listMaison;
                }
              }
            }
          }
        }
      }

      if ((dropdownscat == AppLocalizations.of(context).scat &&
              dropdownValue == AppLocalizations.of(context).entre) ||
          ((dropdownscat == AppLocalizations.of(context).scat &&
              dropdownValue == AppLocalizations.of(context).sscat))) {
        //print("dddde");
        if (dropdownsprixt == AppLocalizations.of(context).zcinq) {
          //  print("object");
          listEtudiant = listEtudiant
              .where((element) => int.parse(element.prix) <= 50000)
              .toList();
        } else {
          if (dropdownsprixt == AppLocalizations.of(context).cindeux) {
            listEtudiant = listEtudiant
                .where((element) =>
                    int.parse(element.prix) >= 50001 &&
                    int.parse(element.prix) <= 200000)
                .toList();
          } else {
            if (dropdownsprixt == AppLocalizations.of(context).deuxcin) {
              listEtudiant = listEtudiant
                  .where((element) =>
                      int.parse(element.prix) >= 200001 &&
                      int.parse(element.prix) <= 500000)
                  .toList();
            } else {
              if (dropdownsprixt == AppLocalizations.of(context).cindun) {
                listEtudiant = listEtudiant
                    .where((element) =>
                        int.parse(element.prix) >= 500001 &&
                        int.parse(element.prix) <= 1000000)
                    .toList();
              } else {
                if (dropdownsprixt == AppLocalizations.of(context).supun) {
                  listEtudiant = listEtudiant
                      .where((element) => int.parse(element.prix) > 1000000)
                      .toList();
                } else {
                  listEtudiant = listEtudiant;
                }
              }
            }
          }
        }
      }

      allMarkers.clear();

      if (dropdownValue == AppLocalizations.of(context).sscat ||
          dropdownValue == AppLocalizations.of(context).vtous) {
        listHotels.forEach((element) {
          allMarkers.add(Marker(
              icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueAzure,
              ),
              markerId: MarkerId(element.id + element.type + element.nom),
              draggable: false,
              infoWindow:
                  InfoWindow(title: element.nom, snippet: element.localisation),
              position: LatLng(element.lat, element.ln)));
        });

        listHebergement.forEach((element) {
          allMarkers.add(Marker(
              icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueRed,
              ),
              markerId: MarkerId(element.id + element.typefr + element.nom),
              draggable: true,
              infoWindow: InfoWindow(
                  title: element.typefr + " " + element.prix + " Fcfa",
                  snippet: element.localisation),
              position: LatLng(element.lat, element.ln)));
        });

        listImmo.forEach((element) {
          allMarkers.add(Marker(
              icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueGreen,
              ),
              markerId: MarkerId(element.id + element.typefr + element.nom),
              draggable: true,
              infoWindow: InfoWindow(
                  title: element.typefr + " " + element.prix + " Fcfa",
                  snippet: element.localisation),
              position: LatLng(element.lat, element.ln)));
        });

        listEtudiant.forEach((element) {
          allMarkers.add(Marker(
              icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueOrange,
              ),
              markerId: MarkerId(element.ide + element.typefr + element.nom),
              draggable: true,
              infoWindow: InfoWindow(
                  title: element.typefr + " " + element.prix + " Fcfa",
                  snippet: element.localisation),
              position: LatLng(element.lat, element.ln)));
        });

        listMaison.forEach((element) {
          allMarkers.add(Marker(
              icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueCyan,
              ),
              markerId: MarkerId(element.id + element.typefr + element.nom),
              draggable: true,
              infoWindow: InfoWindow(
                  title: element.typefr + " " + element.prix + " Fcfa",
                  snippet: element.localisation),
              position: LatLng(element.lat, element.ln)));
        });

        listTerrain.forEach((element) {
          allMarkers.add(Marker(
              icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueMagenta,
              ),
              markerId: MarkerId(element.superficiet + element.prixt),
              draggable: true,
              infoWindow: InfoWindow(
                  title: AppLocalizations.of(context).terrof +
                      element.superficiet +
                      AppLocalizations.of(context).mcarr +
                      element.prixt +
                      " Fcfa / m2",
                  snippet: element.localisation),
              position: LatLng(element.lat, element.ln)));
        });

        listTourisme.forEach((element) {
          allMarkers.add(Marker(
              icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueYellow,
              ),
              markerId: MarkerId(element.id),
              draggable: true,
              infoWindow: InfoWindow(
                  title: element.prix + " Fcfa", snippet: element.localisation),
              position: LatLng(element.lat, element.ln)));
        });
      }
      if (dropdownValue == AppLocalizations.of(context).hotels) {
        _items.clear();
        _items = [
          AppLocalizations.of(context).scat,
          "1 " + AppLocalizations.of(context).ett,
          "2 " + AppLocalizations.of(context).etts,
          "3 " + AppLocalizations.of(context).etts,
          "4 " + AppLocalizations.of(context).etts,
          "5 " + AppLocalizations.of(context).etts,
        ];

        listHotels.forEach((element) {
          allMarkers.add(Marker(
              icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueAzure,
              ),
              markerId: MarkerId(element.nom),
              draggable: false,
              infoWindow:
                  InfoWindow(title: element.nom, snippet: element.localisation),
              position: LatLng(element.lat, element.ln)));
        });
      }

      if (dropdownValue == AppLocalizations.of(context).touris) {
        _items.clear();
        _items = [
          AppLocalizations.of(context).scat,
          AppLocalizations.of(context).park,
          AppLocalizations.of(context).sitet,
          AppLocalizations.of(context).rest,
          AppLocalizations.of(context).lois,
        ];

        listTourisme.forEach((element) {
          allMarkers.add(Marker(
              icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueYellow,
              ),
              markerId: MarkerId(element.id),
              draggable: true,
              infoWindow: InfoWindow(
                  title: element.typefr + " " + element.nomtr,
                  snippet: element.localisation),
              position: LatLng(element.lat, element.ln)));
        });
      }

      if (dropdownValue == AppLocalizations.of(context).hebergement) {
        _items.clear();
        _items = [
          AppLocalizations.of(context).scat,
          AppLocalizations.of(context).chamm,
          AppLocalizations.of(context).chamnm,
          AppLocalizations.of(context).stum,
          AppLocalizations.of(context).stunm,
          AppLocalizations.of(context).appnm,
          AppLocalizations.of(context).appm,
        ];

        listHebergement.forEach((element) {
          allMarkers.add(Marker(
              icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueRed,
              ),
              markerId: MarkerId(element.id),
              draggable: true,
              infoWindow: InfoWindow(
                  title: element.typefr + " " + element.prix + " Fcfa",
                  snippet: element.localisation),
              position: LatLng(element.lat, element.ln)));
        });
      }

      if (dropdownValue == AppLocalizations.of(context).immo) {
        _items.clear();
        _items = [
          AppLocalizations.of(context).scat,
          AppLocalizations.of(context).salf,
          AppLocalizations.of(context).burr,
          AppLocalizations.of(context).magg,
          AppLocalizations.of(context).terra,
        ];

        listImmo.forEach((element) {
          allMarkers.add(Marker(
              icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueGreen,
              ),
              markerId: MarkerId(element.id + element.typefr + element.nom),
              draggable: true,
              infoWindow: InfoWindow(
                  title: element.typefr + " " + element.prix + " Fcfa",
                  snippet: element.localisation),
              position: LatLng(element.lat, element.ln)));
        });
      }
      if (dropdownValue == AppLocalizations.of(context).touris) {
        _items.clear();
        _items = [
          AppLocalizations.of(context).scat,
          AppLocalizations.of(context).park,
          AppLocalizations.of(context).sitet,
          AppLocalizations.of(context).rest,
          AppLocalizations.of(context).lois,
        ];

        listTourisme.forEach((element) {
          allMarkers.add(Marker(
              icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueYellow,
              ),
              markerId: MarkerId(element.id),
              draggable: true,
              infoWindow: InfoWindow(
                  title: element.typefr + " " + element.nomtr,
                  snippet: element.localisation),
              position: LatLng(element.lat, element.ln)));
        });
      }
      if (dropdownValue == AppLocalizations.of(context).terr) {
        _items.clear();
        _items = [
          AppLocalizations.of(context).scat,
        ];

        listTerrain.forEach((element) {
          allMarkers.add(Marker(
              icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueMagenta,
              ),
              markerId: MarkerId(element.superficiet + element.prixt),
              draggable: true,
              infoWindow: InfoWindow(
                  title: AppLocalizations.of(context).terrof +
                      element.superficiet +
                      AppLocalizations.of(context).mcarr +
                      element.prixt +
                      " Fcfa / m2",
                  snippet: element.localisation),
              position: LatLng(element.lat, element.ln)));
        });
      }
      if (dropdownValue == AppLocalizations.of(context).mais) {
        _items.clear();
        _items = [
          AppLocalizations.of(context).scat,
          AppLocalizations.of(context).mais,
          AppLocalizations.of(context).dupp,
          AppLocalizations.of(context).vill,
          AppLocalizations.of(context).chat,
        ];

        listMaison.forEach((element) {
          allMarkers.add(Marker(
              icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueCyan,
              ),
              markerId: MarkerId(element.id + element.typefr + element.nom),
              draggable: true,
              infoWindow: InfoWindow(
                  title: element.typefr + " " + element.prix + " Fcfa",
                  snippet: element.localisation),
              position: LatLng(element.lat, element.ln)));
        });
      }
      if (dropdownValue == AppLocalizations.of(context).entre) {
        _items.clear();
        _items = [
          AppLocalizations.of(context).scat,
          AppLocalizations.of(context).champ,
          AppLocalizations.of(context).champp,
        ];

        listEtudiant.forEach((element) {
          allMarkers.add(Marker(
              icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueOrange,
              ),
              markerId: MarkerId(element.ide + element.typefr + element.nom),
              draggable: true,
              infoWindow: InfoWindow(
                  title: element.typefr + " " + element.prix + " Fcfa",
                  snippet: element.localisation),
              position: LatLng(element.lat, element.ln)));
        });
      }

      if (dropdownValue == AppLocalizations.of(context).touris) {
        _items.clear();
        _items = [
          AppLocalizations.of(context).scat,
          AppLocalizations.of(context).park,
          AppLocalizations.of(context).sitet,
          AppLocalizations.of(context).rest,
          AppLocalizations.of(context).lois,
        ];

        listTourisme.forEach((element) {
          allMarkers.add(Marker(
              icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueYellow,
              ),
              markerId: MarkerId(element.id),
              draggable: true,
              infoWindow: InfoWindow(
                  title: element.typefr + " " + element.nomtr,
                  snippet: element.localisation),
              position: LatLng(element.lat, element.ln)));
        });
      }
      // log(listHotels.length.toString());
    });
  }

  void setCustomMapPin() async {
    customIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/image/icon/marker.png');
  }

  void _onScroll() {
    if (_pageController.page.toInt() != prevPage) {
      prevPage = _pageController.page.toInt();
      moveCamera();
    }
  }

  void _onScrollheber() {
    if (_pageControllerhebergement.page.toInt() != prevPage) {
      prevPage = _pageControllerhebergement.page.toInt();
      moveCameraheber();
    }
  }

  void _onScrollimmo() {
    if (_pageControllerImmo.page.toInt() != prevPage) {
      prevPage = _pageControllerImmo.page.toInt();
      moveCameraimmo();
    }
  }

  void _onScrollterr() {
    if (_pageControllerTerrain.page.toInt() != prevPage) {
      prevPage = _pageControllerTerrain.page.toInt();
      moveCameraterr();
    }
  }

  void _onScrolletud() {
    if (_pageControllerEtudiant.page.toInt() != prevPage) {
      prevPage = _pageControllerEtudiant.page.toInt();
      moveCameraetud();
    }
  }

  void _onScrollmaiso() {
    if (_pageControllerheMaison.page.toInt() != prevPage) {
      prevPage = _pageControllerheMaison.page.toInt();
      moveCameraMais();
    }
  }

  void _onScrolltouris() {
    if (_pageControllerheTourisme.page.toInt() != prevPage) {
      prevPage = _pageControllerheTourisme.page.toInt();
      moveCameraTouris();
    }
  }

  _coffeeShopList(index) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (BuildContext context, Widget widget) {
        double value = 1;
        if (_pageController.position.haveDimensions) {
          value = _pageController.page - index;
          value = (1 - (value.abs() * 0.3) + 0.06).clamp(0.0, 1.0);
        }
        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 125.0,
            width: Curves.easeInOut.transform(value) * 350.0,
            child: widget,
          ),
        );
      },
      child: Padding(
          padding: const EdgeInsets.only(
              left: 0.0, right: 8.0, top: 5.0, bottom: 5.0),
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(PageRouteBuilder(
                  pageBuilder: (_, __, ___) => new hotelDetail(
                        title: listHotels[index].type,
                        id: listHotels[index].id,
                        image: listHotels[index].imgh,
                        location: listHotels[index].localisation,
                        price: listHotels[index].prix.toString(),
                        nom: listHotels[index].nom,
                        destination: listHotels[index].description,
                        profilh: listHotels[index].imghotel,
                        ln: listHotels[index].ln,
                        lat: listHotels[index].lat,
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
              height: 140.0,
              width: 340.0,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 10.0,
                        spreadRadius: 2.0,
                        color: Colors.white.withOpacity(0.03))
                  ]),
              child: Row(
                children: <Widget>[
                  Material(
                    color: Colors.transparent,
                    child: Container(
                      height: 140.0,
                      width: 110.0,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15.0),
                              bottomLeft: Radius.circular(15.0)),
                          image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                  listHotels[index].imgh),
                              fit: BoxFit.cover)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            width: 150.0,
                            child: Text(
                              listHotels[index].nom,
                              style: TextStyle(
                                  fontFamily: "Sofia",
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 17.0),
                              overflow: TextOverflow.ellipsis,
                            )),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Icon(
                                Icons.location_on,
                                size: 14.0,
                                color: Colors.blue[500],
                              ),
                              Container(
                                width: 140.0,
                                child: Text(
                                  listHotels[index].localisation,
                                  style: TextStyle(
                                      color: Colors.black45,
                                      fontSize: 14.5,
                                      fontFamily: "Sofia",
                                      fontWeight: FontWeight.w400),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 2.0, right: 10.0),
                          child: Container(
                            width: 110.0,
                            child: Text(
                              listHotels[index].type,
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
                              padding:
                                  const EdgeInsets.only(left: 2.0, right: 0.0),
                              child: Text(
                                listHotels[index].prix.toString(),
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
                              left: 2.0, right: 15.0, top: 3.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  ratingbar(
                                    starRating: listHotels[index].nombreetoile,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 12.0),
                                    child: Text(
                                      listHotels[index].nombreetoile.toString(),
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
                  ),
                ],
              ),
            ),
          )),
    );
  }

  _coffeeHebergList(index) {
    return AnimatedBuilder(
      animation: _pageControllerhebergement,
      builder: (BuildContext context, Widget widget) {
        double value = 1;
        if (_pageControllerhebergement.position.haveDimensions) {
          value = _pageControllerhebergement.page - index;
          value = (1 - (value.abs() * 0.3) + 0.06).clamp(0.0, 1.0);
        }
        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 125.0,
            width: Curves.easeInOut.transform(value) * 350.0,
            child: widget,
          ),
        );
      },
      child: Padding(
        padding:
            const EdgeInsets.only(left: 0.0, right: 8.0, top: 5.0, bottom: 5.0),
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(PageRouteBuilder(
                pageBuilder: (_, __, ___) => new hotelDetail2(
                      title: listHebergement[index].typefr,
                      id: listHebergement[index].id,
                      image: listHebergement[index].imgh,
                      location: listHebergement[index].localisation,
                      price: listHebergement[index].prix,
                      description: listHebergement[index].description,
                      periode: listHebergement[index].perifr,
                      ln: listHebergement[index].ln,
                      lat: listHebergement[index].lat,
                      note: listHebergement[index].notefr,
                      acces: listHebergement[index].accesfr,
                      stanting: listHebergement[index].standingfr,
                      securi: listHebergement[index].securitefr,
                      ratting: listHebergement[index].note,
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
            height: 140.0,
            width: 340.0,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 10.0,
                      spreadRadius: 2.0,
                      color: Colors.white.withOpacity(0.03))
                ]),
            child: Row(
              children: <Widget>[
                Material(
                  color: Colors.transparent,
                  child: Container(
                    height: 140.0,
                    width: 110.0,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15.0),
                            bottomLeft: Radius.circular(15.0)),
                        image: DecorationImage(
                            image: CachedNetworkImageProvider(
                                listHebergement[index].imgh),
                            fit: BoxFit.cover)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                          width: 150.0,
                          child: Text(
                            listHebergement[index].typefr,
                            style: TextStyle(
                                fontFamily: "Sofia",
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 17.0),
                            overflow: TextOverflow.ellipsis,
                          )),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Icon(
                              Icons.location_on,
                              size: 14.0,
                              color: Colors.red[500],
                            ),
                            Container(
                              width: 140.0,
                              child: Text(
                                listHebergement[index].localisation,
                                style: TextStyle(
                                    color: Colors.black45,
                                    fontSize: 14.5,
                                    fontFamily: "Sofia",
                                    fontWeight: FontWeight.w400),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 15.0)),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 0.0),
                            child: Text(
                              listHebergement[index].prix + ' Fcfa',
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontFamily: "Gotik",
                                  fontWeight: FontWeight.w800,
                                  fontSize: 14.0),
                            ),
                          ),
                          Text(
                            currentLocale == 'fr'
                                ? " / " + listHebergement[index].perifr
                                : " / " + listHebergement[index].perien,
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
                                  starRating: listHebergement[index].note,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 12.0),
                                  child: Text(
                                    currentLocale == 'fr'
                                        ? listHebergement[index].notefr
                                        : listHebergement[index].noteen,
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _coffeeImmoList(index) {
    return AnimatedBuilder(
      animation: _pageControllerImmo,
      builder: (BuildContext context, Widget widget) {
        double value = 1;
        if (_pageControllerImmo.position.haveDimensions) {
          value = _pageControllerImmo.page - index;
          value = (1 - (value.abs() * 0.3) + 0.06).clamp(0.0, 1.0);
        }
        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 125.0,
            width: Curves.easeInOut.transform(value) * 350.0,
            child: widget,
          ),
        );
      },
      child: Padding(
          padding: const EdgeInsets.only(
              left: 0.0, right: 8.0, top: 5.0, bottom: 5.0),
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(PageRouteBuilder(
                  pageBuilder: (_, __, ___) => new immodetails(
                        title: listImmo[index].typefr,
                        id: listImmo[index].id,
                        image: listImmo[index].imgh,
                        location: listImmo[index].localisation,
                        price: listImmo[index].prix,
                        description: listImmo[index].description,
                        periode: listImmo[index].perifr,
                        ln: listImmo[index].ln,
                        lat: listImmo[index].lat,
                        note: listImmo[index].notefr,
                        acces: listImmo[index].accesfr,
                        stanting: listImmo[index].standingfr,
                        securi: listImmo[index].notefr,
                        ratting: listImmo[index].note,
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
              height: 140.0,
              width: 340.0,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 10.0,
                        spreadRadius: 2.0,
                        color: Colors.white.withOpacity(0.03))
                  ]),
              child: Row(
                children: <Widget>[
                  Material(
                    color: Colors.transparent,
                    child: Container(
                      height: 140.0,
                      width: 110.0,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15.0),
                              bottomLeft: Radius.circular(15.0)),
                          image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                  listImmo[index].imgh),
                              fit: BoxFit.cover)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            width: 150.0,
                            child: Text(
                              listImmo[index].typefr,
                              style: TextStyle(
                                  fontFamily: "Sofia",
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 17.0),
                              overflow: TextOverflow.ellipsis,
                            )),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Icon(
                                Icons.location_on,
                                size: 14.0,
                                color: Colors.green,
                              ),
                              Container(
                                width: 140.0,
                                child: Text(
                                  listImmo[index].localisation,
                                  style: TextStyle(
                                      color: Colors.black45,
                                      fontSize: 14.5,
                                      fontFamily: "Sofia",
                                      fontWeight: FontWeight.w400),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 15.0)),
                        Row(
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10.0, right: 0.0),
                              child: Text(
                                listImmo[index].prix + ' Fcfa',
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontFamily: "Gotik",
                                    fontWeight: FontWeight.w800,
                                    fontSize: 14.0),
                              ),
                            ),
                            Text(
                              currentLocale == 'fr'
                                  ? " / " + listImmo[index].perifr
                                  : " / " + listImmo[index].perien,
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontFamily: "Gotik",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12.0),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  _coffeeTourismList(index) {
    return AnimatedBuilder(
      animation: _pageControllerheTourisme,
      builder: (BuildContext context, Widget widget) {
        double value = 1;
        if (_pageControllerheTourisme.position.haveDimensions) {
          value = _pageControllerheTourisme.page - index;
          value = (1 - (value.abs() * 0.3) + 0.06).clamp(0.0, 1.0);
        }
        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 125.0,
            width: Curves.easeInOut.transform(value) * 350.0,
            child: widget,
          ),
        );
      },
      child: Padding(
          padding: const EdgeInsets.only(
              left: 0.0, right: 8.0, top: 5.0, bottom: 5.0),
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(PageRouteBuilder(
                  pageBuilder: (_, __, ___) => new hotelDetail2(
                        title: listHebergement[index].typefr,
                        id: listHebergement[index].id,
                        image: listHebergement[index].imgh,
                        location: listHebergement[index].localisation,
                        price: listHebergement[index].prix,
                        description: listHebergement[index].description,
                        periode: listHebergement[index].perifr,
                        ln: listHebergement[index].ln,
                        lat: listHebergement[index].lat,
                        note: listHebergement[index].notefr,
                        acces: listHebergement[index].accesfr,
                        stanting: listHebergement[index].standingfr,
                        securi: listHebergement[index].securitefr,
                        ratting: listHebergement[index].note,
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
              height: 140.0,
              width: 340.0,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 10.0,
                        spreadRadius: 2.0,
                        color: Colors.white.withOpacity(0.03))
                  ]),
              child: Row(
                children: <Widget>[
                  Material(
                    color: Colors.transparent,
                    child: Container(
                      height: 140.0,
                      width: 110.0,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15.0),
                              bottomLeft: Radius.circular(15.0)),
                          image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                  listTourisme[index].imgh),
                              fit: BoxFit.cover)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            width: 150.0,
                            child: Text(
                              listTourisme[index].typefr +
                                  " " +
                                  listTourisme[index].nomtr,
                              style: TextStyle(
                                  fontFamily: "Sofia",
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 17.0),
                              overflow: TextOverflow.ellipsis,
                            )),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Icon(
                                Icons.location_on,
                                size: 14.0,
                                color: Colors.yellow,
                              ),
                              Container(
                                width: 140.0,
                                child: Text(
                                  listTourisme[index].localisation,
                                  style: TextStyle(
                                      color: Colors.black45,
                                      fontSize: 14.5,
                                      fontFamily: "Sofia",
                                      fontWeight: FontWeight.w400),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 15.0)),
                        Container(
                            width: 150.0,
                            child: Text(
                              listTourisme[index].description,
                              style: TextStyle(
                                  fontFamily: "Sofia",
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.5),
                              overflow: TextOverflow.ellipsis,
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  _coffeeTerrainList(index) {
    return AnimatedBuilder(
      animation: _pageControllerTerrain,
      builder: (BuildContext context, Widget widget) {
        double value = 1;
        if (_pageControllerTerrain.position.haveDimensions) {
          value = _pageControllerTerrain.page - index;
          value = (1 - (value.abs() * 0.3) + 0.06).clamp(0.0, 1.0);
        }
        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 125.0,
            width: Curves.easeInOut.transform(value) * 350.0,
            child: widget,
          ),
        );
      },
      child: Padding(
          padding: const EdgeInsets.only(
              left: 0.0, right: 8.0, top: 5.0, bottom: 5.0),
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(PageRouteBuilder(
                  pageBuilder: (_, __, ___) => new terrainsdetails(
                        title: 'Terrain de ' +
                            listTerrain[index].superficiet +
                            ' m2',
                        id: listTerrain[index].id,
                        image: listTerrain[index].imgh,
                        location: listTerrain[index].localisation,
                        price: listTerrain[index].prixt,
                        description: listTerrain[index].descriptiont,
                        periode: "m2",
                        ln: listTerrain[index].ln,
                        lat: listTerrain[index].lat,
                        note: listTerrain[index].superficiet,
                        acces: "10",
                        stanting: listTerrain[index].telephone,
                        securi: listTerrain[index].telephone,
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
              height: 140.0,
              width: 340.0,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 10.0,
                        spreadRadius: 2.0,
                        color: Colors.white.withOpacity(0.03))
                  ]),
              child: Row(
                children: <Widget>[
                  Material(
                    color: Colors.transparent,
                    child: Container(
                      height: 140.0,
                      width: 110.0,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15.0),
                              bottomLeft: Radius.circular(15.0)),
                          image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                  listTerrain[index].imgh),
                              fit: BoxFit.cover)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            width: 150.0,
                            child: Text(
                              "Terrain de " +
                                  listTerrain[index].superficiet +
                                  " m2",
                              style: TextStyle(
                                  fontFamily: "Sofia",
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 17.0),
                              overflow: TextOverflow.ellipsis,
                            )),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Icon(
                                Icons.location_on,
                                size: 14.0,
                                color: Colors.purple,
                              ),
                              Container(
                                width: 140.0,
                                child: Text(
                                  listTerrain[index].localisation,
                                  style: TextStyle(
                                      color: Colors.black45,
                                      fontSize: 14.5,
                                      fontFamily: "Sofia",
                                      fontWeight: FontWeight.w400),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 15.0)),
                        Row(
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 2.0, right: 0.0),
                              child: Text(
                                listTerrain[index].prixt + ' Fcfa',
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontFamily: "Gotik",
                                    fontWeight: FontWeight.w800,
                                    fontSize: 14.0),
                              ),
                            ),
                            Text(
                              " / m2",
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontFamily: "Gotik",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12.0),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  _coffeeMaisonList(index) {
    return AnimatedBuilder(
      animation: _pageControllerheMaison,
      builder: (BuildContext context, Widget widget) {
        double value = 1;
        if (_pageControllerheMaison.position.haveDimensions) {
          value = _pageControllerheMaison.page - index;
          value = (1 - (value.abs() * 0.3) + 0.06).clamp(0.0, 1.0);
        }
        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 125.0,
            width: Curves.easeInOut.transform(value) * 350.0,
            child: widget,
          ),
        );
      },
      child: Padding(
          padding: const EdgeInsets.only(
              left: 0.0, right: 8.0, top: 5.0, bottom: 5.0),
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(PageRouteBuilder(
                  pageBuilder: (_, __, ___) => new maisondetails(
                        title: listMaison[index].typefr,
                        id: listMaison[index].id,
                        image: listMaison[index].imgh,
                        location: listMaison[index].localisation,
                        price: listMaison[index].prix,
                        description: listMaison[index].description,
                        periode: listMaison[index].nbrechambre,
                        ln: listMaison[index].ln,
                        lat: listMaison[index].lat,
                        note: listMaison[index].nbresalon,
                        acces: listMaison[index].nbrechambre,
                        stanting: listMaison[index].nbrecuisine,
                        securi: listMaison[index].nombredouche,
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
            child: Container(
              height: 140.0,
              width: 340.0,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 10.0,
                        spreadRadius: 2.0,
                        color: Colors.white.withOpacity(0.03))
                  ]),
              child: Row(
                children: <Widget>[
                  Material(
                    color: Colors.transparent,
                    child: Container(
                      height: 140.0,
                      width: 110.0,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15.0),
                              bottomLeft: Radius.circular(15.0)),
                          image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                  listMaison[index].imgh),
                              fit: BoxFit.cover)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            width: 150.0,
                            child: Text(
                              listMaison[index].typefr,
                              style: TextStyle(
                                  fontFamily: "Sofia",
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 17.0),
                              overflow: TextOverflow.ellipsis,
                            )),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Icon(
                                Icons.location_on,
                                size: 14.0,
                                color: Colors.blue,
                              ),
                              Container(
                                width: 140.0,
                                child: Text(
                                  listMaison[index].localisation,
                                  style: TextStyle(
                                      color: Colors.black45,
                                      fontSize: 14.5,
                                      fontFamily: "Sofia",
                                      fontWeight: FontWeight.w400),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 15.0)),
                        Row(
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 2.0, right: 0.0),
                              child: Text(
                                listMaison[index].prix + ' Fcfa',
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontFamily: "Gotik",
                                    fontWeight: FontWeight.w800,
                                    fontSize: 14.0),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  _coffeeEntreList(index) {
    return AnimatedBuilder(
      animation: _pageControllerEtudiant,
      builder: (BuildContext context, Widget widget) {
        double value = 1;
        if (_pageControllerEtudiant.position.haveDimensions) {
          value = _pageControllerEtudiant.page - index;
          value = (1 - (value.abs() * 0.3) + 0.06).clamp(0.0, 1.0);
        }
        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 125.0,
            width: Curves.easeInOut.transform(value) * 350.0,
            child: widget,
          ),
        );
      },
      child: Padding(
          padding: const EdgeInsets.only(
              left: 0.0, right: 8.0, top: 5.0, bottom: 5.0),
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(PageRouteBuilder(
                  pageBuilder: (_, __, ___) => new hotelDetail2(
                        title: listHebergement[index].typefr,
                        id: listHebergement[index].id,
                        image: listHebergement[index].imgh,
                        location: listHebergement[index].localisation,
                        price: listHebergement[index].prix,
                        description: listHebergement[index].description,
                        periode: listHebergement[index].perifr,
                        ln: listHebergement[index].ln,
                        lat: listHebergement[index].lat,
                        note: listHebergement[index].notefr,
                        acces: listHebergement[index].accesfr,
                        stanting: listHebergement[index].standingfr,
                        securi: listHebergement[index].securitefr,
                        ratting: listHebergement[index].note,
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
              height: 140.0,
              width: 340.0,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 10.0,
                        spreadRadius: 2.0,
                        color: Colors.white.withOpacity(0.03))
                  ]),
              child: Row(
                children: <Widget>[
                  Material(
                    color: Colors.transparent,
                    child: Container(
                      height: 140.0,
                      width: 110.0,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15.0),
                              bottomLeft: Radius.circular(15.0)),
                          image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                  listEtudiant[index].imgh),
                              fit: BoxFit.cover)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            width: 150.0,
                            child: Text(
                              listEtudiant[index].typefr,
                              style: TextStyle(
                                  fontFamily: "Sofia",
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 17.0),
                              overflow: TextOverflow.ellipsis,
                            )),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Icon(
                                Icons.location_on,
                                size: 14.0,
                                color: Colors.brown,
                              ),
                              Container(
                                width: 140.0,
                                child: Text(
                                  listEtudiant[index].localisation,
                                  style: TextStyle(
                                      color: Colors.black45,
                                      fontSize: 14.5,
                                      fontFamily: "Sofia",
                                      fontWeight: FontWeight.w400),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 15.0)),
                        Row(
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 2.0, right: 0.0),
                              child: Text(
                                listEtudiant[index].prix + ' Fcfa',
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontFamily: "Gotik",
                                    fontWeight: FontWeight.w800,
                                    fontSize: 14.0),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  _coffeeAutreList(index) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (BuildContext context, Widget widget) {
        double value = 1;
        if (_pageController.position.haveDimensions) {
          value = _pageController.page - index;
          value = (1 - (value.abs() * 0.3) + 0.06).clamp(0.0, 1.0);
        }
        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 125.0,
            width: Curves.easeInOut.transform(value) * 350.0,
            child: widget,
          ),
        );
      },
      child: Padding(
        padding:
            const EdgeInsets.only(left: 0.0, right: 8.0, top: 5.0, bottom: 5.0),
        child: Container(
          height: 140.0,
          width: 340.0,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
              boxShadow: [
                BoxShadow(
                    blurRadius: 10.0,
                    spreadRadius: 2.0,
                    color: Colors.white.withOpacity(0.03))
              ]),
          child: Row(
            children: <Widget>[
              Material(
                color: Colors.transparent,
                child: Container(
                  height: 140.0,
                  width: 110.0,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15.0),
                          bottomLeft: Radius.circular(15.0)),
                      image: DecorationImage(
                          image: CachedNetworkImageProvider(
                              listHotels[index].imgh),
                          fit: BoxFit.cover)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        width: 150.0,
                        child: Text(
                          listHotels[index].nom,
                          style: TextStyle(
                              fontFamily: "Sofia",
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 17.0),
                          overflow: TextOverflow.ellipsis,
                        )),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Icon(
                            Icons.location_on,
                            size: 14.0,
                            color: Colors.deepPurpleAccent,
                          ),
                          Container(
                            width: 140.0,
                            child: Text(
                              listHotels[index].localisation,
                              style: TextStyle(
                                  color: Colors.black45,
                                  fontSize: 14.5,
                                  fontFamily: "Sofia",
                                  fontWeight: FontWeight.w400),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.star,
                                    color: Colors.deepPurpleAccent,
                                    size: 21.0,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Colors.deepPurpleAccent,
                                    size: 21.0,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Colors.deepPurpleAccent,
                                    size: 21.0,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Colors.deepPurpleAccent,
                                    size: 21.0,
                                  ),
                                  Icon(
                                    Icons.star_half,
                                    color: Colors.deepPurpleAccent,
                                    size: 21.0,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //  var _formKey0;
    ii = ii + 1;
    if (ii == 1) {
      dropdownValue = AppLocalizations.of(context).sscat;
      dropdownscat = AppLocalizations.of(context).scat;
      dropdownsprixt = AppLocalizations.of(context).prix;
      _items = <String>[
        AppLocalizations.of(context).scat,
      ];

      _items0 = <String>[
        AppLocalizations.of(context).sscat,
        AppLocalizations.of(context).hotels,
        AppLocalizations.of(context).hebergement,
        AppLocalizations.of(context).immo,
        AppLocalizations.of(context).touris,
        AppLocalizations.of(context).terr,
        AppLocalizations.of(context).mais,
        AppLocalizations.of(context).entre,
        AppLocalizations.of(context).vtous,
      ];

      _items1 = <String>[
        AppLocalizations.of(context).prix,
        AppLocalizations.of(context).zcinq,
        AppLocalizations.of(context).cindeux,
        AppLocalizations.of(context).deuxcin,
        AppLocalizations.of(context).cindun,
        AppLocalizations.of(context).supun,
      ];
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                    target: LatLng(3.860458, 11.512388), zoom: 13.0),

                // markers: markers,
                onTap: (pos) {
                  /* print(pos);
                  log("dsdsd");*/
                  Marker m = Marker(
                      markerId: MarkerId('1'), icon: customIcon, position: pos);
                  setState(() {
                    allMarkers.add(m);
                  });
                },
                markers: Set.from(allMarkers),
                onMapCreated: (GoogleMapController controller) {
                  _controller = controller;
                  _controller.setMapStyle(_mapStyle);
                },
              ),
            ),
            dropdownValue == AppLocalizations.of(context).hotels
                ? Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 200.0,
                      width: MediaQuery.of(context).size.width,
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: listHotels.length,
                        itemBuilder: (BuildContext context, int index) {
                          return _coffeeShopList(index);
                        },
                      ),
                    ),
                  )
                : Container(),
            dropdownValue == AppLocalizations.of(context).hebergement
                ? Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 200.0,
                      width: MediaQuery.of(context).size.width,
                      child: PageView.builder(
                        controller: _pageControllerhebergement,
                        itemCount: listHebergement.length,
                        itemBuilder: (BuildContext context, int index) {
                          return _coffeeHebergList(index);
                        },
                      ),
                    ),
                  )
                : Container(),
            dropdownValue == AppLocalizations.of(context).immo
                ? Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 200.0,
                      width: MediaQuery.of(context).size.width,
                      child: PageView.builder(
                        controller: _pageControllerImmo,
                        itemCount: listImmo.length,
                        itemBuilder: (BuildContext context, int index) {
                          return _coffeeImmoList(index);
                        },
                      ),
                    ),
                  )
                : Container(),
            dropdownValue == AppLocalizations.of(context).touris
                ? Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 200.0,
                      width: MediaQuery.of(context).size.width,
                      child: PageView.builder(
                        controller: _pageControllerheTourisme,
                        itemCount: listTourisme.length,
                        itemBuilder: (BuildContext context, int index) {
                          return _coffeeTourismList(index);
                        },
                      ),
                    ),
                  )
                : Container(),
            dropdownValue == AppLocalizations.of(context).terr
                ? Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 200.0,
                      width: MediaQuery.of(context).size.width,
                      child: PageView.builder(
                        controller: _pageControllerTerrain,
                        itemCount: listTerrain.length,
                        itemBuilder: (BuildContext context, int index) {
                          return _coffeeTerrainList(index);
                        },
                      ),
                    ),
                  )
                : Container(),
            dropdownValue == AppLocalizations.of(context).mais
                ? Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 200.0,
                      width: MediaQuery.of(context).size.width,
                      child: PageView.builder(
                        controller: _pageControllerheMaison,
                        itemCount: listMaison.length,
                        itemBuilder: (BuildContext context, int index) {
                          return _coffeeMaisonList(index);
                        },
                      ),
                    ),
                  )
                : Container(),
            dropdownValue == AppLocalizations.of(context).entre
                ? Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 200.0,
                      width: MediaQuery.of(context).size.width,
                      child: PageView.builder(
                        controller: _pageControllerEtudiant,
                        itemCount: listEtudiant.length,
                        itemBuilder: (BuildContext context, int index) {
                          return _coffeeEntreList(index);
                        },
                      ),
                    ),
                  )
                : Container(),
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 0.0),
                  child: Container(
                    height: 70.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 20.0, left: 20.0),
                              child: Icon(Icons.arrow_back_ios),
                            )),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20.0, top: 30.0),
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context).recherch,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Sofia",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20.0,
                                  letterSpacing: 1.4),
                            ),
                          ),
                        ),
                        Container(
                          width: 43.0,
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 15.0,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: <Color>[
                        Color(0x00FFFFFF),
                        Color(0xFFFFFFFF),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 50.0,
                  margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 5.0,
                            spreadRadius: 0.0)
                      ]),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Theme(
                        data: ThemeData(hintColor: Colors.transparent),
                        child: DropdownButton(
                          isExpanded: true,
                          hint: Text(AppLocalizations.of(context).sscat),
                          value: dropdownValue,
                          underline: SizedBox(),
                          icon: Icon(
                            Icons.search,
                            color: Color(0xFF6991C7),
                            size: 28.0,
                          ),
                          items: _items0.map<DropdownMenuItem<String>>(
                            (final String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            },
                          ).toList(),
                          onChanged: (String newValue) {
                            setState(() {
                              print(newValue);
                              dropdownValue = newValue;
                              _items.clear();
                              _items = [
                                AppLocalizations.of(context).scat,
                              ];
                              dropdownscat = AppLocalizations.of(context).scat;
                              listMarkersli(context);
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                    height: 50.0,
                    margin: const EdgeInsets.fromLTRB(10, 1, 10, 0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 5.0,
                              spreadRadius: 0.0)
                        ]),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: Padding(
                          padding:
                              const EdgeInsets.only(left: 20.0, right: 20.0),
                          child: DropdownButton(
                              isExpanded: true,
                              value: dropdownscat,
                              underline: SizedBox(),
                              icon: Icon(
                                Icons.device_hub,
                                color: Color(0xFF6991C7),
                                size: 28.0,
                              ),
                              items: _items.map<DropdownMenuItem<String>>(
                                (final String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                },
                              ).toList(),
                              onChanged: (String newValue) {
                                dropdownscat = newValue;
                                print(dropdownscat);
                                listMarkersli(context);
                              }),
                        )),
                        Expanded(
                            child: Padding(
                          padding:
                              const EdgeInsets.only(left: 20.0, right: 20.0),
                          child: DropdownButton(
                              isExpanded: true,
                              value: dropdownsprixt,
                              underline: SizedBox(),
                              icon: Icon(
                                Icons.attach_money,
                                color: Color(0xFF6991C7),
                                size: 28.0,
                              ),
                              items: _items1.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String newValue) {
                                dropdownsprixt = newValue;
                                //print(dropdownsprixt);
                                listMarkersli(context);
                              }),
                        )),
                      ],
                    )),
              ],
            ),
          ],
        ));
  }

  moveCamera() {
    _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(listHotels[_pageController.page.toInt()].lat,
            listHotels[_pageController.page.toInt()].ln),
        zoom: 14.0,
        bearing: 45.0,
        tilt: 45.0)));
  }

  moveCameraheber() {
    _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(
            listHebergement[_pageControllerhebergement.page.toInt()].lat,
            listHebergement[_pageControllerhebergement.page.toInt()].ln),
        zoom: 14.0,
        bearing: 45.0,
        tilt: 45.0)));
  }

  moveCameraimmo() {
    _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(listImmo[_pageControllerImmo.page.toInt()].lat,
            listImmo[_pageControllerImmo.page.toInt()].ln),
        zoom: 14.0,
        bearing: 45.0,
        tilt: 45.0)));
  }

  moveCameraterr() {
    _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(listTerrain[_pageControllerTerrain.page.toInt()].lat,
            listTerrain[_pageControllerTerrain.page.toInt()].ln),
        zoom: 14.0,
        bearing: 45.0,
        tilt: 45.0)));
  }

  moveCameraetud() {
    _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(listEtudiant[_pageControllerEtudiant.page.toInt()].lat,
            listEtudiant[_pageControllerEtudiant.page.toInt()].ln),
        zoom: 14.0,
        bearing: 45.0,
        tilt: 45.0)));
  }

  moveCameraMais() {
    _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(listMaison[_pageControllerheMaison.page.toInt()].lat,
            listMaison[_pageControllerheMaison.page.toInt()].ln),
        zoom: 14.0,
        bearing: 45.0,
        tilt: 45.0)));
  }

  moveCameraTouris() {
    _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(listTourisme[_pageControllerheTourisme.page.toInt()].lat,
            listTourisme[_pageControllerheTourisme.page.toInt()].ln),
        zoom: 14.0,
        bearing: 45.0,
        tilt: 45.0)));
  }
}

class ListItem {
  int value;
  String name;

  ListItem(this.value, this.name);
}
