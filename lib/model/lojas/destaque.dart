
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class DestaqueLoja extends ChangeNotifier {

  String descricao, id, category, name, promocao, state, trabalheConosco, cid, lid;
  double price;
  bool destaque;
  List<String> img, imgDestacadas, imgCupons, imgOfertas;
  int pos;

  //TODO: RETORNA OFERTAS EM DESTAQUE, OFERTAS STORY, CUPONS E TRABALHE CONOSCO

  DestaqueLoja.fromDocument(DocumentSnapshot snapshot) {
    lid = snapshot.data()["lid"];
    cid = snapshot.data()["cid"];
    id = snapshot.id;
    descricao = snapshot.data()["descricao"];
    name = snapshot.data()["name"];
    price = snapshot.data()["price"] + 0.0;
    img = List<String>.from(snapshot.data()['img'] as List<dynamic>);
    imgCupons = List<String>.from(snapshot.data()['img_cupons'] as List<dynamic>);
    imgOfertas = List<String>.from(snapshot.data()['img_ofertas'] as List<dynamic>);
    imgDestacadas = List<String>.from(snapshot.data()['img_destacadas'] as List<dynamic>);
    destaque = snapshot.data()["destaque"];
    promocao = snapshot.data()["promocao"];
    pos = snapshot.data()["pos"];
    state = snapshot.data()["estado"];
    trabalheConosco = snapshot.data()["trabalheConosco"];
  }

  Map<String, dynamic> toResumedMap() {
    return {
      "lid": lid,
      "cid": cid,
      "descricao": descricao,
      "name": name,
      "price": price,
      "img": img,
      "img_destacadas": imgDestacadas,
      "img_ofertas": imgOfertas,
      "img_cupons": imgCupons,
      "destaque": destaque,
      "promocao": promocao,
      "pos": pos,
      "estado": state,
      "trabalheConosco": trabalheConosco,
    };
  }
}
