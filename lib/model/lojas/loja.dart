import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class LojasData extends ChangeNotifier {

  String descricao, id, category, name, promocao, state, trabalheConosco, city, number;
  double price;
  bool destaque;
  List img, imgDestacadas, imgCupons, imgOfertas;
  int pos;
  

  LojasData.fromDocument(DocumentSnapshot snapshot) {
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
    city = snapshot.data()['cidade'];
    number = snapshot.data()['whatsapp'];
  }

  Map<String, dynamic> toResumedMap() {
    return {
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
    return 'LojasData{descricao: $descricao, id: $id, category: $category, name: $name, promocao: $promocao, state: $state, trabalheConosco: $trabalheConosco, price: $price, destaque: $destaque, img: $img, imgDestacadas: $imgDestacadas, imgCupons: $imgCupons, imgOfertas: $imgOfertas, pos: $pos}';
  }
}
