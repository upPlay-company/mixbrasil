import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:mix_brasil/model/home/banners_itens.dart';

class Banners extends ChangeNotifier {

  List<BannersItens> img;
  String id;


  Banners.fromDocument(DocumentSnapshot document){
    id = document.id;
    img = (document.data()['itens'] as List).map((i) => BannersItens.fromMap(i as Map<String, dynamic>)).toList();
  }

  @override
  String toString() {
    return 'Banners{img: $img, id: $id}';
  }
}