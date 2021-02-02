import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Adm extends ChangeNotifier {

  String whats;
  String id;
  String name;

  Adm.fromDocument(DocumentSnapshot document){
    id = document.id;
    whats = document.data()['whats'];
    name = document.data()['name'];
  }

  @override
  String toString() {
    return 'Adm{whats: $whats, id: $id, name: $name}';
  }
}