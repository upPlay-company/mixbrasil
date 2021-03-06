import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:mix_brasil/model/anuncio/ad.dart';
import 'package:mix_brasil/model/desapego/user_favorite.dart';
import 'package:mix_brasil/model/user/user.dart';
import 'package:mix_brasil/model/user/user_manager.dart';

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
  String district;
  String anunciante;
  String estado;
  String number;
  int views;
  String idCat;
  String idUser;
  String idAdsUser;
  AdStatus status;
  FavoriteUser favoriteUser;
  String idAds;
  Timestamp created;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final UserManager userManager = GetIt.I<UserManager>();

  FavoriteUser favorite;

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
    district = snapshot.data()['bairro'];
    pos = snapshot.data()["pos"];
    number = snapshot.data()["number"];
    anunciante = snapshot.data()["anunciante"];
    views = snapshot.data()['views'];
    idCat = snapshot.data()["idCat"];
    idUser = snapshot.data()['user'];
    idAdsUser = snapshot.data()['idAdsUser'];
    if (snapshot.data().containsKey('status')) {
      status = AdStatus.values[snapshot.data()['status'] as int];
    }
    if (userManager.isLoggedIn &&
        snapshot.data().containsKey(userManager.user.id)) {
      favoriteUser = FavoriteUser.fromMap(
          snapshot.data()[userManager.user.id] as Map<String, dynamic>);
    }
    idAds = snapshot.data()['idAds'];
    created = snapshot.data()['created'];
  }

  Future<void> save({DesapegoData desapego, UserUser user}) async {
      final Map<String, dynamic> data = {
        'idAds': desapego.id,
        'name': desapego.name,
        'descricao': desapego.descricao,
        'img': desapego.img,
        'price': desapego.price,
        'estado': desapego.estado,
        'cidade': desapego.cidade,
        'categoria': desapego.category,
        'anunciante': user.name,
        'number': user.phone,
        'created': FieldValue.serverTimestamp(),
        'status': desapego.status.index,
        'user': user.id,
      };

      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.id)
          .collection('favoritos')
          .add(data);

      DocumentReference firestoreRef = firestore
          .collection('desapego')
          .doc(desapego.idCat)
          .collection('desapegos')
          .doc(desapego.id);

      await firestoreRef.update({user.id: {'favoriteId': doc.id}});
  }

  Future<void> delete({DesapegoData desapego, UserUser user}) async {
    try {
      DocumentReference firestoreRefUser = firestore
          .collection('users')
          .doc(user.id)
          .collection('favoritos')
          .doc(desapego.favoriteUser.favoriteId);

      await firestoreRefUser.delete();
    } catch (e) {
      Future.error('Falhar ao deleta favorito!');
    }
  }

  Future<void> deleteFavorite({DesapegoData desapego, UserUser user}) async {
    try {
      DocumentReference firestoreRefUser = firestore
          .collection('users')
          .doc(user.id)
          .collection('favoritos')
          .doc(desapego.id);

      await firestoreRefUser.delete();
    } catch (e) {
      Future.error('Falhar ao deleta favorito!');
    }
  }

  @override
  String toString() {
    return 'LojasData{descricao: $descricao, id: $id, category: $category, name: $name, price: $price, destaque: $destaque, img: $img, pos: $pos, promocao: $promocao, estado: $estado, cidade: $cidade}';
  }
}