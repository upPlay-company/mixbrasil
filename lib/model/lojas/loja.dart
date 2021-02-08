import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class LojasData extends ChangeNotifier {

  String id, category, name, promocao, state, trabalheConosco, city, number;
  double price;
  bool destaque;
  List img, imgDestacadas, imgCupons, imgOfertas;
  int pos;
  int views, viewsWhats;
  String idCat, idAdsUser, idUser;
  

  LojasData.fromDocument(DocumentSnapshot snapshot) {
    id = snapshot.id;
    name = snapshot.data()["name"];
    price = snapshot.data()["price"] + 0.0;
    img = snapshot.data()["img"];
    imgCupons = snapshot.data()["img_cupons"];
    imgOfertas = snapshot.data()["img_ofertas"];
    imgDestacadas = snapshot.data()["img_destacados"];
    destaque = snapshot.data()["destaque"];
    promocao = snapshot.data()["promocao"];
    pos = snapshot.data()["pos"];
    state = snapshot.data()["estado"];
    trabalheConosco = snapshot.data()["trabalhe_conosco"];
    city = snapshot.data()['cidade'];
    number = snapshot.data()['whatsapp'];
    views = snapshot.data()['views'];
    idCat = snapshot.data()["idCat"];
    idUser = snapshot.data()['user'];
    idAdsUser = snapshot.data()['idAdsUser'];
    viewsWhats = snapshot.data()['viewsWhats'];
  }

  Map<String, dynamic> toResumedMap() {
    return {
      "name": name,
      "price": price,
      "img": img,
      "imgDestacados": imgDestacadas,
      "imgOfertas": imgOfertas,
      "imgCupons": imgCupons,
      "destaque": destaque,
      "promocao": promocao,
      "pos": pos,
      "estado": state,
      "trabalhe_conosco": trabalheConosco,
    };
  }
}
