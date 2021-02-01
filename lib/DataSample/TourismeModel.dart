
import 'dart:convert';

import 'dart:ffi';


class Tourisme {
  String id;
  String libelle;
  String typefr;
  String typeen;
  String type;
  String prix;
  String periode;
  String taille;
  String capacite;
  String description;
  String etat;
  String iduser;
  String localisation;
  String imghotel;
  String created;
  String imgh;
  String modified;
  String descrip;
  double nombreetoile;
  String nomtr;
  double ln;
  double lat;

  Tourisme(double ln, double lat , double nombreetoile, String id, String libelle ,String typefr ,String typeen ,String perifr ,String perien ,String imgh , String localisation, String imghotel , String type, String prix, String periode, String taille, String capacite, String description, String etat, String iduser, String created, String modified, String descrip, String nomtr){
    this.id = id;
    this.ln = ln;
    this.lat = lat;    
    this.nombreetoile = nombreetoile;
    this.libelle = libelle;
    this.typefr = typefr;
    this.typeen = typeen;
    this.imgh = imgh;
     this.localisation = localisation;
    this.imghotel = imghotel;
    this.type = type;
    this.prix = prix;
    this.periode = periode;
    this.taille = taille;
    this.capacite = capacite;
    this.description = description;
    this.etat = etat;
    this.iduser = iduser;
    this.created = created;
    this.modified = modified;
    this.descrip = descrip;
    this.nomtr = nomtr;
  }

    Tourisme.fromJson(Map json)
      : id = json['id'],
        libelle = json['libelle'],
        typefr = json['typefr'],
        typeen = json['typeen'],
        imgh = json['imgh'],
        ln = json['ln'],       
        lat = json['lat'],       
        nombreetoile = json['nombreetoile'],
        type = json['type'],
        prix = json['prix'],        
        imghotel = json['avatar'],
        localisation = json['localisation'],
        periode = json['periode'],
        taille = json['taille'],
        capacite = json['capacite'],
        description = json['description'],
        etat = json['etat'],
        iduser = json['iduser'],
        created = json['created'],
        modified = json['modified'],
        descrip = json['descrip'],
        nomtr = json['nomtr'];

   Map toJson() {
    return {'ln': ln, 'lat': lat, 'id': id,'nombreetoile': nombreetoile, 'imghotel': imghotel,'localisation': localisation, 'libelle': libelle, 'typefr': typefr, 'typeen': typefr,'imgh': imgh, 'type': type, 'prix': prix, 'periode': periode, 'taille': taille, 'capacite': capacite, 'description': description, 'etat': etat, 'iduser': iduser, 'created': created, 'modified': modified, 'descrip': descrip, 'nomtr': nomtr};
  }

  static Map<String, dynamic> toMap(Tourisme tourisme) => {
      'id': tourisme.id, 
      'libelle': tourisme.libelle, 
      'typefr': tourisme.typefr, 
      'typeen': tourisme.typeen, 
      'ln': tourisme.ln, 
      'lat': tourisme.lat, 
      'imgh': tourisme.imgh, 
      'nombreetoile': tourisme.nombreetoile, 
      'imghotel': tourisme.imghotel, 
      'localisation': tourisme.localisation, 
      'type': tourisme.type, 
      'prix': tourisme.prix,
      'periode': tourisme.periode, 
      'taille': tourisme.taille, 
      'capacite': tourisme.capacite, 
      'description': tourisme.description, 
      'etat': tourisme.etat, 
      'iduser': tourisme.iduser, 
      'created': tourisme.created, 
      'modified': tourisme.modified, 
      'descrip': tourisme.descrip,
      'nomtr': tourisme.nomtr
      };

  static String encodeHotels(List<Tourisme> hotelhts) => json.encode(
        hotelhts
            .map<Map<String, dynamic>>((hotelht) => toMap(hotelht))
            .toList(),
      );

    static List<Tourisme> decodeHotels(String hotelhts) =>
      (json.decode(hotelhts) as List<dynamic>)
          .map<Tourisme>((item) => Tourisme.fromJson(item))
          .toList();
    
} 

 