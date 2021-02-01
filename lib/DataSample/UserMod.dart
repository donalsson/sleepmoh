
import 'dart:convert';

import 'dart:ffi';


class UserMod {
  String idu;
  String typecompte;
  String nom;
  String login;
  String password;
  String telephone;
  String avatar;

  UserMod(String idu, String typecompte ,String nom ,String login ,String password ,String telephone ,String avatar){
    this.idu = idu;
    this.typecompte = typecompte;
    this.nom = nom;
    this.login = login;
    this.password = password;
    this.telephone = telephone;
    this.avatar = avatar;
  }
  /*
   "idm": "867",
        "id_user": "691779906",
        "id_pro": "yyy",
        "id_bien": null,
        "message": "rrr",
        "datemesage": "1607030954",
        "heuremessage": "22 h 29",
        "message_a": "0",
        "message_b": "eo8iVi2KOLbOpSM4d1r7sG:APA91bEBv-t2Mtwdq0LuthpRriAfTcUo9Fmeu6rbQKaDtf62tCqGs8eyoz12WmWZ7HlHmkTHkj16DP6vA9nbSaJK-vYfAt-ajqLWmC3cHapC9f7FHSoikDR-KqMYxZDokkac9Rm1IY8E",
        "message_c": "64",
        "message_d": "",
        "message_e": "0"
*/
    UserMod.fromJson(Map json)
      : idu = json['idu'],
        typecompte = json['typecompte'],
        nom = json['nom'],
        login = json['login'],
        password = json['password'],
        telephone = json['telephone'],
        avatar = json['avatar'];

   Map toJson() {
    return {'idu': idu,'typecompte': typecompte, 'nom': nom,'login': login, 'password': password, 'telephone': telephone, 'avatar': avatar};
  }

  static Map<String, dynamic> toMap(UserMod herbergement) => {
      'idu': herbergement.idu, 
      'typecompte': herbergement.typecompte, 
      'nom': herbergement.nom, 
      'login': herbergement.login,
      'password': herbergement.password, 
      'telephone': herbergement.telephone, 
      'avatar': herbergement.avatar
      };

  static String encodeHotels(List<UserMod> hotelhts) => json.encode(
        hotelhts
            .map<Map<String, dynamic>>((hotelht) => toMap(hotelht))
            .toList(),
      );

    static List<UserMod> decodeHotels(String hotelhts) =>
      (json.decode(hotelhts) as List<dynamic>)
          .map<UserMod>((item) => UserMod.fromJson(item))
          .toList();
    
} 

 