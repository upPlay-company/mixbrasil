import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class DesapegoData extends ChangeNotifier {

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

  DesapegoData.fromDocument(DocumentSnapshot snapshot) {
    id = snapshot.id;
    descricao = snapshot.data()["descricao"];
    name = snapshot.data()["name"];
    price = snapshot.data()["price"] + 0.0;
    img = snapshot.data()["img"];
    destaque = snapshot.data()["destaque"];
    promocao = snapshot.data()["promocao"];
    estado = snapshot.data()["estado"];
    cidade = snapshot.data()["cidade"];
    pos = snapshot.data()["pos"];
    number = snapshot.data()["number"];
    anunciante = snapshot.data()["anunciante"];
  }

  Map<String, dynamic> toResumedMap() {
    return {
      "descricao": descricao,
      "name": name,
      "price": price,
      "img": img,
      "destaque": destaque,
      "promocao": promocao,
      "cidade": cidade,
      "estado": estado,
      "pos": pos,
      "anunciante": anunciante,
    };
  }

  @override
  String toString() {
    return 'LojasData{descricao: $descricao, id: $id, category: $category, name: $name, price: $price, destaque: $destaque, img: $img, pos: $pos, promocao: $promocao, estado: $estado, cidade: $cidade}';
  }
}
