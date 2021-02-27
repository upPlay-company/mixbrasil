
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:mix_brasil/model/categorias/categorias.dart';
import 'package:mix_brasil/model/cep/address.dart';
import 'package:mix_brasil/model/cep/city.dart';
import 'package:mix_brasil/model/cep/uf.dart';
import 'package:mix_brasil/model/user/user.dart';
import 'package:mix_brasil/model/user/user_manager.dart';
import 'package:uuid/uuid.dart';

enum AdStatus { PENDING, ACTIVE, SOLD, DELETE }

class AdLojas {

  AdLojas();

  String id, name, promocao, trabalheConosco, number;
  double price;
  bool destaque;
  List<dynamic> img = [];
  List<dynamic> imgDestacadas = [];
  List<dynamic> imgCupons = [];
  List<dynamic> imgOfertas = [];
  int pos;
  int views, viewsWhats;
  String idCat, idAdsUser, idUser;
  Categorias category;
  UserUser user = GetIt.I<UserManager>().user;
  Address address;
  int viewsDestaque;
  Timestamp created;
  String idAds;
  String idAdsDestaque;
  String mensagem;
  bool hideCredito;
  bool hideBoleto;
  AdStatus status = AdStatus.ACTIVE;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  Reference get storageRef =>
      storage.ref().child('imagens_lojas').child(user.id);


  AdLojas.fromDocument(DocumentSnapshot snapshot) {
    id = snapshot.id;
    name = snapshot.data()["name"];
    price = snapshot.data()["price"] + 0.0;
    img = List<String>.from(snapshot.data()['img'] as List<dynamic>);
    imgCupons = List<String>.from(snapshot.data()["img_cupons"] as List<dynamic>);
    imgOfertas = List<String>.from(snapshot.data()["img_ofertas"] as List<dynamic>);
    imgDestacadas = List<String>.from(snapshot.data()["img_destacados"] as List<dynamic>);
    destaque = snapshot.data()["destaque"];
    category = Categorias(
      id: snapshot.id,
      name: snapshot.data()['name']
    );
    user = UserUser(
        id: user.id
    );
    address = Address(
        cidade: City(name: snapshot.data()['cidade'] as String),
        uf: UF(initials: snapshot.data()['estado']as String),
        zipCode: snapshot.data()['zipCode']
    );
    promocao = snapshot.data()["promocao"];
    trabalheConosco = snapshot.data()["trabalhe_conosco"];
    number = snapshot.data()['whatsapp'];
    views = snapshot.data()['views'];
    idCat = snapshot.data()["idCat"];
    idUser = snapshot.data()['user'];
    idAdsUser = snapshot.data()['idAdsUser'];
    viewsWhats = snapshot.data()['viewsWhats'];
    status = AdStatus.values[snapshot.data()['status'] as int];
  }


  Future<void> save(AdLojas adLojas) async {
    final Map<String, dynamic> data = {
      'name': adLojas.name,
      'promocao': adLojas.promocao,
      'price': adLojas.price,
      'estado': adLojas.address.uf.initials,
      'cidade': adLojas.address.cidade.name,
      'zipCode': adLojas.address.zipCode,
      'categoria': adLojas.category.name,
      'anunciante': adLojas.user.name,
      'number': adLojas.number,
      'views': adLojas.views = 0,
      'viewsDestaque': adLojas.viewsDestaque = 0,
      'created': FieldValue.serverTimestamp(),
      'status': adLojas.status.index,
      'user': adLojas.user.id,
      'destaque': adLojas.destaque = false,
      'trabalhe_conosco': adLojas.trabalheConosco
    };

    if(id == null){

      final doc = await FirebaseFirestore.instance
          .collection('categorias')
          .doc(adLojas.category.id)
          .collection('lojas')
          .add(data);

      final docUser = await FirebaseFirestore.instance
          .collection('users')
          .doc(adLojas.user.id)
          .collection('lojas')
          .add(data);

      final List<String> uploadImgCapa = [];

      for (final image in adLojas.img) {
        if (image as File != null) {
          final UploadTask task =
          storageRef.child(Uuid().v1()).putFile(image);
          final TaskSnapshot snapshot = await task;
          final String url = await snapshot.ref.getDownloadURL();
          uploadImgCapa.add(url);
        }
      }

      final List<String> uploadImgOfertas = [];

      for (final image in adLojas.imgDestacadas) {
        if (image as File != null) {
          final UploadTask task =
          storageRef.child(Uuid().v1()).putFile(image);
          final TaskSnapshot snapshot = await task;
          final String url = await snapshot.ref.getDownloadURL();
          uploadImgOfertas.add(url);
        }
      }

      final List<String> uploadImgStory = [];

      for (final image in adLojas.imgOfertas) {
        if (image as File != null) {
          final UploadTask task =
          storageRef.child(Uuid().v1()).putFile(image);
          final TaskSnapshot snapshot = await task;
          final String url = await snapshot.ref.getDownloadURL();
          uploadImgStory.add(url);
        }
      }

      final List<String> uploadImgCupons = [];

      for (final image in adLojas.imgCupons) {
        if (image as File != null) {
          final UploadTask task =
          storageRef.child(Uuid().v1()).putFile(image);
          final TaskSnapshot snapshot = await task;
          final String url = await snapshot.ref.getDownloadURL();
          uploadImgCupons.add(url);
        }
      }

      DocumentReference firestoreRef = firestore
          .collection('categorias')
          .doc(adLojas.category.id)
          .collection('lojas')
          .doc(doc.id);

      DocumentReference firestoreRefUser = firestore
          .collection('users')
          .doc(adLojas.user.id)
          .collection('lojas')
          .doc(docUser.id);

      await firestoreRef.update({
        'img': uploadImgCapa,
        'img_destacados': uploadImgOfertas,
        'img_ofertas': uploadImgStory,
        'img_cupons': uploadImgCupons,
        'idAdsUser': docUser.id,
        'idCat': adLojas.category.id
      });
      adLojas.img = uploadImgCapa;
      adLojas.imgDestacadas = uploadImgOfertas;
      adLojas.imgOfertas = uploadImgStory;
      adLojas.imgCupons = uploadImgCupons;

      await firestoreRefUser.update(
          {'img': uploadImgCapa,
            'img_destacados': uploadImgOfertas,
            'img_ofertas': uploadImgStory,
            'img_cupons': uploadImgCupons,
            'idAds': doc.id,
            'idCat': adLojas.category.id
          });
      adLojas.img = uploadImgCapa;
      adLojas.imgDestacadas = uploadImgOfertas;
      adLojas.imgOfertas = uploadImgStory;
      adLojas.imgCupons = uploadImgCupons;
    }
    else {

    }

}



  @override
  String toString() {
    return 'LojasData{id: $id, category: $category, name: $name, promocao: $promocao, trabalheConosco: $trabalheConosco, number: $number, price: $price, destaque: $destaque, img: $img, imgDestacadas: $imgDestacadas, imgCupons: $imgCupons, imgOfertas: $imgOfertas, pos: $pos, views: $views, viewsWhats: $viewsWhats, idCat: $idCat, idAdsUser: $idAdsUser, idUser: $idUser}';
  }
}
