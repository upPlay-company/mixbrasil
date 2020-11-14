import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:mix_brasil/model/home/section_destaque.dart';


class HomeDestaques extends ChangeNotifier {

  HomeDestaques(){
    _loadSections();
  }

  final List<Section2> _sections = [];


  bool editing = false;
  bool loading = false;

  final Firestore firestore = Firestore.instance;

  Future<void> _loadSections() async {
    firestore.collection('lojas').orderBy('pos').snapshots().listen((snapshot) {
      _sections.clear();
      for(final DocumentSnapshot document in snapshot.documents){
        _sections.add(Section2.fromDocument(document));
      }
      notifyListeners();
    });
  }

  List<Section2> get sections {
    return _sections;
  }

}