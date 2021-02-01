import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:mix_brasil/model/cep/address.dart';
import 'package:mix_brasil/model/desapego/desapego_category.dart';
import 'package:mix_brasil/model/user/user.dart';
import 'package:mix_brasil/model/user/user_manager.dart';
import 'package:uuid/uuid.dart';

enum AdStatus { PENDING, ACTIVE, SOLD, DELETED }
class Ad {

  Ad.fromDocument(DocumentSnapshot document){
    id = document.id;
    title = document.data()['name'];
    description = document.data()['description'];
    price = document.data()['price'];
    address = Address(
      cidade: document.data()['cidade'],
      uf: document.data()['estado'],
    );
    user = user.id as UserUser;
    category = DesapegoCategory(
      id: document.id,
      name: document.data()['categoria'],
    );
  }

  Ad();

  String id;
  List<dynamic> images;
  String title;
  String description;
  DesapegoCategory category;
  Address address;
  num price;
  AdStatus status = AdStatus.PENDING;
  UserUser user = GetIt.I<UserManager>().user;
  int views;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  Reference get storageRef =>
      storage.ref().child('imagens_desapegos').child(user.id);

  Future<void> save(Ad ad) async {

   try {
    final Map<String, dynamic> data = {
      'name': ad.title,
      'description': ad.description,
      'price': ad.price,
      'estado': ad.address.uf.initials,
      'cidade': ad.address.cidade.name,
      'categoria': ad.category.name,
      'anunciante': ad.user.name,
      'number': ad.user.phone,
      'views' : ad.views = 0
    };

    if (ad.id == null) {
      final doc = await FirebaseFirestore.instance.collection('desapego').doc(
          ad.category.id).collection('desapegos').add(data);

      final docUser = await FirebaseFirestore.instance.collection('users').doc(
          ad.user.id).collection('desapegos').add(data);

      final List<String> uploadImage = [];

      for (final image in ad.images) {
        if (image as File != null) {
          final UploadTask task = storageRef.child(Uuid().v1()).putFile(image);
          final TaskSnapshot snapshot = await task;
          final String url = await snapshot.ref.getDownloadURL();
          uploadImage.add(url);
        }

        DocumentReference firestoreRef = firestore.collection('desapego').
        doc(ad.category.id).collection('desapegos').doc(doc.id);

        DocumentReference firestoreRefUser = firestore.collection('users').
        doc(ad.user.id).collection('desapegos').doc(docUser.id);

        await firestoreRef.update({'img': uploadImage});
        ad.images = uploadImage;

        await firestoreRefUser.update({'img': uploadImage});
        ad.images = uploadImage;
      }
    }
    else {
      // TODO: ATUALIZAR...
    }
    
  } catch (e) {
     return Future.error('Falha ao salvar anúncio');
   }
  }
}