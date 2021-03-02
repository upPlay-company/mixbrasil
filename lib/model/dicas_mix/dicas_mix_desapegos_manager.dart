import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:mix_brasil/model/dicas_mix/dicas_mix_desapegos.dart';

class DicasMixDesapegosManager extends ChangeNotifier {

  DicasMixDesapegosManager(){
    _getDicas();
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<DicasMixDesapegos> _allDicas = [];

  bool loading = false;

  Future<void> _getDicas() async {
    loading = true;
    try {
      final QuerySnapshot snapDestaques =
      await firestore.collection('dicas_mix_desapegos').get();

      _allDicas = snapDestaques.docs.map(
              (c) => DicasMixDesapegos.fromDocument(c)).toList();

      notifyListeners();
    } catch (e){
      return Future.error('erro ao buscar dicas');
    }
    loading = false;
  }

  List<DicasMixDesapegos> get dicasMixDesapegos {
    return _allDicas;
  }

}