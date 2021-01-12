import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class LojasData extends ChangeNotifier {

  String descricao, id, category, name, promocao, state;
  double price;
  bool destaque;
  List img;
  int pos;

  //TODO: RETORNA OFERTAS EM DESTAQUE, OFERTAS STORY, CUPONS E TRABALHE CONOSCO

  LojasData.fromDocument(DocumentSnapshot snapshot) {
    id = snapshot.id;
    descricao = snapshot.data()["descricao"];
    name = snapshot.data()["name"];
    price = snapshot.data()["price"] + 0.0;
    img = snapshot.data()["img"];
    destaque = snapshot.data()["destaque"];
    promocao = snapshot.data()["promocao"];
    pos = snapshot.data()["pos"];
    state = snapshot.data()["estado"];
  }

  Map<String, dynamic> toResumedMap() {
    return {
      "descricao": descricao,
      "name": name,
      "price": price,
      "img": img,
      "destaque": destaque,
      "promocao": promocao,
      "pos": pos,
      "estado": state
    };
  }

  @override
  String toString() {
    return 'LojasData{descricao: $descricao, id: $id, category: $category, name: $name, price: $price, destaque: $destaque, img: $img, pos: $pos, promocao: $promocao, state: $state}';
  }
}
