
import 'dart:convert';

import 'dart:ffi';


class Imagem {
  String id;
  String imgh_name;
  String cat_id;
  String cat_name;

  Imagem(String id, String imgh_name, String cat_id, String cat_name){
    this.id = id;  
    this.imgh_name = imgh_name;
    this.cat_id = cat_id;
    this.cat_name = cat_name;
  }

    Imagem.fromJson(Map json)
      : id = json['id'],
        imgh_name = json['imgh_name'],
        cat_id = json['cat_id'],
        cat_name = json['cat_name'];

   Map toJson() {
    return {'id': id,'imgh_name': imgh_name, 'cat_id': cat_id,'cat_name': cat_name};
  }

  static Map<String, dynamic> toMap(Imagem image) => {
      'id': image.id, 
      'imgh_name': image.imgh_name, 
      'cat_id': image.cat_id, 
      'cat_name': image.cat_name
      };

  static String encodeHotels(List<Imagem> images) => json.encode(
        images
            .map<Map<String, dynamic>>((image) => toMap(image))
            .toList(),
      );

    static List<Imagem> decodeHotels(String images) =>
      (json.decode(images) as List<dynamic>)
          .map<Imagem>((item) => Imagem.fromJson(item))
          .toList();
    
} 

 