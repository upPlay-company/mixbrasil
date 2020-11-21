import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:mix_brasil/model/categorias/categorias.dart';
import 'package:mix_brasil/model/lojas/loja.dart';


class LojasManager extends ChangeNotifier {

  LojasManager(){
    _loadlojas();
  }

  final List<Lojas> _loja = [];

  Categorias categorias;

  StreamSubscription _subscription;

  bool editing = false;
  bool loading = false;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  void updateLoja(Categorias categorias){
    this.categorias = categorias;
    lojas.clear();

    _subscription?.cancel();
    if(categorias != null){
      _loadlojas();
    }
  }

  Future<void> _loadlojas() async {
    firestore.collection('lojas').orderBy('category').snapshots().listen((snapshot) {
      _loja.clear();
      for(final DocumentSnapshot document in snapshot.docs){
        _loja.add(Lojas.fromDocument(document));
      }
      notifyListeners();
    });
  }

  List<Lojas> get lojas {
    return _loja;
  }
}