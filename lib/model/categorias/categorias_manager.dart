import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:mix_brasil/model/categorias/categorias.dart';


class CategoriasManager extends ChangeNotifier {

  CategoriasManager(){
    _loadCat();
  }

  final List<Categorias> _categorias = [];


  bool editing = false;
  bool loading = false;

  final Firestore firestore = Firestore.instance;

  Future<void> _loadCat() async {
    firestore.collection('categorias').orderBy('pos').snapshots().listen((snapshot) {
      _categorias.clear();
      for(final DocumentSnapshot document in snapshot.documents){
        _categorias.add(Categorias.fromDocument(document));
      }
      notifyListeners();
    });
  }

  List<Categorias> get categorias {
    return _categorias;
  }

}