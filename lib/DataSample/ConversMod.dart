
import 'dart:convert';

import 'dart:ffi';


class ConversMod {
  String id;
  String iddis;
  String nomdis;
  String predis;
  String surdis;
  String msgdis;
  String dis1;
  String libelle;
  String type;
  String prix;
  String periode;
  String taille;
  String capacite;
  String description;
  String etat;
  String iduser;
  String message;
  String nonlus;

  ConversMod(String id, String nonlus, String message, String nomdis, String predis, String surdis, String msgdis, String dis1, String libelle ,String type , String prix, String periode, String taille, String capacite, String description, String etat, String iduser){
    this.id = id;
    this.nonlus = nonlus;
    this.iddis = iddis;
    this.nomdis = nomdis;    
    this.message = message;    
    this.predis = predis;    
    this.surdis = surdis;
    this.libelle = libelle;
    this.msgdis = msgdis;
    this.dis1 = dis1;
    this.type = type;
    this.prix = prix;
    this.periode = periode;
    this.taille = taille;
    this.capacite = capacite;
    this.description = description;
    this.etat = etat;
    this.iduser = iduser;
  }

    ConversMod.fromJson(Map json)
      : id = json['id'],
        libelle = json['libelle'],
        iddis = json['Iddis'],
        nomdis = json['nomdis'],
        nonlus = json['nonlue'],
        dis1 = json['dis1'],
        message = json['message'],
        predis = json['predis'],
        surdis = json['surdis'],
        msgdis = json['msgdis'],
        type = json['type'],
        prix = json['prix'],        
        periode = json['periode'],
        taille = json['taille'],
        capacite = json['capacite'],
        description = json['description'],
        etat = json['etat'],
        iduser = json['id_user'];

   Map toJson() {
    return {'id': id,'iddis': iddis, 'nonlus': nonlus, 'nomdis': nomdis,'predis': predis, 'surdis': surdis, 'message': message,  'msgdis': msgdis,'type': type, 'prix': prix, 'periode': periode, 'taille': taille, 'capacite': capacite, 'description': description, 'etat': etat, 'iduser': iduser};
  }

  static Map<String, dynamic> toMap(ConversMod herbergement) => {
      'id': herbergement.id, 
      'libelle': herbergement.libelle, 
      'iddis': herbergement.iddis, 
      'nonlus': herbergement.nonlus, 
      'nomdis': herbergement.nomdis,
      'predis': herbergement.predis, 
      'surdis': herbergement.surdis, 
      'message': herbergement.message, 
      'msgdis': herbergement.msgdis, 
      'type': herbergement.type, 
      'dis1': herbergement.dis1, 
      'prix': herbergement.prix, 
      'periode': herbergement.periode, 
      'taille': herbergement.taille, 
      'capacite': herbergement.capacite, 
      'description': herbergement.description, 
      'etat': herbergement.etat, 
      'iduser': herbergement.iduser,
      };

  static String encodeHotels(List<ConversMod> hotelhts) => json.encode(
        hotelhts
            .map<Map<String, dynamic>>((hotelht) => toMap(hotelht))
            .toList(),
      );

    static List<ConversMod> decodeHotels(String hotelhts) =>
      (json.decode(hotelhts) as List<dynamic>)
          .map<ConversMod>((item) => ConversMod.fromJson(item))
          .toList();
    
} 

 