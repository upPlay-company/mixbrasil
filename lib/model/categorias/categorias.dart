import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class Categorias extends ChangeNotifier {

  Categorias({this.name}){
    name = name ?? [];
    img = img ?? [];
  }

  Categorias.fromDocument(DocumentSnapshot document){
    id = document.id;
    name = document.data()['name'] as String;
    img = document.data()['image'] as String;
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  DocumentReference get firestoreRef => firestore.doc('home/$id');
  //StorageReference get storageRef => storage.ref().child('home/$id');


  String name;
  String id;
  String img;
}
