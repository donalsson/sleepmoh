
import 'dart:convert';

import 'dart:ffi';


class EntreMod {
  String ide;
  String libelle;
  String typefr;
  String typeen;
  String perifr;
  String perien;
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
  String notefr;
  String noteen;
  String accesfr;
  String accesen;
  String standingfr;
  String standingen;
  String securitefr;
  String securiteen;
  double nombreetoile;
  String nom;
  double ln;
  double note;
  double lat;

  EntreMod(double note, double ln, double lat , double nombreetoile, String ide, String libelle ,String typefr ,String typeen ,String perifr ,String perien ,String imgh , String localisation, String imghotel , String type, String prix, String periode, String taille, String capacite, String description, String etat, String iduser, String created, String modified, String descrip, String nom, String notefr, String noteen, String accesfr, String accesen, String standingfr, String standingen, String securitefr, String securiteen){
    this.ide = ide;
    this.ln = ln;
    this.lat = lat;    
    this.note = note;    
    this.nombreetoile = nombreetoile;
    this.libelle = libelle;
    this.perifr = perifr;
    this.perien = perien;
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
    this.nom = nom;
    this.noteen = noteen;
    this.notefr = notefr;
    this.accesfr = accesfr;
    this.accesen = accesen;
    this.securiteen = securiteen;
    this.securitefr = securitefr;
    this.standingen = standingen;
    this.standingfr = standingfr;
  }

    EntreMod.fromJson(Map json)
      : ide = json['ide'],
        libelle = json['libelle'],
        typefr = json['typefr'],
        typeen = json['typeen'],
        perifr = json['perifr'],
        perien = json['perien'],
        imgh = json['imgh'],
        ln = json['ln'],
        lat = json['lat'],        
        note = json['note'],        
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
        nom = json['nom'],
        notefr = json['notefr'],
        noteen = json['noteen'],
        accesfr = json['accesfr'],
        accesen = json['accesen'],
        standingfr = json['standingfr'],
        standingen = json['standingen'],
        securiteen = json['securiteen'],
        securitefr = json['securitefr'];

   Map toJson() {
    return {'ln': ln, 'lat': lat, 'note': note, 'ide': ide,'nombreetoile': nombreetoile, 'imghotel': imghotel,'localisation': localisation, 'libelle': libelle, 'typefr': typefr, 'typeen': typefr, 'perifr': perifr, 'perien': perien,'imgh': imgh, 'type': type, 'prix': prix, 'periode': periode, 'taille': taille, 'capacite': capacite, 'description': description, 'etat': etat, 'iduser': iduser, 'created': created, 'modified': modified, 'descrip': descrip, 'nom': nom, 'notefr': notefr, 'noteen': noteen, 'accesen': accesen, 'accesfr': accesfr, 'standingfr': standingfr, 'standingen': standingen, 'securitefr': securitefr, 'securiteen': securiteen};
  }

  static Map<String, dynamic> toMap(EntreMod herbergement) => {
      'ide': herbergement.ide, 
      'libelle': herbergement.libelle, 
      'typefr': herbergement.typefr, 
      'typeen': herbergement.typeen,
      'perifr': herbergement.perifr, 
      'perien': herbergement.perien, 
      'ln': herbergement.ln, 
      'lat': herbergement.lat, 
      'note': herbergement.note, 
      'imgh': herbergement.imgh, 
      'nombreetoile': herbergement.nombreetoile, 
      'imghotel': herbergement.imghotel, 
      'localisation': herbergement.localisation, 
      'type': herbergement.type, 
      'prix': herbergement.prix, 
      'periode': herbergement.periode, 
      'taille': herbergement.taille, 
      'capacite': herbergement.capacite, 
      'description': herbergement.description, 
      'etat': herbergement.etat, 
      'iduser': herbergement.iduser, 
      'created': herbergement.created, 
      'modified': herbergement.modified, 
      'descrip': herbergement.descrip, 
      'noteen': herbergement.noteen, 
      'notefr': herbergement.notefr, 
      'standingen': herbergement.standingen, 
      'standingfr': herbergement.standingfr, 
      'accesen': herbergement.accesen, 
      'accesfr': herbergement.accesfr, 
      'securiteen': herbergement.securiteen, 
      'securitefr': herbergement.securitefr, 
      'nom': herbergement.nom
      };

  static String encodeHotels(List<EntreMod> hotelhts) => json.encode(
        hotelhts
            .map<Map<String, dynamic>>((hotelht) => toMap(hotelht))
            .toList(),
      );

    static List<EntreMod> decodeHotels(String hotelhts) =>
      (json.decode(hotelhts) as List<dynamic>)
          .map<EntreMod>((item) => EntreMod.fromJson(item))
          .toList();
    
} 

 