
import 'dart:convert';

import 'dart:ffi';


class MessageTchaMod {
  String idm;
  String iduser;
  String idpro;
  String idbien;
  String datemesage;
  String heuremessage;
  String message;
  String messagea;
  String messageb;
  String messagec;
  String messaged;
  String messagee;

  MessageTchaMod(String idm, String iduser ,String idpro ,String idbien ,String datemesage ,String heuremessage ,String message ,String messagea ,String messageb ,String messagec ,String messaged ,String messagee){
    this.idm = idm;
    this.iduser = iduser;
    this.idpro = idpro;
    this.idbien = idbien;
    this.datemesage = datemesage;
    this.heuremessage = heuremessage;
    this.message = message;
    this.messagea = messagea;
    this.messageb = messageb;
    this.messagec = messagec;
    this.messaged = messaged;
    this.messagee = messagee;
  }

    MessageTchaMod.fromJson(Map json)
      : idm = json['idm'],
        iduser = json['id_user'],
        idpro = json['id_pro'],
        idbien = json['id_bien'],
        datemesage = json['datemesage'],
        heuremessage = json['heuremessage'],
        message = json['message'],
        messagea = json['message_a'],
        messageb = json['message_b'],
        messagec = json['message_c'],
        messaged = json['message_d'],
        messagee = json['message_e'];

   Map toJson() {
    return {'idm': idm,'iduser': iduser, 'idpro': idpro,'idbien': idbien, 'datemesage': datemesage, 'heuremessage': heuremessage, 'messagea': messagea,  'message': message, 'messageb': messageb, 'messagec': messagec, 'messaged': messaged, 'messagee': messagee};
  }

  static Map<String, dynamic> toMap(MessageTchaMod herbergement) => {
      'idm': herbergement.idm, 
      'iduser': herbergement.iduser, 
      'idpro': herbergement.idpro, 
      'idbien': herbergement.idbien,
      'datemesage': herbergement.datemesage, 
      'heuremessage': herbergement.heuremessage, 
      'message': herbergement.message,
      'messagea': herbergement.messagea,
      'messageb': herbergement.messageb,
      'messagec': herbergement.messagec,
      'messaged': herbergement.messaged,
      'messagee': herbergement.messagee
      };

  static String encodeHotels(List<MessageTchaMod> hotelhts) => json.encode(
        hotelhts
            .map<Map<String, dynamic>>((hotelht) => toMap(hotelht))
            .toList(),
      );

    static List<MessageTchaMod> decodeHotels(String hotelhts) =>
      (json.decode(hotelhts) as List<dynamic>)
          .map<MessageTchaMod>((item) => MessageTchaMod.fromJson(item))
          .toList();
    
} 

 