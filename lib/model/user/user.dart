import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:mix_brasil/model/cep/address.dart';
import 'package:mix_brasil/model/cep/uf.dart';
import 'package:uuid/uuid.dart';

class UserUser extends ChangeNotifier {

  UserUser({this.email, this.password, this.name, this.confirmPassword, this.id, this.phone, this.idState});

  UserUser.fromDocument(DocumentSnapshot document){
    id = document.id;
    name = document.data()['name'] as String;
    email = document.data()['email'] as String;
    phone = document.data()['phone'] as String;
    if(document.data().containsKey('img')){
      img = List<String>.from(document.data()['img'] as List<dynamic>);
    }
    if(document.data().containsKey('address')){
      address = Address.fromMap(document.data()['address'] as Map<String, dynamic>);
    }
    if(document.data().containsKey('filtro_state')){
      idState = UF(
        initials: document.data()['filtro_state'],
        name: document.data()['name_state']
      );
    }
  }

  final FirebaseStorage storage = FirebaseStorage.instance;

  Reference get storageRef => storage.ref().child('users').child(id);

  Address address;

  String id, name, email, password, phone, confirmPassword, newPass;

  List<dynamic> img;

  UF idState;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  DocumentReference get firestoreRef =>
      FirebaseFirestore.instance.doc('users/$id');

  CollectionReference get tokensReference =>
      firestoreRef.collection('tokens');

  Future<void> saveData() async {
    await firestoreRef.set(toMap());
  }

  Map<String, dynamic> toMap(){
    return {
      'name': name,
      'email': email,
      'phone' : phone,
      if(address != null)
        'address': address.toMap(),
    };
  }

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool value){
    _loading = value;
    notifyListeners();
  }

  Future<void> save() async {
    loading = true;


    if(id == null){
      final doc = await firestoreRef.collection('users').add(toMap());
      id = doc.id;
    }
    else {
      await firestoreRef.update(toMap());
    }

    if(img != null){
      final List<String> updateImages = [];

      for(final newImage in img){
        final UploadTask task = storageRef.child(Uuid().v1())
            .putFile(newImage as File);
        final TaskSnapshot snapshot = await task;
        final String url = await snapshot.ref.getDownloadURL();
        updateImages.add(url);
      }

      await firestoreRef.update({'img': updateImages});
      img = updateImages;
    }
    loading = false;

  }

  void setAddress(Address address){
    this.address = address;
    saveData();
    print(address);
  }

  Future<void> saveToken() async {
    final token = await FirebaseMessaging().getToken();
    tokensReference.doc(token).set({
      'token': token,
      'updateAt': FieldValue.serverTimestamp(),
      'platform': Platform.operatingSystem
    });
  }
}