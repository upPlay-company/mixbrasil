
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:mix_brasil/model/categorias/categorias.dart';
import 'package:mix_brasil/model/cep/address.dart';
import 'package:mix_brasil/model/cep/city.dart';
import 'package:mix_brasil/model/cep/uf.dart';
import 'package:mix_brasil/model/user/user.dart';
import 'package:mix_brasil/stores/user_manager_store.dart';
import 'package:uuid/uuid.dart';

enum AdStatus { PENDING, ACTIVE, SOLD, DELETE }

class AdLojas {

  AdLojas();

  String id, name, promocao, trabalheConosco, number;
  double price;
  String cpfCnpj;
  bool destaque;
  List<dynamic> img = [];
  List<dynamic> imgDestacadas = [];
  List<dynamic> imgCupons = [];
  List<dynamic> imgOfertas = [];
  int pos;
  int views, viewsWhats;
  int viewsWhatsDestaque;
  String idCat, idAdsUser, idUser;
  Categorias category;
  UserUser user = GetIt.I<UserManagerStore>().user;
  Address address;
  int viewsDestaque;
  Timestamp created;
  String idAds;
  String idAdsDestaque;
  String mensagem;
  String hidePag;
  AdStatus status = AdStatus.ACTIVE;
  int solicitacao;

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
      name: snapshot.data()['categoria']
    );
    user = UserUser(
        id: user.id
    );
    address = Address(
        cidade: City(name: snapshot.data()['cidade'] as String),
        uf: UF(initials: snapshot.data()['estado']as String),
        zipCode: snapshot.data()['zipCode'],
        district: snapshot.data()['bairro']
    );
    promocao = snapshot.data()["promocao"];
    trabalheConosco = snapshot.data()["trabalhe_conosco"];
    number = snapshot.data()['number'];
    views = snapshot.data()['views'];
    idCat = snapshot.data()["idCat"];
    idUser = snapshot.data()['user'];
    idAdsUser = snapshot.data()['idAdsUser'];
    viewsWhats = snapshot.data()['viewsWhats'];
    viewsDestaque = snapshot.data()['viewsDestaque'];
    viewsWhatsDestaque = snapshot.data()['viewsWhatsDestaque'];
    status = AdStatus.values[snapshot.data()['status'] as int];
    idAds = snapshot.data()['idAds'];
    solicitacao = snapshot.data()['solicitacao'] as int;
    cpfCnpj = snapshot.data()['cpf_cnpj'];
  }


  Future<void> save(AdLojas adLojas) async {
    try {
      final Map<String, dynamic> data = {
        'name': adLojas.name,
        'promocao': adLojas.promocao,
        'price': adLojas.price,
        'estado': adLojas.address.uf.initials,
        'cidade': adLojas.address.cidade.name,
        'bairro': adLojas.address.district,
        'zipCode': adLojas.address.zipCode,
        'categoria': adLojas.category.name,
        'anunciante': adLojas.user.name,
        'number': adLojas.number,
        'views': adLojas.views = 0,
        'viewsDestaque': adLojas.viewsDestaque = 0,
        'viewsWhatsDestaque': adLojas.viewsWhatsDestaque = 0,
        'viewsWhats': adLojas.viewsWhats = 0,
        'created': FieldValue.serverTimestamp(),
        'status': adLojas.status.index,
        'user': adLojas.user.id,
        'destaque': adLojas.destaque = false,
        'trabalhe_conosco': adLojas.trabalheConosco,
        'solicitacao': adLojas.solicitacao = 0,
        'cpf_cnpj': adLojas.cpfCnpj
      };

      if (adLojas.id == null) {
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
        DocumentReference firestoreRef = firestore
            .collection('users')
            .doc(adLojas.user.id)
            .collection('lojas')
            .doc(adLojas.id);

        DocumentReference firestoreRefAds = firestore
            .collection('categorias')
            .doc(adLojas.idCat)
            .collection('lojas')
            .doc(adLojas.idAds);

        final List<String> uploadImgCapa = [];

        for (final image in adLojas.img) {
          if (image is File) {
            final UploadTask task =
            storageRef.child(Uuid().v1()).putFile(image);
            final TaskSnapshot snapshot = await task;
            final String url = await snapshot.ref.getDownloadURL();
            uploadImgCapa.add(url);
          } else if (adLojas.img.contains(image)) {
            uploadImgCapa.add(image as String);
          }
        }

        for (final image in adLojas.img) {
          if (!adLojas.img.contains(image)) {
            try {
              final ref = storage.refFromURL(image);
              await ref.delete();
            } catch (e) {
              debugPrint('Falha ao deletar $image');
            }
          }
        }

        final List<String> uploadImgOfertas = [];

        for (final image in adLojas.imgDestacadas) {
          if (image is File) {
            final UploadTask task =
            storageRef.child(Uuid().v1()).putFile(image);
            final TaskSnapshot snapshot = await task;
            final String url = await snapshot.ref.getDownloadURL();
            uploadImgOfertas.add(url);
          } else if (adLojas.imgDestacadas.contains(image)) {
            uploadImgOfertas.add(image as String);
          }
        }

        for (final image in adLojas.imgDestacadas) {
          if (!adLojas.imgDestacadas.contains(image)) {
            try {
              final ref = storage.refFromURL(image);
              await ref.delete();
            } catch (e) {
              debugPrint('Falha ao deletar $image');
            }
          }
        }

        final List<String> uploadImgStory = [];

        for (final image in adLojas.imgOfertas) {
          if (image is File) {
            final UploadTask task =
            storageRef.child(Uuid().v1()).putFile(image);
            final TaskSnapshot snapshot = await task;
            final String url = await snapshot.ref.getDownloadURL();
            uploadImgStory.add(url);
          } else if (adLojas.imgOfertas.contains(image)) {
            uploadImgStory.add(image as String);
          }
        }

        for (final image in adLojas.imgOfertas) {
          if (!adLojas.imgOfertas.contains(image)) {
            try {
              final ref = storage.refFromURL(image);
              await ref.delete();
            } catch (e) {
              debugPrint('Falha ao deletar $image');
            }
          }
        }

        final List<String> uploadImgCupons = [];

        for (final image in adLojas.imgCupons) {
          if (image is File) {
            final UploadTask task =
            storageRef.child(Uuid().v1()).putFile(image);
            final TaskSnapshot snapshot = await task;
            final String url = await snapshot.ref.getDownloadURL();
            uploadImgCupons.add(url);
          } else if (adLojas.imgCupons.contains(image)) {
            uploadImgCupons.add(image as String);
          }
        }

        for (final image in adLojas.imgCupons) {
          if (!adLojas.imgCupons.contains(image)) {
            try {
              final ref = storage.refFromURL(image);
              await ref.delete();
            } catch (e) {
              debugPrint('Falha ao deletar $image');
            }
          }
        }

        await firestoreRef.update({'img': uploadImgCapa,
          'img_destacados': uploadImgOfertas,
          'img_ofertas': uploadImgStory,
          'img_cupons': uploadImgCupons,
        });
        adLojas.img = uploadImgCapa;
        adLojas.imgDestacadas = uploadImgOfertas;
        adLojas.imgOfertas = uploadImgStory;
        adLojas.imgCupons = uploadImgCupons;

        await firestoreRefAds.update({'img': uploadImgCapa,
          'img_destacados': uploadImgOfertas,
          'img_ofertas': uploadImgStory,
          'img_cupons': uploadImgCupons,
        });
        adLojas.img = uploadImgCapa;
        adLojas.imgDestacadas = uploadImgOfertas;
        adLojas.imgOfertas = uploadImgStory;
        adLojas.imgCupons = uploadImgCupons;

        await firestoreRef.update(data);
        await firestoreRefAds.update(data);
      }
    } catch (e){
      Future.error('Falha ao salvar lojas');
    }
}

  Future<void> delete(AdLojas adLojas) async {
    DocumentReference firestoreRef = firestore
        .collection('users')
        .doc(adLojas.user.id)
        .collection('lojas')
        .doc(adLojas.id);

    DocumentReference firestoreRefAds = firestore
        .collection('categorias')
        .doc(adLojas.idCat)
        .collection('lojas')
        .doc(adLojas.idAds);

    DocumentReference firestoreRefDestaque = firestore
        .collection('destaque_desapego')
        .doc(adLojas.idAdsDestaque);

    await firestoreRef.delete();
    await firestoreRefAds.delete();
    await firestoreRefDestaque.delete();
  }

  Future<void> destacar(AdLojas adLojas) async {
    final Map<String, dynamic> data = {
      'name': adLojas.name,
      'estado': adLojas.address.uf.initials,
      'cidade': adLojas.address.cidade.name,
      'zipCode': adLojas.address.zipCode,
      'categoria': adLojas.category.name,
      'anunciante': user.name,
      'number': user.phone,
      'email': user.email,
      'created': FieldValue.serverTimestamp(),
      'user': adLojas.user.id,
      'idAds': adLojas.idAds,
      'img': adLojas.img,
      'img_destacados': adLojas.imgDestacadas,
      'img_ofertas': adLojas.imgOfertas,
      'img_cupons': adLojas.imgCupons,
      'destaque': adLojas.destaque = false,
      'mensagem': adLojas.mensagem = 'Quero destarcar minha Loja!',
      'idCat': adLojas.idCat,
      'pagamento': adLojas.hidePag,
    };

    FirebaseFirestore.instance.collection('msg_destaca_loja').add(data);

    DocumentReference firestoreRef = firestore
        .collection('users')
        .doc(adLojas.user.id)
        .collection('lojas')
        .doc(adLojas.id);

    await firestoreRef.update({'solicitacao': solicitacao = 1});

  }

  @override
  String toString() {
    return 'LojasData{id: $id, category: $category, name: $name, promocao: $promocao, trabalhe_conosco: $trabalheConosco, number: $number, price: $price, destaque: $destaque, img: $img, imgDestacadas: $imgDestacadas, imgCupons: $imgCupons, imgOfertas: $imgOfertas, pos: $pos, views: $views, viewsWhats: $viewsWhats, idCat: $idCat, idAdsUser: $idAdsUser, idUser: $idUser}';
  }
}
