import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:mix_brasil/model/home/banners.dart';


class BannersManager extends ChangeNotifier {

  BannersManager(){
    _loadBanners();
  }

  final List<Banners> _banners = [];


  bool editing = false;
  bool loading = false;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> _loadBanners() async {
    firestore.collection('banners_principal').snapshots().listen((snapshot) {
      _banners.clear();
      for(final DocumentSnapshot document in snapshot.docs){
        _banners.add(Banners.fromDocument(document));
      }
      notifyListeners();
    });
  }

  List<Banners> get banners {
    return _banners;
  }

}