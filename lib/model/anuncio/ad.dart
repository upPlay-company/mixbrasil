import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mix_brasil/model/cep/address.dart';
import 'package:mix_brasil/model/desapego/desapego_category.dart';
import 'package:mix_brasil/model/user/user.dart';
import 'package:uuid/uuid.dart';

enum AdStatus { PENDING, ACTIVE, SOLD, DELETED }
class Ad {

  String id;
  List<dynamic> images;
  String title;
  String description;
  DesapegoCategory category;
  Address address;
  num price;
  AdStatus status = AdStatus.PENDING;
  UserUser user;
  int views;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  bool _loading = false;
  // ignore: unnecessary_getters_setters
  bool get loading => _loading;
  // ignore: unnecessary_getters_setters
  set loading(bool value){
    _loading = value;
  }

  Future<void> save(Ad ad) async {
    loading = true;


    final Map<String, dynamic> data = {
      'name': ad.title,
      'description': ad.description,
      'price': ad.price,
      'estado': ad.address.uf.initials,
      'cidade': ad.address.cidade.name,
      'categoria': ad.category.name,
      'anunciante': ad.user.name,
      'number': ad.user.phone,
    };

    if(ad.id == null){
      final doc = await FirebaseFirestore.instance.collection('desapego').doc(ad.category.id).collection('desapegos').add(data);
      ad.id = doc.id;
    }
    else {
      // TODO: ATUALIZAR...
    }

    print(ad.images);

    FirebaseStorage.instance.ref().child('desapego_images').putFile(ad.images as File);

    // ignore: non_constant_identifier_names
    /*final List<dynamic> Images = ad.images;

    final storageRef = storage.ref().child('desapego_images').child(ad.id);

    final UploadTask task = storageRef.child(Uuid().v1()).putFile(Images as File);
    final TaskSnapshot snapshot = await task
        .then((TaskSnapshot snapshot) {
        print('Upload complete!');
    }).catchError((Object e) {
        print(e);
        print('falha ao salvar');
    });
    final String url = await snapshot.ref.getDownloadURL();
    Images.add(url);*/

    loading = false;
  }



  Future<void> saveUser(Ad ad) async {
    loading = true;

    final Map<String, dynamic> data = {
      'name': ad.title,
      'description': ad.description,
      'price': ad.price,
      'estado': ad.address.uf.initials,
      'cidade': ad.address.cidade.name,
      'categoria': ad.category.name,
      'anunciante': ad.user.name,
      'number': ad.user.phone,
    };

    if(ad.id == null){
      final doc = await FirebaseFirestore.instance.collection('users').doc(ad.user.id).collection('desapegos').add(data);
      ad.id = doc.id;
    }
    else {
      // TODO: ATUALIZAR...
    }

    loading = false;
  }

}