import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:mix_brasil/model/criar_loja/criar_loja.dart';
import 'package:mix_brasil/model/user/user_manager.dart';
import 'package:mobx/mobx.dart';

part 'my_lojas_store.g.dart';

class MyLojasStore = _MyLojasStore with _$MyLojasStore;

abstract class _MyLojasStore with Store {

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // ignore: non_constant_identifier_names
  MyLojasStore() {
    _getMyLojas();
  }

  @observable
  // ignore: non_constant_identifier_names
  List<AdLojas> AllAds = [];

  @computed
  List<AdLojas> get activeAds => AllAds.where(
          (ad) => ad.status == AdStatus.ACTIVE).toList();
  List<AdLojas> get destacadoAds => AllAds.where(
          (ad) => ad.status == AdStatus.DELETE).toList();

  Future<void> _getMyLojas() async {
    final user = GetIt.I<UserManager>().user;
    try {
      loading = true;
      final QuerySnapshot snapAnuncio = await firestore
          .collection('users')
          .doc(user.id)
          .collection('lojas')
          .orderBy('created', descending: true)
          .limit(100)
          .get();

      AllAds = snapAnuncio.docs.map((a) => AdLojas.fromDocument(a)).toList();
      loading = false;
    } catch (e){}
  }

  @observable
  bool loading = false;

  void refresh() => _getMyLojas();

}