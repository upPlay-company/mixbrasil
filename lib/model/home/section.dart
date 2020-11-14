import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class Section extends ChangeNotifier {

  Section({this.img}){
    img = img ?? [];
  }

  Section.fromDocument(DocumentSnapshot document){
    id = document.documentID;
    name = document.data['name'] as String;
    type = document.data['type'] as String;
    img = List<String>.from(document.data['img'] as List<dynamic>);
    titulo = List<String>.from(document.data['titulo'] as List<dynamic>);
  }

  final Firestore firestore = Firestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  DocumentReference get firestoreRef => firestore.document('home/$id');
  StorageReference get storageRef => storage.ref().child('home/$id');

  String name;
  String id;
  String type;
  List<String> img;
  List<String> titulo;

}
