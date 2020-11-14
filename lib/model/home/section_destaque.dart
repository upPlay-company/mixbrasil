import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class Section2 extends ChangeNotifier {

  Section2({this.img}){
    img = img ?? [];
  }

  Section2.fromDocument(DocumentSnapshot document){
    id = document.documentID;
    name = document.data['name'] as String;
    titulo = document.data['subtitulo'] as String;
    price = document.data['price'] as num;
    img = List<String>.from(document.data['img'] as List<dynamic>);
  }

  final Firestore firestore = Firestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  DocumentReference get firestoreRef => firestore.document('lojas/$id');
  StorageReference get storageRef => storage.ref().child('lojas/$id');

  String name;
  String id;
  String titulo;
  num price;
  List<String> img;

}
