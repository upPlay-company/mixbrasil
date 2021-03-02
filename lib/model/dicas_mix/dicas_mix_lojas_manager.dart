import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:mix_brasil/model/dicas_mix/dicas_mix_lojas.dart';

class DicasMixLojasManager extends ChangeNotifier {

  DicasMixLojasManager(){
    _getDicas();
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<DicasMixLojas> _allDicas = [];

  bool loading = false;

  Future<void> _getDicas() async {
    loading = true;
    try {
      final QuerySnapshot snapDestaques =
      await firestore.collection('dicas_mix_lojas').get();

      _allDicas = snapDestaques.docs.map(
              (c) => DicasMixLojas.fromDocument(c)).toList();

      notifyListeners();
    } catch (e){
      return Future.error('erro ao buscar dicas');
    }
    loading = false;
  }

  List<DicasMixLojas> get dicasMixLojas {
    return _allDicas;
  }

}