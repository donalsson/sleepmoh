
import 'dart:convert';

import 'dart:ffi';


class Hotelht {
  String id;
  String libelle;
  String type;
  String prix;
  int prixr;
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
  String nom;
  double ln;
  double lat;

  Hotelht(double ln, double lat , double nombreetoile, String id, String libelle ,String imgh , String localisation, String imghotel , String type, int prixr, String prix, String periode, String taille, String capacite, String description, String etat, String iduser, String created, String modified, String descrip, String nom){
    this.id = id;
    this.ln = ln;
    this.lat = lat;    
    this.nombreetoile = nombreetoile;
    this.libelle = libelle;
    this.imgh = imgh;
     this.localisation = id;
    this.imghotel = imghotel;
    this.type = type;
    this.prix = prix;
    this.prixr = prixr;
    this.periode = periode;
    this.taille = taille;
    this.capacite = capacite;
    this.description = description;
    this.etat = etat;
    this.iduser = iduser;
    this.created = created;
    this.modified = modified;
    this.descrip = descrip;
    this.nom = nom;
  }

    Hotelht.fromJson(Map json)
      : id = json['id'],
        libelle = json['libelle'],
        imgh = json['imgh'],
        ln = json['ln'],
        lat = json['lat'],        
        nombreetoile = json['nombreetoile'],
        type = json['type'],
        prix = json['prix'],        
        prixr = json['prixr'],        
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
        nom = json['nom'];

   Map toJson() {
    return {'ln': ln, 'lat': lat, 'id': id,'nombreetoile': nombreetoile, 'imghotel': imghotel,'localisation': localisation, 'libelle': libelle,'imgh': imgh, 'type': type, 'prix': prix, 'prixr': prixr, 'periode': periode, 'taille': taille, 'capacite': capacite, 'description': description, 'etat': etat, 'iduser': iduser, 'created': created, 'modified': modified, 'descrip': descrip, 'nom': nom};
  }

  static Map<String, dynamic> toMap(Hotelht hotel) => {
      'id': hotel.id, 
      'libelle': hotel.libelle, 
      'ln': hotel.ln, 
      'lat': hotel.lat, 
      'imgh': hotel.imgh, 
      'nombreetoile': hotel.nombreetoile, 
      'imghotel': hotel.imghotel, 
      'localisation': hotel.localisation, 
      'type': hotel.type, 
      'prix': hotel.prix, 
      'prixr': hotel.prixr, 
      'periode': hotel.periode, 
      'taille': hotel.taille, 
      'capacite': hotel.capacite, 
      'description': hotel.description, 
      'etat': hotel.etat, 
      'iduser': hotel.iduser, 
      'created': hotel.created, 
      'modified': hotel.modified, 
      'descrip': hotel.descrip, 
      'nom': hotel.nom
      };

  static String encodeHotels(List<Hotelht> hotelhts) => json.encode(
        hotelhts
            .map<Map<String, dynamic>>((hotelht) => toMap(hotelht))
            .toList(),
      );

    static List<Hotelht> decodeHotels(String hotelhts) =>
      (json.decode(hotelhts) as List<dynamic>)
          .map<Hotelht>((item) => Hotelht.fromJson(item))
          .toList();
    
} 

 