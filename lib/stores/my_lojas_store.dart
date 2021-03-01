import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:mix_brasil/model/criar_loja/criar_loja.dart';
import 'package:mix_brasil/model/user/user_manager.dart';
import 'package:mobx/mobx.dart';

part 'my_lojas_store.g.dart';

class MyLojasStore = _MyLojasStore with _$MyLojasStore;

abstract class _MyLojasStore with Store {

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  _MyLojasStore() {
    _getMyLojas();
  }

  @observable
  // ignore: non_constant_identifier_names
  List<AdLojas> AllAds = [];

  @computed
  List<AdLojas> get activeAds => AllAds.where(
          (adLojas) => adLojas.status == AdStatus.ACTIVE).toList();
  List<AdLojas> get destacadoAds => AllAds.where(
          (adLojas) => adLojas.status == AdStatus.DELETE).toList();


  Future<void> _getMyLojas() async {
    final user = GetIt.I<UserManager>().user.id;
      loading = true;
      final QuerySnapshot snapAnuncio = await firestore
          .collection('users')
          .doc(user)
          .collection('lojas')
          .orderBy('created', descending: true)
          .limit(100)
          .get();

      AllAds = snapAnuncio.docs.map((a) => AdLojas.fromDocument(a)).toList();
      loading = false;
    }

  @observable
  bool loading = false;

  void refresh() => _getMyLojas();

  @observable
  bool hideCard = false;

  @action
  void setHidePag(bool value) => hideCard = value;

  @action
  Future<void> deleteAd(AdLojas adLojas) async {
    loading = true;
    await AdLojas().delete(adLojas);
    refresh();
  }

  @action
  Future<void> destacarAd(AdLojas adLojas) async {
    adLojas.hideCredito = hideCard;
    adLojas.hideBoleto = hideCard;
    loading = true;
    await AdLojas().destacar(adLojas);
    refresh();
  }

}