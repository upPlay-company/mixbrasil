
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class DestaqueLoja extends ChangeNotifier {

  String id, category, name, promocao, state, trabalheConosco, cid, lid, city, number;
  double price;
  bool destaque;
  List img, imgDestacadas, imgCupons, imgOfertas;
  int pos;

  DestaqueLoja.fromDocument(DocumentSnapshot snapshot) {
    lid = snapshot.data()["lid"];
    cid = snapshot.data()["cid"];
    id = snapshot.id;
    name = snapshot.data()["name"];
    price = snapshot.data()["price"] + 0.0;
    img = snapshot.data()["img"];
    imgCupons = snapshot.data()["img_cupons"];
    imgOfertas = snapshot.data()["img_ofertas"];
    imgDestacadas = snapshot.data()["img_destacadas"];
    destaque = snapshot.data()["destaque"];
    promocao = snapshot.data()["promocao"];
    state = snapshot.data()["estado"];
    trabalheConosco = snapshot.data()["trabalheConosco"];
    city = snapshot.data()['cidade'];
    number = snapshot.data()['whatsapp'];
  }

  Map<String, dynamic> toResumedMap() {
    return {
      "lid": lid,
      "cid": cid,
      "name": name,
      "price": price,
      "img": img,
      "imgDestacadas": imgDestacadas,
      "imgOfertas": imgOfertas,
      "imgCupons": imgCupons,
      "destaque": destaque,
      "promocao": promocao,
      "pos": pos,
      "estado": state,
      "trabalheConosco": trabalheConosco,
    };
  }

  @override
  String toString() {
    return 'DestaqueLoja{ id: $id, category: $category, name: $name, promocao: $promocao, state: $state, trabalheConosco: $trabalheConosco, cid: $cid, lid: $lid, price: $price, destaque: $destaque, img: $img, imgDestacadas: $imgDestacadas, imgCupons: $imgCupons, imgOfertas: $imgOfertas, pos: $pos}';
  }
}
