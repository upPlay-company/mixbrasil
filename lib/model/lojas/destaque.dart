
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class DestaqueLoja extends ChangeNotifier {

  String descricao;
  String id;
  String cid;
  String name;
  double price;
  String lid;
  List img;
  int pos;

  //TODO: RETORNA OFERTAS EM DESTAQUE, OFERTAS STORY, CUPONS E TRABALHE CONOSCO

  DestaqueLoja.fromDocument(DocumentSnapshot snapshot) {
    id = snapshot.id;
    descricao = snapshot.data()["descricao"];
    name = snapshot.data()["name"];
    price = snapshot.data()["price"] + 0.0;
    img = snapshot.data()["img"];
    lid = snapshot.data()["lid"];
    cid = snapshot.data()["cid"];
    pos = snapshot.data()["pos"];
  }

  Map<String, dynamic> toResumedMap() {
    return {
      "descricao": descricao,
      "name": name,
      "price": price,
      "img": img,
      "lid": lid,
      "cid": cid,
      "pos": pos,
    };
  }

  @override
  String toString() {
    return 'DestaqueLoja{descricao: $descricao, id: $id, cid: $cid, name: $name, price: $price, lid: $lid, img: $img, pos: $pos}';
  }
}
