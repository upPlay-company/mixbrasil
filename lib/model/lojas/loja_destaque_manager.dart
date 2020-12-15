import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'destaque.dart';


class LojasDestaqueManager extends ChangeNotifier {

  LojasDestaqueManager(){
    _loadDestaques();
  }

  List<DestaqueLoja> _lojasDestaque = [];

  bool editing = false;
  bool loading = false;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> _loadDestaques() async {
    final QuerySnapshot snapDestaques =
    await firestore.collection('destaques_home').orderBy('pos').get();

    _lojasDestaque = snapDestaques.docs.map(
            (c) => DestaqueLoja.fromDocument(c)).toList();

    notifyListeners();
  }

  List<DestaqueLoja> get lojasDestaque {
    return _lojasDestaque;
  }

  DestaqueLoja findProductByID(String id){
    try {
      return _lojasDestaque.firstWhere((l) => l.id == id);
    } catch (e){
      return null;
    }
  }

}