import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:mix_brasil/model/desapego/atalho_cat_desapego.dart';


class DesapegoManager extends ChangeNotifier {

  DesapegoManager(){
    _loadDesapego();
  }

  final List<AtalhoCatDesapego> _atalhoCatDesapego = [];


  bool editing = false;
  bool loading = false;

  final Firestore firestore = Firestore.instance;

  Future<void> _loadDesapego() async {
    firestore.collection('desapego').orderBy('pos').snapshots().listen((snapshot) {
      _atalhoCatDesapego.clear();
      for(final DocumentSnapshot document in snapshot.documents){
        _atalhoCatDesapego.add(AtalhoCatDesapego.fromDocument(document));
      }
      notifyListeners();
    });
  }

  List<AtalhoCatDesapego> get atalhoCatDesapego {
    return _atalhoCatDesapego;
  }

}