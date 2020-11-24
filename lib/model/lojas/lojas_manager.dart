import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:mix_brasil/model/categorias/categorias.dart';
import 'package:mix_brasil/model/categorias/categorias_manager.dart';
import 'package:mix_brasil/model/lojas/loja.dart';


class LojasManager extends ChangeNotifier {

  LojasManager(){
    _loadlojas();
  }

  Categorias categorias;

  final List<Lojas> _loja = [];

  StreamSubscription _subscription;

  bool editing = false;
  bool loading = false;

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

  }

  List<Lojas> get lojas {
    return _loja;
  }
}