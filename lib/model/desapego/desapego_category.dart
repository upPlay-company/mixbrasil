import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class DesapegoCategory extends ChangeNotifier {

  String name;
  String id;
  String img;

  DesapegoCategory({this.name, this.id});

  DesapegoCategory.fromDocument(DocumentSnapshot document){
    id = document.id;
    name = document.data()['name'] as String;
    img = document.data()['image'] as String;
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  @override
  String toString() {
    return 'DesapegoCategory{name: $name, id: $id, img: $img}';
  }
}
