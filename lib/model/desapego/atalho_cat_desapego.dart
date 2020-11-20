import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class AtalhoCatDesapego extends ChangeNotifier {

  AtalhoCatDesapego.fromDocument(DocumentSnapshot document){
    id = document.id;
    name = document.data()['name'] as String;
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  DocumentReference get firestoreRef => firestore.doc('desapego/$id');
  //StorageReference get storageRef => storage.ref().child('desapego/$id');

  String id;
  String name;


}
