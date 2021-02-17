import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Banners extends ChangeNotifier {

  List img;
  String id;


  Banners.fromDocument(DocumentSnapshot document){
    id = document.id;
    img = document.data()['img'];
  }

  @override
  String toString() {
    return 'Banners{img: $img, id: $id}';
  }
}