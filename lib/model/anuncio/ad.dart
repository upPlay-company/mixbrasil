import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:mix_brasil/model/cep/address.dart';
import 'package:mix_brasil/model/cep/city.dart';
import 'package:mix_brasil/model/cep/uf.dart';
import 'package:mix_brasil/model/desapego/desapego_category.dart';
import 'package:mix_brasil/model/user/user.dart';
import 'package:mix_brasil/model/user/user_manager.dart';
import 'package:uuid/uuid.dart';

enum AdStatus { PENDING, ACTIVE, SOLD, DELETE }

class Ad {
  Ad.fromDocument(DocumentSnapshot document) {
    id = document.id;
    title = document.data()['name'];
    description = document.data()['descricao'];
    images = List<String>.from(document.data()['img'] as List<dynamic>);
    price = document.data()['price'];
    address = Address(
      cidade: City(name: document.data()['cidade'] as String),
      uf: UF(initials: document.data()['estado']as String),
      zipCode: document.data()['zipCode']
    );
    user = UserUser(
      id: user.id
    );
    category = DesapegoCategory(
      id: document.id,
      name: document.data()['categoria'],
    );
    //created = document.data()['created'] as Timestamp;
    status = AdStatus.values[document.data()['status'] as int];
    views = document.data()['views'];
    idAds = document.data()['idAds'];
    idCat = document.data()['idCat'];
    viewsDestaque = document.data()['viewsDestaque'];
    idAdsDestaque = document.data()['idAdsDestaque'];
  }

  Ad();

  String id;
  List<dynamic> images = [];
  String title;
  String description;
  DesapegoCategory category;
  Address address;
  num price;
  AdStatus status = AdStatus.ACTIVE;
  UserUser user = GetIt.I<UserManager>().user;
  int views;
  int viewsDestaque;
  Timestamp created;
  String idAds;
  String idCat;
  bool destaque;
  String idAdsDestaque;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  Reference get storageRef =>
      storage.ref().child('imagens_desapegos').child(user.id);

  Future<void> save(Ad ad) async {
      final Map<String, dynamic> data = {
        'name': ad.title,
        'descricao': ad.description,
        'price': ad.price,
        'estado': ad.address.uf.initials,
        'cidade': ad.address.cidade.name,
        'zipCode': ad.address.zipCode,
        'categoria': ad.category.name,
        'anunciante': ad.user.name,
        'number': ad.user.phone,
        'views': ad.views = 0,
        'viewsDestaque': ad.viewsDestaque = 0,
        'created': FieldValue.serverTimestamp(),
        'status': ad.status.index,
        'user': ad.user.id,
        'destaque': ad.destaque = false
      };

      if (ad.id == null) {
        final doc = await FirebaseFirestore.instance
            .collection('desapego')
            .doc(ad.category.id)
            .collection('desapegos')
            .add(data);

        final docUser = await FirebaseFirestore.instance
            .collection('users')
            .doc(ad.user.id)
            .collection('desapegos')
            .add(data);

        final List<String> uploadImage = [];

        for (final image in ad.images) {
          if (image as File != null) {
            final UploadTask task =
                storageRef.child(Uuid().v1()).putFile(image);
            final TaskSnapshot snapshot = await task;
            final String url = await snapshot.ref.getDownloadURL();
            uploadImage.add(url);
          }

          DocumentReference firestoreRef = firestore
              .collection('desapego')
              .doc(ad.category.id)
              .collection('desapegos')
              .doc(doc.id);

          DocumentReference firestoreRefUser = firestore
              .collection('users')
              .doc(ad.user.id)
              .collection('desapegos')
              .doc(docUser.id);

          await firestoreRef.update({'img': uploadImage, 'idAdsUser': docUser.id,'idCat': ad.category.id});
          ad.images = uploadImage;

          await firestoreRefUser.update({'img': uploadImage, 'idAds': doc.id, 'idCat': ad.category.id});
          ad.images = uploadImage;
        }
      } else {

        DocumentReference firestoreRef = firestore
            .collection('users')
            .doc(ad.user.id)
            .collection('desapegos')
            .doc(ad.id);

        DocumentReference firestoreRefAds = firestore
            .collection('desapego')
            .doc(ad.idCat)
            .collection('desapegos')
            .doc(ad.idAds);

        final List<String> uploadImage = [];

        for (final image in ad.images) {
          if (image is File) {
            final UploadTask task =
            storageRef.child(Uuid().v1()).putFile(image);
            final TaskSnapshot snapshot = await task;
            final String url = await snapshot.ref.getDownloadURL();
            uploadImage.add(url);
          } else if(ad.images.contains(image)){
            uploadImage.add(image as String);
          }
        }

        for(final image in ad.images){
          if(!ad.images.contains(image)){
            try {
              final ref = storage.refFromURL(image);
              await ref.delete();
            } catch (e){
              debugPrint('Falha ao deletar $image');
            }
          }
        }

          await firestoreRef.update({'img': uploadImage});
          ad.images = uploadImage;

          await firestoreRefAds.update({'img': uploadImage});
          ad.images = uploadImage;

        await firestoreRef.update(data);
        await firestoreRefAds.update(data);

        }
  }

  Future<void> sold(Ad ad) async {
    DocumentReference firestoreRef = firestore
        .collection('users')
        .doc(ad.user.id)
        .collection('desapegos')
        .doc(ad.id);

    DocumentReference firestoreRefAds = firestore
        .collection('desapego')
        .doc(ad.idCat)
        .collection('desapegos')
        .doc(ad.idAds);

    await firestoreRef.update({'status': AdStatus.SOLD.index});
    await firestoreRefAds.delete();
  }

  Future<void> delete(Ad ad) async {
    DocumentReference firestoreRef = firestore
        .collection('users')
        .doc(ad.user.id)
        .collection('desapegos')
        .doc(ad.id);

    DocumentReference firestoreRefAds = firestore
        .collection('desapego')
        .doc(ad.idCat)
        .collection('desapegos')
        .doc(ad.idAds);

    DocumentReference firestoreRefDestaque = firestore
        .collection('destaque_desapego')
        .doc(ad.idAdsDestaque);

    await firestoreRef.delete();
    await firestoreRefAds.delete();
    await firestoreRefDestaque.delete();
  }

  Future<void> destacar(Ad ad) async {
    final Map<String, dynamic> data = {
      'name': ad.title,
      'estado': ad.address.uf.initials,
      'cidade': ad.address.cidade.name,
      'zipCode': ad.address.zipCode,
      'categoria': ad.category.name,
      'anunciante': user.name,
      'number': user.phone,
      'email': user.email,
      'created': FieldValue.serverTimestamp(),
      'user': ad.user.id,
      'idAds': ad.id,
      'img': ad.images,
    };

    FirebaseFirestore.instance.collection('msg_destaca_desapego').add(data);

  }

  Future<void> soldDestaque(Ad ad) async {
    DocumentReference firestoreRef = firestore
        .collection('users')
        .doc(ad.user.id)
        .collection('desapegos')
        .doc(ad.id);

    DocumentReference firestoreRefAds = firestore
        .collection('desapego')
        .doc(ad.idCat)
        .collection('desapegos')
        .doc(ad.idAds);

    DocumentReference firestoreRefDestaque = firestore
        .collection('destaque_desapego')
        .doc(ad.idAdsDestaque);

    await firestoreRef.update({'status': AdStatus.SOLD.index});
    await firestoreRefDestaque.delete();
    await firestoreRefAds.delete();
  }


  @override
  String toString() {
    return 'Ad{id: $id, images: $images, title: $title, description: $description, category: $category, address: $address, price: $price, status: $status, user: $user, views: $views, created: $created}';
  }
}
