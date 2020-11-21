import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:mix_brasil/model/categorias/categorias.dart';


class CategoriasManager extends ChangeNotifier {

  CategoriasManager(){
    _loadCat();
  }

  List<Categorias> _categorias = [];


  bool editing = false;
  bool loading = false;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> _loadCat() async {
    final QuerySnapshot snapCategorias =
        await firestore.collection('categorias').get();

    _categorias = snapCategorias.docs.map(
        (c) => Categorias.fromDocument(c)).toList();

    notifyListeners();
  }

  Categorias findCategoriasById(String id) {
    try{
      return _categorias.firstWhere((c) => c.id == id);
    } catch (e){
      return null;
    }
  }

  List<Categorias> get categorias {
    return _categorias;
  }

}