import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DesapegoDestaque {
  DesapegoDestaque.fromDocument(DocumentSnapshot document) {
    id = document.id;
    name = document.data()['name'] as String;
    descricao = document.data()['descricao'] as String;
    number = document.data()['number'] as String;
    estado = document.data()['estado'] as String;
    cidade = document.data()['cidade'] as String;
    district = document.data()['bairro'] as String;
    price = document.data()['price'] as double;
    img = List<String>.from(document.data()['img'] as List<dynamic>);
    idCat = document.data()["idCat"];
    idUser = document.data()['user'];
    idAdsUser = document.data()['idAdsUser'];
    anunciante = document.data()['anunciante'];
    created = document.data()['created'];
    views = document.data()['viewsDestaque'];
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
  String district;
  String anunciante;
  String estado;
  String number;
  int views;
  String idCat;
  String idUser;
  String idAdsUser;
  Timestamp created;
}
