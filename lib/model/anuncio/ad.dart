import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:mix_brasil/model/cep/address.dart';
import 'package:mix_brasil/model/cep/city.dart';
import 'package:mix_brasil/model/cep/uf.dart';
import 'package:mix_brasil/model/desapego/desapego_category.dart';
import 'package:mix_brasil/model/user/user.dart';
import 'package:mix_brasil/model/user/user_manager.dart';
import 'package:uuid/uuid.dart';

enum AdStatus { PENDING, ACTIVE, SOLD, DELETED }

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
    created = document.data()['created'] as Timestamp;
    status = AdStatus.values[document.data()['status'] as int];
    views = document.data()['views'];
    idAds = document.data()['idAds'];
    idCat = document.data()['idCat'];

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
  Timestamp created;
  String idAds;
  String idCat;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  Reference get storageRef =>
      storage.ref().child('imagens_desapegos').child(user.id);

  Future<void> save(Ad ad) async {
    try {
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
        'created': FieldValue.serverTimestamp(),
        'status': ad.status.index,
        'user': ad.user.id,
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

          await firestoreRef.update({'img': uploadImage});
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

        await firestoreRef.update(data);
        await firestoreRefAds.update(data);

      }
    } catch (e) {
      return Future.error('Falha ao salvar anúncio');
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
    await firestoreRefAds.update({'status': AdStatus.SOLD.index});
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

    await firestoreRef.delete();
    await firestoreRefAds.delete();
  }

  @override
  String toString() {
    return 'Ad{id: $id, images: $images, title: $title, description: $description, category: $category, address: $address, price: $price, status: $status, user: $user, views: $views, created: $created}';
  }
}
