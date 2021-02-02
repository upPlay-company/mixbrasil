import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:mix_brasil/model/adm/adm.dart';


class CategoriasManager extends ChangeNotifier {

  CategoriasManager(){
    _loadWhats();
  }

  List<Adm> _adm = [];


  bool editing = false;
  bool loading = false;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> _loadWhats() async {
    final QuerySnapshot snapWhats =
    await firestore.collection('adm_whats').get();

    _adm = snapWhats.docs.map(
            (w) => Adm.fromDocument(w)).toList();

    notifyListeners();
  }

  List<Adm> get adm {
    return _adm;
  }

}