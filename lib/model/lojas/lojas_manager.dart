import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mix_brasil/model/categorias/categorias.dart';
import 'package:mix_brasil/model/categorias/categorias_manager.dart';
import 'package:mix_brasil/model/lojas/loja.dart';


class LojasManager extends ChangeNotifier {

  LojasManager(){
    _loadlojas();
  }

  Categorias categorias;

  StreamSubscription _subscription;

  bool editing = false;
  bool loading = false;

  List<Lojas> _lojas = [];

  final FirebaseFirestore firestore = FirebaseFirestore.instance;


  void updateCategorias(CategoriasManager categoriasManager){
    this.categorias = categorias;
    lojas.clear();

    _subscription?.cancel();
    if(categorias != null){
      _loadlojas();
    }
  }

  Future<void> _loadlojas() async {
    firestore.collection('categorias').doc().collection('lojas').snapshots().listen((snapshot) {
      _lojas.clear();
      for(final DocumentSnapshot document in snapshot.docs){
        _lojas.add(Lojas.fromDocument(document));
      }
      print(lojas);
      notifyListeners();
    });
  }

  List<Lojas> get lojas{
    return _lojas;
}
}