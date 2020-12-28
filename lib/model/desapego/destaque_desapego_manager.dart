import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:mix_brasil/model/desapego/desapego_destaque.dart';


class DestaqueDesapegoManager extends ChangeNotifier {

  DestaqueDesapegoManager(){
    _loadDesapego();
  }

  List<DesapegoDestaque> _desapegoDestaque = [];

  bool editing = false;
  bool loading = false;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> _loadDesapego() async {
    final QuerySnapshot snapDestaques =
    await firestore.collection('destaque_desapego').orderBy('pos').get();

    _desapegoDestaque = snapDestaques.docs.map(
            (c) => DesapegoDestaque.fromDocument(c)).toList();

    notifyListeners();
  }

  List<DesapegoDestaque> get desapegoDestaque {
    return _desapegoDestaque;
  }

}