import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class UserUser {

  UserUser({this.email, this.password, this.name, this.confirmPassword, this.id, this.phone});

  UserUser.fromDocument(DocumentSnapshot document){
    id = document.id;
    name = document.data()['name'] as String;
    email = document.data()['email'] as String;
    phone = document.data()['phone'] as String;
    img = document.data()['img'] as String;
  }

  String id;
  String name;
  String email;
  String img;
  String password;
  String confirmPassword;
  String phone;


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
      'img': img
    };
  }

}