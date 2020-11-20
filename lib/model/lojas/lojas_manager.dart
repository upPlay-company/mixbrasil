import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:mix_brasil/model/lojas/loja.dart';


class LojasManager extends ChangeNotifier {

  LojasManager(){
    _loadSections();
  }

  final List<Lojas> _loja = [];


  bool editing = false;
  bool loading = false;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> _loadSections() async {
    firestore.collection('lojas').orderBy('pos').snapshots().listen((snapshot) {
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