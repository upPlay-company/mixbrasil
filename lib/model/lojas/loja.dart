import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:mix_brasil/model/categorias/categorias.dart';

class Lojas extends ChangeNotifier {

  Lojas({this.img}){
    img = img ?? [];
  }

  Categorias categorias;

  Lojas.fromDocument(DocumentSnapshot document){
    id = document.id;
    categoriaId = document.data()['category'] as String;
    name = document.data()['name'] as String;
    titulo = document.data()['subtitulo'] as String;
    price = document.data()['price'] as num;
    img = List<String>.from(document.data()['img'] as List<dynamic>);
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  DocumentReference get firestoreRef => firestore.doc('lojas/$id');
  //StorageReference get storageRef => storage.ref().child('lojas/$id');


  String id;
  String name;
  String categoriaId;
  String titulo;
  num price;
  List<String> img;

}
