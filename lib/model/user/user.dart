import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:mix_brasil/model/cep/address.dart';

class UserUser extends ChangeNotifier {

  UserUser({this.email, this.password, this.name, this.confirmPassword, this.id, this.phone});

  UserUser.fromDocument(DocumentSnapshot document){
    id = document.id;
    name = document.data()['name'] as String;
    email = document.data()['email'] as String;
    phone = document.data()['phone'] as String;
    img = document.data()['img'] as String;
    if(document.data().containsKey('address')){
      address = Address.fromMap(document.data()['address'] as Map<String, dynamic>);
    }
  }

  Address address;

  String id, name, email, password, img, phone, confirmPassword, newPass;



  DocumentReference get firestoreRef =>
      FirebaseFirestore.instance.doc('users/$id');

  Future<void> saveData() async {
    await firestoreRef.set(toMap());
  }

  Map<String, dynamic> toMap(){
    return {
      'name': name,
      'email': email,
      'phone' : phone,
      'img': img,
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

    final Map<String, dynamic> data = toMap();
    /*final Map<String, dynamic> data = {
      'name': name,
      'email': email,
      'phone': phone,
      'nascimento': datanasc,
    };*/

    if(id == null){
      final doc = await firestoreRef.collection('users').add(data);
      id = doc.id;
    }
    else {
      await firestoreRef.update(data);
    }

    loading = false;
  }

  void setAddress(Address address){
    this.address = address;
    saveData();
    print(address);
  }

}