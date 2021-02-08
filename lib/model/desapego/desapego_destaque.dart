import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class DesapegoDestaque extends ChangeNotifier {
  DesapegoDestaque.fromDocument(DocumentSnapshot document) {
    id = document.id;
    name = document.data()['name'] as String;
    descricao = document.data()['descricao'] as String;
    number = document.data()['number'] as String;
    estado = document.data()['estado'] as String;
    cidade = document.data()['cidade'] as String;
    price = document.data()['price'] as double;
    img = List<String>.from(document.data()['img'] as List<dynamic>);
    viewsDestaque = document.data()['viewsDestaque'];
    idCat = document.data()["idCat"];
    idUser = document.data()['user'];
    idAdsUser = document.data()['idAdsUser'];
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  DocumentReference get firestoreRef => firestore.doc('destaque_desapego/$id');

  get storageRef => storage.ref().child('destaque_desapego/$id');

  String descricao;
  String id;
  String category;
  String name;
  double price;
  bool destaque;
  List img;
  int pos;
  String promocao;
  String cidade;
  String anunciante;
  String estado;
  String number;
  int viewsDestaque;
  String idCat;
  String idUser;
  String idAdsUser;
}
