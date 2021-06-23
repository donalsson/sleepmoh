import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.Dart' as http;

import 'global.dart' as globals;
import 'package:sleepmohapp/DataSample/HebergementsModel.dart';
import 'package:sleepmohapp/DataSample/HotelModel.dart';
import 'package:sleepmohapp/DataSample/ImagesModel.dart';
import 'package:sleepmohapp/DataSample/ImmobModel.dart';
import 'package:sleepmohapp/DataSample/EntreMod.dart';
import 'package:sleepmohapp/DataSample/UserMod.dart';
import 'package:sleepmohapp/DataSample/ConversMod.dart';
import 'package:sleepmohapp/DataSample/MaisonModel.dart';
import 'package:sleepmohapp/DataSample/TerrainModel.dart';
import 'package:sleepmohapp/DataSample/TourismeModel.dart';
import 'package:sleepmohapp/DataSample/MessageTchaMod.dart';
import 'package:sleepmohapp/core/preference.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart';

class HttpPostRequest {
  static Future<List<Hotelht>> getAllHotels() async {
    http.Response response = await http.post(
        'https://sleepmoh.com/http_flutter.php',
        body: <String, String>{"action": 'rechecheHo'});
    //   log("httpreq");
    if (response.statusCode == 200) {
      // print(response.body);
      Iterable list = json.decode(response.body);
      SharedPreferencesClass.save("listHotel1", response.body);
      return list.map((model) => Hotelht.fromJson(model)).toList();
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<void> sendNotificationMessageToPeerUser(unReadMSGCount, messageType,
      textFromTextField, myName, chatID, peerUserToken) async {
    FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
    await http.post(
      'https://fcm.googleapis.com/fcm/send',
      headers: <String, String>{
        'Content-Type': 'application/json',
        // 'Authorization': 'key=$firebaseCloudserverToken',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': messageType == 'text' ? '$textFromTextField' : '(Photo)',
            'title': '$myName',
            'badge': '$unReadMSGCount', //'$unReadMSGCount'
            "sound": "default"
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done',
            'chatroomid': chatID,
          },
          'to': peerUserToken,
        },
      ),
    );

    final Completer<Map<String, dynamic>> completer =
        Completer<Map<String, dynamic>>();

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        completer.complete(message);
      },
    );
  }

  static Future<List<Imagem>> getAllImages() async {
    http.Response response = await http.post(
        'https://sleepmoh.com/http_flutter.php',
        body: <String, String>{"action": 'getAllImages'});
    //   log("httpreq");
    if (response.statusCode == 200) {
      // print(response.body);
      Iterable list = json.decode(response.body);
      SharedPreferencesClass.save("listImages", response.body);
      return list.map((model) => Imagem.fromJson(model)).toList();
    } else {
      throw Exception('Failed to load album');
    }
  }

  static Future<List<Hotelht>> getlimitHotels() async {
    http.Response response = await http.post(
        'https://sleepmoh.com/http_flutter.php',
        body: <String, String>{"action": 'rechecheHolimit'});
    //  log("httpreq");
    if (response.statusCode == 200) {
      //  print(response.body);
      Iterable list = json.decode(response.body);
      SharedPreferencesClass.save("listHotel1", response.body);
      return list.map((model) => Hotelht.fromJson(model)).toList();
    } else {
      throw Exception('Failed to load album');
    }
  }

  static Future<List<HerbergemntMod>> getAllHebergements() async {
    http.Response response = await http.post(
        'https://sleepmoh.com/http_flutter.php',
        body: <String, String>{"action": 'rechecheHeberAll'});
    //  log("httpreq");
    if (response.statusCode == 200) {
      //  log(response.body);
      Iterable list = json.decode(response.body);
      SharedPreferencesClass.save("listHebergement", response.body);
      return list.map((model) => HerbergemntMod.fromJson(model)).toList();
    } else {
      throw Exception('Failed to load album');
    }
  }

  static Future<List<HerbergemntMod>> getAllHebergementsUser(idu) async {
    http.Response response = await http.post(
        'https://sleepmoh.com/http_flutter.php',
        body: <String, String>{"action": 'rechecheHeberAllIdu', "idu": idu});
    //  log("httpreq");
    if (response.statusCode == 200) {
      //  log(response.body);
      Iterable list = json.decode(response.body);
      SharedPreferencesClass.save("listHebergementuser", response.body);
      return list.map((model) => HerbergemntMod.fromJson(model)).toList();
    } else {
      throw Exception('Failed to load album');
    }
  }

  static Future<List<HerbergemntMod>> getlimitHebergements() async {
    http.Response response = await http.post(
        'https://sleepmoh.com/http_flutter.php',
        body: <String, String>{"action": 'rechecheHeberlimit'});
    //  log("httpreq");
    if (response.statusCode == 200) {
      //  print(response.body);
      Iterable list = json.decode(response.body);
      SharedPreferencesClass.save("listHebergement", response.body);
      return list.map((model) => HerbergemntMod.fromJson(model)).toList();
    } else {
      throw Exception('Failed to load album');
    }
  }

  static Future<List<Tourisme>> getAllTourisme() async {
    http.Response response = await http.post(
        'https://sleepmoh.com/http_flutter.php',
        body: <String, String>{"action": 'rechechetouAll'});
    //  log("httpreq");
    if (response.statusCode == 200) {
      //  log(response.body);
      Iterable list = json.decode(response.body);
      SharedPreferencesClass.save("listTourisme", response.body);
      return list.map((model) => Tourisme.fromJson(model)).toList();
    } else {
      throw Exception('Failed to load album');
    }
  }

  static Future<List<Tourisme>> getlimitTourisme() async {
    http.Response response = await http.post(
        'https://sleepmoh.com/http_flutter.php',
        body: <String, String>{"action": 'rechechetouLimit'});
    //  log("httpreq");
    if (response.statusCode == 200) {
      //  print(response.body);
      Iterable list = json.decode(response.body);
      SharedPreferencesClass.save("listTourisme", response.body);
      return list.map((model) => Tourisme.fromJson(model)).toList();
    } else {
      throw Exception('Failed to load album');
    }
  }

  static Future<List<ConversMod>> getAllConvers(number) async {
    http.Response response = await http.post(
        'https://sleepmoh.com/manager/http.php',
        body: <String, String>{"action": 'getdiscutions', "nbr": number});
    //  log("httpreq");
    if (response.statusCode == 200) {
    // log(response.body);

      getAllMessages(number);
      // log('savelistTot-Hotel');
      Iterable list = json.decode(response.body);
      SharedPreferencesClass.save("listConversation", response.body);
      return list.map((model) => ConversMod.fromJson(model)).toList();
    } else {
      throw Exception('Failed to load album');
    }
  }

  static Future<List<MessageTchaMod>> getAllMessages(number) async {
    http.Response response = await http.post(
        'https://sleepmoh.com/http_flutter.php',
        body: <String, String>{"action": 'getmessagetel', "id": number});
    // log("httpreq dedans");
    if (response.statusCode == 200) {
     // print(response.body);
      Iterable list = json.decode(response.body);
      SharedPreferencesClass.save("listMessages", response.body);
      return list.map((model) => MessageTchaMod.fromJson(model)).toList();
    } else {
      throw Exception('Failed to load album');
    }
  }

  static Future<List<ImmobMod>> getAllImobi() async {
    http.Response response = await http.post(
        'https://sleepmoh.com/http_flutter.php',
        body: <String, String>{"action": 'immobilierAll'});
    //  log("httpreq");
    if (response.statusCode == 200) {
      //  log(response.body);
      Iterable list = json.decode(response.body);
      SharedPreferencesClass.save("listImobi", response.body);
      return list.map((model) => ImmobMod.fromJson(model)).toList();
    } else {
      throw Exception('Failed to load album');
    }
  }

  static Future<List<ImmobMod>> getlimitImobi() async {
    http.Response response = await http.post(
        'https://sleepmoh.com/http_flutter.php',
        body: <String, String>{"action": 'immobilierlimit'});
    //  log("httpreq");
    if (response.statusCode == 200) {
      //  print(response.body);
      Iterable list = json.decode(response.body);
      SharedPreferencesClass.save("listImobi", response.body);
      return list.map((model) => ImmobMod.fromJson(model)).toList();
    } else {
      throw Exception('Failed to load album');
    }
  }

  static Future<List<TerrainMod>> getAllTerrain() async {
    http.Response response = await http.post(
        'https://sleepmoh.com/http_flutter.php',
        body: <String, String>{"action": 'terrainAll'});
    //  log("httpreq");
    if (response.statusCode == 200) {
      //  log(response.body);
      Iterable list = json.decode(response.body);
      SharedPreferencesClass.save("listTerrain", response.body);
      return list.map((model) => TerrainMod.fromJson(model)).toList();
    } else {
      throw Exception('Failed to load album');
    }
  }

  static Future<List<TerrainMod>> getlimitTerrain() async {
    http.Response response = await http.post(
        'https://sleepmoh.com/http_flutter.php',
        body: <String, String>{"action": 'terrainlimit'});
    //  log("httpreq");
    if (response.statusCode == 200) {
      //  print(response.body);
      Iterable list = json.decode(response.body);
      SharedPreferencesClass.save("listTerrain", response.body);
      return list.map((model) => TerrainMod.fromJson(model)).toList();
    } else {
      throw Exception('Failed to load album');
    }
  }

  static Future<List<MaisonMod>> getAllMaison() async {
    http.Response response = await http.post(
        'https://sleepmoh.com/http_flutter.php',
        body: <String, String>{"action": 'maisonAll'});
    //  log("httpreq");
    if (response.statusCode == 200) {
      //  log(response.body);
      Iterable list = json.decode(response.body);
      SharedPreferencesClass.save("listMaison", response.body);
      return list.map((model) => MaisonMod.fromJson(model)).toList();
    } else {
      throw Exception('Failed to load album');
    }
  }

  static Future<List<MaisonMod>> getlimitMaison() async {
    http.Response response = await http.post(
        'https://sleepmoh.com/http_flutter.php',
        body: <String, String>{"action": 'maisonlimit'});
    //  log("httpreq");
    if (response.statusCode == 200) {
      //  print(response.body);
      Iterable list = json.decode(response.body);
      SharedPreferencesClass.save("listMaison", response.body);
      return list.map((model) => MaisonMod.fromJson(model)).toList();
    } else {
      throw Exception('Failed to load album');
    }
  }

  static Future<List<EntreMod>> getAllEntre() async {
    http.Response response = await http.post(
        'https://sleepmoh.com/http_flutter.php',
        body: <String, String>{"action": 'entre_nousAll'});
    //  log("httpreq");
    if (response.statusCode == 200) {
      //  log(response.body);
      Iterable list = json.decode(response.body);
      SharedPreferencesClass.save("listEntre", response.body);
      return list.map((model) => EntreMod.fromJson(model)).toList();
    } else {
      throw Exception('Failed to load album');
    }
  }

  static Future<List<EntreMod>> getlimitEntre() async {
    http.Response response = await http.post(
        'https://sleepmoh.com/http_flutter.php',
        body: <String, String>{"action": 'entre_nouslimit'});
    //  log("httpreq");
    if (response.statusCode == 200) {
      //  print(response.body);
      Iterable list = json.decode(response.body);
      SharedPreferencesClass.save("listEntre", response.body);
      return list.map((model) => EntreMod.fromJson(model)).toList();
    } else {
      throw Exception('Failed to load album');
    }
  }

/*
  static Future<List<Question>> fetchQuestion() async {
  final response = await http.get('https://small-pockect-api.herokuapp.com/questions');

  if (response.statusCode == 200) {
       // return Question.fromJson(json.decode(response.body));
        Iterable list = json.decode(response.body);
        return list.map((model) => Question.fromJson(model)).toList();
      
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
     static Future<Question> getquestions() async {
Map data;

   final response = await http.get('https://small-pockect-api.herokuapp.com/questions');
           
        return Question.fromJson(json.decode(response.body));
    }
  */
  static Future<String> register_request(
      log, tel, code, name, password0) async {
    // String urli = 'https://small-pocket.herokuapp.com/api/v1/auth/sign_in';
    // var url = '${urli}ocr';
    // var bytes = image.readAsBytesSync();
    print(tel);
    http.Response response = await http
        .post('https://sleepmoh.com/http_flutter.php', body: <String, String>{
      "action": "register_phone",
      "tel": tel,
      "log": log,
      "pass0": password0,
      "name": name,
      "pays": code
    });
    if (response.statusCode == 200) {
      
        // log('savelistTot-Hotel');
        print(response.body);
       if (response.body != "" && response.body != "exit") {
         HttpPostRequest.getAllConvers(log).then((List<ConversMod> result) {
          /*
          SharedPreferencesClass.save("userinfos", response.body);
           var userinfos = new List<UserMod>();
           
      Iterable list0 = jsonDecode(response.body);
       userinfos = list0.map((model) => UserMod.fromJson(model)).toList();
          globals.userinfos = userinfos[0];

          */
          
          });
          return response.body;
          
        } else {
          return response.body;
        }
        
    } else {
      return "error";
      //  throw Exception('Failed to load album');

    }
  }

  static Future<String> login_request(log, password0) async {
    // String urli = 'https://small-pocket.herokuapp.com/api/v1/auth/sign_in';
    // var url = '${urli}ocr';
    // var bytes = image.readAsBytesSync();
   
    http.Response response = await http
        .post('https://sleepmoh.com/http_flutter.php', body: <String, String>{
      "action": "login_phone",
      "log": log,
      "pass0": password0
    });
    if (response.statusCode == 200) {
     
        if (response.body != "" && response.body != "exit") {
          SharedPreferencesClass.save("userinfos", response.body);
          HttpPostRequest.getAllConvers(log).then((List<ConversMod> result) {
        // log('savelistTot-Hotel');
      
      });
          return response.body;
        } else {
          return response.body;
        }
     /* */
    } else {
      return "error";
      //  throw Exception('Failed to load album');

    }
  }

  static Future<String> create_con_request(
      tel, message, nom, img, idb, iddest, type) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userToken = prefs.get('FCMToken');
    print("tokkk  " + type);

    http.Response response = await http
        .post('https://sleepmoh.com/manager/http.php', body: <String, String>{
      "action": "messageP",
      "nbr": tel,
      "nom": nom,
      "iddest": iddest,
      "img": img,
      "idb": idb,
      "typebien": type,
      "token": userToken,
      "msg": message
    });
    //  print(response.body);
    if (response.statusCode == 200) {
      getAllConvers(tel);
      /* if (response.body != "" && response.body s!= "exit"){
     // SharedPreferencesClass.save("userinfos", response.body);
       return response.body;
      
      }else{
        return response.body;
      }
    */
    } else {
      return "error";
      //  throw Exception('Failed to load album');

    }
  }

  static Future<String> sendMessage(tel, code) async {
    print(tel);
    var text = "Votre code d'activation est :";
    var text1 = "&content=";
/*
http://smsgw.gtsnetwork.cloud:PORT/message?user=USER&pass=PASSWORD&fro
m=SENDERID&to=RECIPIENT&tag=GSM&text=MsgBoby&id=ID&dlrreq=DLR
http://smsgw.gtsnetwork.cloud:4000/message?user=SleepMoh&pass=EY16h@WZSb4TS&from=gtsnetwork&to=237691779906&tag=GSM&text=bonjour&id=2657867&dlrreq=0
 */


    http.Response response = await http.get(
        "https://api.clockworksms.com/http/send.aspx?key=5720bcd2669985c692e13c49a0ecf636ef11f1d5&to=" +
            tel.toString() +
            text1 +
            text +
            code.toString());
           
    if (response.statusCode == 200) {
      print(response.body);

      if (response.body != "" && response.body != "exit") {
        // SharedPreferencesClass.save("userinfos", response.body);
        return response.body;
      } else {
        return response.body;
      }
    } else {
      return "error";
    }
  }

  static List<Map> toBase64(List<File> fileList, String id) {
    List<Map> s = new List<Map>();

    if (fileList.length > 0)
      fileList.forEach((element) async {
        http.Response response =
            await http.post('https://sleepmoh.com/http_flutter.php', body: {
          "action": "flutter_imagess_uploade",
          "name": basename(element.path),
          "id": id,
          "file": base64Encode(element.readAsBytesSync())
        });
        if (response.statusCode == 200) {
          print(response.body);
        } else {
          //return "error";
          //  throw Exception('Failed to load album');

        }
      });
    return s;
  }

  static Future<String> uploade_image_up(
      log, tel, code, name, password0, filename, base64img, idu) async {
    print(tel);

    http.Response response =
        await http.post('https://sleepmoh.com/http_flutter.php', body: {
      "action": "uploadimg_phone",
      "idu": idu,
      "tel": tel,
      "pass0": password0,
      "log": log,
      "name": name,
      "file": filename,
      "image": base64img,
      "pays": code
    });
    if (response.statusCode == 200) {
      print(response.body);
      if (response.body != "" && response.body != "exit") {
        SharedPreferencesClass.save("userinfos", response.body);
        return response.body;
      } else {
        return response.body;
      }
    } else {
      return "error";
      //  throw Exception('Failed to load album');

    }
  }

  static Future<String> uploade_image_hebergement(
      log,
      tel,
      code,
      name,
      password0,
      filename,
      base64img,
      idu,
      fileArray,
      clim,
      barri,
      internet,
      parki,
      eauch,
      clautu,
      ascenseur,
      groupe,
      piscin,
      wifi,
      gard,
      tera) async {
    http.Response response = await http.post(
        'https://sleepmoh.com/http_flutter.php',
        body: {"action": "uploadimg_phone", "idu": idu, "tel": tel});
    if (response.statusCode == 200) {
      print(response.body);
      if (response.body != "" && response.body != "exit") {
        SharedPreferencesClass.save("userinfos", response.body);
        return response.body;
      } else {
        return response.body;
      }
    } else {
      return "error";
      //  throw Exception('Failed to load album');

    }
  }

  static Future<String> httpSend(Map params) async {
    http.Response response =
        await http.post('https://sleepmoh.com/upload_image.php', body: params);
    if (response.statusCode == 200) {
      return (response.body);
    } else {
      return "error";
    }
  }

  // ignore: non_constant_identifier_names
  static Future<String> save_hebergement(
      _id,
      _typeb,
      _vile,
      _quartier,
      _zone,
      confirmedNumber,
      _periode,
      _prix,
      _capacit,
      _aces,
      niveauss,
      stanting,
      descfr,
      descen,
      idu,
      clim,
      barri,
      internet,
      parki,
      eauch,
      clautu,
      ascenseur,
      groupe,
      piscin,
      wifi,
      gard,
      tera,
      fileimage) async {
    //print(tel);
    // print("freeee");

    fileimage.forEach((element) async {
      http.Response response =
          await http.post('https://sleepmoh.com/http_flutter.php', body: {
        "action": "flutter_imagess_uploade",
        "name": basename(element.path),
        "id": _id,
        "file": base64Encode(element.readAsBytesSync())
      });
      if (response.statusCode == 200) {
        // print(response.body);
      } else {
        //return "error";
        //  throw Exception('Failed to load album');

      }
    });
    /*  httpSend(params).then((value) {
      print("value");
      print(value);
    });*/
    if (clim == true) {
      http.Response response = await http
          .post('https://sleepmoh.com/http_flutter.php', body: <String, String>{
        "action": "addresources_flutter",
        "nom": "Climatisation",
        "idb": _id,
        "type": _typeb
      });
      if (response.statusCode == 200) {
        print(response.body);
      } else {
        return "error";
      }
    }
    if (barri == true) {
      http.Response response = await http
          .post('https://sleepmoh.com/http_flutter.php', body: <String, String>{
        "action": "addresources_flutter",
        "nom": "Barrière",
        "idb": _id,
        "type": _typeb
      });
      if (response.statusCode == 200) {
        // print(response.body);
      } else {
        return "error";
      }
    }
    if (internet == true) {
      http.Response response = await http
          .post('https://sleepmoh.com/http_flutter.php', body: <String, String>{
        "action": "addresources_flutter",
        "nom": "Internet",
        "idb": _id,
        "type": _typeb
      });
      if (response.statusCode == 200) {
        // print(response.body);
      } else {
        return "error";
      }
    }
    if (parki == true) {
      http.Response response = await http
          .post('https://sleepmoh.com/http_flutter.php', body: <String, String>{
        "action": "addresources_flutter",
        "nom": "Parking",
        "idb": _id,
        "type": _typeb
      });
      if (response.statusCode == 200) {
        // print(response.body);
      } else {
        return "error";
      }
    }
    if (eauch == true) {
      http.Response response = await http
          .post('https://sleepmoh.com/http_flutter.php', body: <String, String>{
        "action": "addresources_flutter",
        "nom": "Eau Chaude",
        "idb": _id,
        "type": _typeb
      });
      if (response.statusCode == 200) {
        // print(response.body);
      } else {
        return "error";
      }
    }
    if (clautu == true) {
      http.Response response = await http
          .post('https://sleepmoh.com/http_flutter.php', body: <String, String>{
        "action": "addresources_flutter",
        "nom": "Clôture",
        "idb": _id,
        "type": _typeb
      });
      if (response.statusCode == 200) {
        // print(response.body);
      } else {
        return "error";
      }
    }
    if (ascenseur == true) {
      http.Response response = await http
          .post('https://sleepmoh.com/http_flutter.php', body: <String, String>{
        "action": "addresources_flutter",
        "nom": "Ascenseur",
        "idb": _id,
        "type": _typeb
      });
      if (response.statusCode == 200) {
        // print(response.body);
      } else {
        return "error";
      }
    }
    if (groupe == true) {
      http.Response response = await http
          .post('https://sleepmoh.com/http_flutter.php', body: <String, String>{
        "action": "addresources_flutter",
        "nom": "Groupe électrogène",
        "idb": _id,
        "type": _typeb
      });
      if (response.statusCode == 200) {
        // print(response.body);
      } else {
        return "error";
      }
    }
    if (piscin == true) {
      http.Response response = await http
          .post('https://sleepmoh.com/http_flutter.php', body: <String, String>{
        "action": "addresources_flutter",
        "nom": "Piscine",
        "idb": _id,
        "type": _typeb
      });
      if (response.statusCode == 200) {
        // print(response.body);
      } else {
        return "error";
      }
    }
    if (wifi == true) {
      http.Response response = await http
          .post('https://sleepmoh.com/http_flutter.php', body: <String, String>{
        "action": "addresources_flutter",
        "nom": "Wi-Fi",
        "idb": _id,
        "type": _typeb
      });
      if (response.statusCode == 200) {
        // print(response.body);
      } else {
        return "error";
      }
    }
    if (gard == true) {
      http.Response response = await http
          .post('https://sleepmoh.com/http_flutter.php', body: <String, String>{
        "action": "addresources_flutter",
        "nom": "Gardiennage",
        "idb": _id,
        "type": _typeb
      });
      if (response.statusCode == 200) {
        // print(response.body);
      } else {
        return "error";
      }
    }
    if (tera == true) {
      http.Response response = await http
          .post('https://sleepmoh.com/http_flutter.php', body: <String, String>{
        "action": "addresources_flutter",
        "nom": "Terrasse",
        "idb": _id,
        "type": _typeb
      });
      if (response.statusCode == 200) {
        // print(response.body);
      } else {
        return "error";
      }
    }

    http.Response response = await http
        .post('https://sleepmoh.com/http_flutter.php', body: <String, String>{
      "action": "save_Hebergement",
      "id": _id,
      "type": _typeb,
      "vil": _vile,
      "cart": _quartier,
      "zon": _zone,
      "ns": niveauss,
      "acc": _aces,
      "stang": stanting,
      "pri": _prix,
      "pl": _periode,
      "tele": confirmedNumber,
      "cap": _capacit,
      "descpan": descen,
      "descp": descfr,
      "user_id": idu,
    });
    if (response.statusCode == 200) {
      print(response.body);
      getAllImages();

      Iterable list = json.decode(response.body);
      SharedPreferencesClass.save("listHebergementuser", response.body);

      if (response.body != "" && response.body != "exit") {
        return response.body;
      } else {
        return response.body;
      }
    } else {
      return "error";
      //  throw Exception('Failed to load album');

    }
  }

/*
  static Future<String> uploadmultipleimage(List images) async {
    var uri = Uri.parse("");
    http.MultipartRequest request = new http.MultipartRequest('POST', uri);
    request.headers[''] = '';
    request.fields['user_id'] = '10';
    request.fields['post_details'] = 'dfsfdsfsd';
    //multipartFile = new http.MultipartFile("imagefile", stream, length, filename: basename(imageFile.path));
    List<http.MultipartFile> newList = new List<MultipartFile>();
    for (int i = 0; i < images.length; i++) {
      File imageFile = File(images[i].toString());
      var stream =
          new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
      var length = await imageFile.length();
      var multipartFile = new http.MultipartFile("imagefile", stream, length,
          filename: basename(imageFile.path));
      newList.add(multipartFile);
    }
    request.files.addAll(newList);
    var response = await request.send();
    if (response.statusCode == 200) {
      print("Image Uploaded");
    } else {
      print("Upload Failed");
    }
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
  }
*/
  static Future<String> certifiCompte(tel, code, password) async {
    // String urli = 'https://small-pocket.herokuapp.com/api/v1/auth/sign_in';
    // var url = '${urli}ocr';
    // var bytes = image.readAsBytesSync();
    print(tel);
    var response = await http.post(
        'https://small-pockect-api.herokuapp.com/auth',
        body: <String, String>{
          "phone": tel,
          "password": password,
          "password_confirmation": password,
          "country": code,
          "code_country": code
        });
    print(response.statusCode);
    return response.body;
  }
}
