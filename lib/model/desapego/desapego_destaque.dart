import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class DesapegoDestaque extends ChangeNotifier {

  DesapegoDestaque.fromDocument(DocumentSnapshot document){
    id = document.id;
    name = document.data()['name'] as String;
    descricao = document.data()['descricao'] as String;
    number = document.data()['number'] as String;
    price = document.data()['price'] as double;
    img = List<String>.from(document.data()['img'] as List<dynamic>);
    cid = document.data()['cid'] as String;
    did = document.data()['did'] as String;
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  DocumentReference get firestoreRef => firestore.doc('destaque_desapego/$id');
  get storageRef => storage.ref().child('destaque_desapego/$id');

  String id;
  String name;
  String descricao;
  String number;
  List<String> img;
  double price;
  String cid;
  String did;

  Map<String, dynamic> toResumedMap() {
    return {
      "descricao": descricao,
      "name": name,
      "price": price,
      "img": img,
      "cid": cid,
      "did": did,
    };
  }

  @override
  String toString() {
    return 'DesapegoDestaque{'
        'id: $id, '
        'name: $name, '
        'descricao: $descricao, '
        'number: $number, '
        'img: $img, '
        'price: $price, '
        'cid: $cid, '
        'did: $did}';
  }
}