
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class DestaqueLoja extends ChangeNotifier {

  String descricao, id, category, name, promocao, state, trabalheConosco, cid, lid;
  double price;
  bool destaque;
  List img, imgDestacadas, imgCupons, imgOfertas;
  int pos;

  //TODO: RETORNA OFERTAS EM DESTAQUE, OFERTAS STORY, CUPONS E TRABALHE CONOSCO

  DestaqueLoja.fromDocument(DocumentSnapshot snapshot) {
    lid = snapshot.data()["lid"];
    cid = snapshot.data()["cid"];
    id = snapshot.id;
    descricao = snapshot.data()["descricao"];
    name = snapshot.data()["name"];
    price = snapshot.data()["price"] + 0.0;
    img = snapshot.data()["img"];
    imgCupons = snapshot.data()["img_cupons"];
    imgOfertas = snapshot.data()["img_ofertas"];
    imgDestacadas = snapshot.data()["img_destacadas"];
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
    return 'DestaqueLoja{descricao: $descricao, id: $id, category: $category, name: $name, promocao: $promocao, state: $state, trabalheConosco: $trabalheConosco, cid: $cid, lid: $lid, price: $price, destaque: $destaque, img: $img, imgDestacadas: $imgDestacadas, imgCupons: $imgCupons, imgOfertas: $imgOfertas, pos: $pos}';
  }
}
