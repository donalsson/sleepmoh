
import 'dart:convert';

import 'dart:ffi';


class TerrainMod {
  String id;
  String superficiet;
  String typefr;
  String typeen;
  String perifr;
  String perien;
  String type;
  String prixt;
  String periode;
  String taille;
  String capacite;
  String descriptiont;
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
  String telephone;
  String nom;
  double ln;
  double note;
  double lat;

  TerrainMod(double note, double ln, double lat , String telephone, String id, String superficiet ,String typefr ,String typeen ,String perifr ,String perien ,String imgh , String localisation, String imghotel , String type, String prixt, String periode, String taille, String capacite, String descriptiont, String etat, String iduser, String created, String modified, String descrip, String nom, String notefr, String noteen, String accesfr, String accesen, String standingfr, String standingen, String securitefr, String securiteen){
    this.id = id;
    this.ln = ln;
    this.lat = lat;    
    this.note = note;    
    this.telephone = telephone;
    this.superficiet = superficiet;
    this.perifr = perifr;
    this.perien = perien;
    this.typefr = typefr;
    this.typeen = typeen;
    this.imgh = imgh;
     this.localisation = id;
    this.imghotel = imghotel;
    this.type = type;
    this.prixt = prixt;
    this.periode = periode;
    this.taille = taille;
    this.capacite = capacite;
    this.descriptiont = descriptiont;
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

    TerrainMod.fromJson(Map json)
      : id = json['id'],
        superficiet = json['superficiet'],
        typefr = json['typefr'],
        typeen = json['typeen'],
        perifr = json['perifr'],
        perien = json['perien'],
        imgh = json['imgh'],
        ln = json['ln'],
        lat = json['lat'],        
        note = json['note'],        
        telephone = json['telephone'],
        type = json['type'],
        prixt = json['prixt'],        
        imghotel = json['avatar'],
        localisation = json['localisation'],
        periode = json['periode'],
        taille = json['taille'],
        capacite = json['capacite'],
        descriptiont = json['descriptiont'],
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
    return {'ln': ln, 'lat': lat, 'note': note, 'id': id,'telephone': telephone, 'imghotel': imghotel,'localisation': localisation, 'superficiet': superficiet, 'typefr': typefr, 'typeen': typefr, 'perifr': perifr, 'perien': perien,'imgh': imgh, 'type': type, 'prixt': prixt, 'periode': periode, 'taille': taille, 'capacite': capacite, 'descriptiont': descriptiont, 'etat': etat, 'iduser': iduser, 'created': created, 'modified': modified, 'descrip': descrip, 'nom': nom, 'notefr': notefr, 'noteen': noteen, 'accesen': accesen, 'accesfr': accesfr, 'standingfr': standingfr, 'standingen': standingen, 'securitefr': securitefr, 'securiteen': securiteen};
  }

  static Map<String, dynamic> toMap(TerrainMod herbergement) => {
      'id': herbergement.id, 
      'superficiet': herbergement.superficiet, 
      'typefr': herbergement.typefr, 
      'typeen': herbergement.typeen,
      'perifr': herbergement.perifr, 
      'perien': herbergement.perien, 
      'ln': herbergement.ln,
      'lat': herbergement.lat, 
      'note': herbergement.note, 
      'imgh': herbergement.imgh, 
      'telephone': herbergement.telephone, 
      'imghotel': herbergement.imghotel, 
      'localisation': herbergement.localisation, 
      'type': herbergement.type, 
      'prixt': herbergement.prixt, 
      'periode': herbergement.periode, 
      'taille': herbergement.taille, 
      'capacite': herbergement.capacite, 
      'descriptiont': herbergement.descriptiont, 
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

  static String encodeHotels(List<TerrainMod> hotelhts) => json.encode(
        hotelhts
            .map<Map<String, dynamic>>((hotelht) => toMap(hotelht))
            .toList(),
      );

    static List<TerrainMod> decodeHotels(String hotelhts) =>
      (json.decode(hotelhts) as List<dynamic>)
          .map<TerrainMod>((item) => TerrainMod.fromJson(item))
          .toList();
    
} 

 