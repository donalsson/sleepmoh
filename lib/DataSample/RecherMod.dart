
import 'dart:convert';

import 'dart:ffi';


class RecherMod {
  String id;
  String typefr;
  String typeen;
  String prix;  
  String perifr;
  String perien;
  String taille;
  String capacite;
  String localisation;
  String imgh;
  double nombreetoile;
  String nom;
  double ln;
  double note;
  double lat;

  RecherMod(double note, double ln, double lat , double nombreetoile, String id, String libelle ,String typefr ,String typeen ,String perifr ,String perien ,String imgh , String localisation, String imghotel , String type, String prix, String periode, String taille, String capacite, String description, String etat, String iduser, String created, String modified, String descrip, String nom, String notefr, String noteen, String accesfr, String accesen, String standingfr, String standingen, String securitefr, String securiteen){
    this.id = id;
    this.ln = ln;
    this.lat = lat;    
    this.note = note;    
    this.nombreetoile = nombreetoile;
    this.perifr = perifr;
    this.perien = perien;
    this.typefr = typefr;
    this.typeen = typeen;
    this.imgh = imgh;
     this.localisation = localisation;
    this.prix = prix;
    this.taille = taille;
    this.capacite = capacite;
    this.nom = nom;
  }

    RecherMod.fromJson(Map json)
      : id = json['id'],
        typefr = json['typefr'],
        typeen = json['typeen'],
        perifr = json['perifr'],
        perien = json['perien'],
        imgh = json['imgh'],
        ln = json['ln'],
        lat = json['lat'],        
        note = json['note'],        
        nombreetoile = json['nombreetoile'],
        prix = json['prix'],        
        localisation = json['localisation'],
        taille = json['taille'],
        capacite = json['capacite'],
        nom = json['nom'];

   Map toJson() {
    return {'ln': ln, 'lat': lat, 'note': note, 'id': id,'nombreetoile': nombreetoile,'localisation': localisation,'typefr': typefr, 'typeen': typefr, 'perifr': perifr, 'perien': perien,'imgh': imgh, 'prix': prix,  'taille': taille, 'capacite': capacite,'nom': nom};
  }

  static Map<String, dynamic> toMap(RecherMod herbergement) => {
      'id': herbergement.id, 
      'typefr': herbergement.typefr, 
      'typeen': herbergement.typeen,
      'perifr': herbergement.perifr, 
      'perien': herbergement.perien, 
      'ln': herbergement.ln, 
      'lat': herbergement.lat, 
      'note': herbergement.note, 
      'imgh': herbergement.imgh, 
      'nombreetoile': herbergement.nombreetoile, 
      'localisation': herbergement.localisation,
      'prix': herbergement.prix, 
      'taille': herbergement.taille, 
      'capacite': herbergement.capacite, 
      'nom': herbergement.nom
      };

  static String encodeHotels(List<RecherMod> hotelhts) => json.encode(
        hotelhts
            .map<Map<String, dynamic>>((hotelht) => toMap(hotelht))
            .toList(),
      );

    static List<RecherMod> decodeHotels(String hotelhts) =>
      (json.decode(hotelhts) as List<dynamic>)
          .map<RecherMod>((item) => RecherMod.fromJson(item))
          .toList();
    
} 

 