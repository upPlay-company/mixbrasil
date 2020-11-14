import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:mix_brasil/model/home/section.dart';


class HomeManager extends ChangeNotifier {

  HomeManager(){
    _loadSections();
  }

  final List<Section> _sections = [];


  bool editing = false;
  bool loading = false;

  final Firestore firestore = Firestore.instance;

  Future<void> _loadSections() async {
    firestore.collection('home').orderBy('pos').snapshots().listen((snapshot) {
      _sections.clear();
      for(final DocumentSnapshot document in snapshot.documents){
        _sections.add(Section.fromDocument(document));
      }
      notifyListeners();
    });
  }

  List<Section> get sections {
      return _sections;
  }

}