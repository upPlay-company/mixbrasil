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
    cidade = document.data()['estado'] as String;
    price = document.data()['price'] as double;
    img = List<String>.from(document.data()['img'] as List<dynamic>);
    cid = document.data()['cid'] as String;
    did = document.data()['did'] as String;
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  DocumentReference get firestoreRef => firestore.doc('destaque_desapego/$id');

  get storageRef => storage.ref().child('destaque_desapego/$id');

  String estado, cidade, descricao, name, id, number, cid, did;
  List<String> img;
  double price;

  Map<String, dynamic> toResumedMap() {
    return {
      "descricao": descricao,
      "name": name,
      "cidade": cidade,
      "estado": estado,
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
        'cidade: $cidade, '
        'estado: $estado, '
        'img: $img, '
        'price: $price, '
        'cid: $cid, '
        'did: $did}';
  }
}
