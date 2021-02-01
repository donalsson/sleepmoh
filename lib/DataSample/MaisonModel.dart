
import 'dart:convert';

import 'dart:ffi';


class MaisonMod {
  String id;
  String nombredouche;
  String typemaison;  
  String typefr;
  String typeen;
  String nbrechambre;
  String nbresalon;
  String nbrecuisine;
  String type;
  String prix;
  String superficie;
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

  MaisonMod(double note,String typefr ,String typeen, double ln, double lat , double nombreetoile, String id, String nombredouche ,String typemaison ,String nbrechambre ,String nbresalon ,String nbrecuisine ,String imgh , String localisation, String imghotel , String type, String prix, String superficie, String taille, String capacite, String description, String etat, String iduser, String created, String modified, String descrip, String nom, String notefr, String noteen, String accesfr, String accesen, String standingfr, String standingen, String securitefr, String securiteen){
    this.id = id;
    this.ln = ln;
    this.lat = lat;    
    this.note = note;    
    this.nombreetoile = nombreetoile;
    this.nombredouche = nombredouche;
    this.nbresalon = nbresalon;
    this.nbrecuisine = nbrecuisine;
    this.typemaison = typemaison;
    this.nbrechambre = nbrechambre;
    this.imgh = imgh;
     this.localisation = id;
    this.imghotel = imghotel;
    this.typefr = typefr;
    this.typeen = typeen;
    this.type = type;
    this.prix = prix;
    this.superficie = superficie;
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

    MaisonMod.fromJson(Map json)
      : id = json['id'],
        nombredouche = json['nombredouche'],
        typemaison = json['typemaison'],
        nbrechambre = json['nbrechambre'],
        nbresalon = json['nbresalon'],
        nbrecuisine = json['nbrecuisine'],
        imgh = json['imgh'],
        ln = json['ln'],
        lat = json['lat'],        
        note = json['note'],        
        nombreetoile = json['nombreetoile'],
        type = json['type'],
        prix = json['prix'],        
        imghotel = json['avatar'],
        localisation = json['localisation'],
        superficie = json['superficie'],
        taille = json['taille'],
        typefr = json['typefr'],
        typeen = json['typeen'],
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
    return {'ln': ln, 'lat': lat, 'typefr': typefr, 'typeen': typefr, 'note': note, 'id': id,'nombreetoile': nombreetoile, 'imghotel': imghotel,'localisation': localisation, 'nombredouche': nombredouche, 'typemaison': typemaison, 'nbrechambre': typemaison, 'nbresalon': nbresalon, 'nbrecuisine': nbrecuisine,'imgh': imgh, 'type': type, 'prix': prix, 'superficie': superficie, 'taille': taille, 'capacite': capacite, 'description': description, 'etat': etat, 'iduser': iduser, 'created': created, 'modified': modified, 'descrip': descrip, 'nom': nom, 'notefr': notefr, 'noteen': noteen, 'accesen': accesen, 'accesfr': accesfr, 'standingfr': standingfr, 'standingen': standingen, 'securitefr': securitefr, 'securiteen': securiteen};
  }

  static Map<String, dynamic> toMap(MaisonMod herbergement) => {
      'id': herbergement.id, 
      'nombredouche': herbergement.nombredouche, 
      'typemaison': herbergement.typemaison, 
      'nbrechambre': herbergement.nbrechambre,
      'nbresalon': herbergement.nbresalon, 
      'nbrecuisine': herbergement.nbrecuisine,
      'typefr': herbergement.typefr, 
      'typeen': herbergement.typeen, 
      'ln': herbergement.ln, 
      'lat': herbergement.lat, 
      'note': herbergement.note, 
      'imgh': herbergement.imgh, 
      'nombreetoile': herbergement.nombreetoile, 
      'imghotel': herbergement.imghotel, 
      'localisation': herbergement.localisation, 
      'type': herbergement.type, 
      'prix': herbergement.prix, 
      'superficie': herbergement.superficie, 
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

  static String encodeHotels(List<MaisonMod> hotelhts) => json.encode(
        hotelhts
            .map<Map<String, dynamic>>((hotelht) => toMap(hotelht))
            .toList(),
      );

    static List<MaisonMod> decodeHotels(String hotelhts) =>
      (json.decode(hotelhts) as List<dynamic>)
          .map<MaisonMod>((item) => MaisonMod.fromJson(item))
          .toList();
    
} 

 