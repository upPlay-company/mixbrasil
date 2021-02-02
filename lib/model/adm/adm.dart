import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Adm extends ChangeNotifier {

  String whats;

  Adm.fromDocument(DocumentSnapshot document){
    whats = document.data()['whats'];
  }

  @override
  String toString() {
    return 'Adm{whats: $whats}';
  }
}