import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:mix_brasil/model/anuncio/ad.dart';
import 'package:mix_brasil/model/user/user_manager.dart';
import 'package:mobx/mobx.dart';

part 'myads_store.g.dart';

class MyAdsStore = _MyAdsStore with _$MyAdsStore;

abstract class _MyAdsStore with Store {

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  _MyAdsStore() {
    _getMyAds();
  }

  @observable
  // ignore: non_constant_identifier_names
  List<Ad> AllAds = [];

  @computed
  List<Ad> get activeAds => AllAds.where(
          (ad) => ad.status == AdStatus.ACTIVE).toList();
  List<Ad> get destacadoAds => AllAds.where(
          (ad) => ad.status == AdStatus.DELETE).toList();
  List<Ad> get soldAds => AllAds.where(
          (ad) => ad.status == AdStatus.SOLD).toList();

  Future<void> _getMyAds() async {
    final user = GetIt.I<UserManager>().user;
    try {
      loading = true;
      final QuerySnapshot snapAnuncio = await firestore
          .collection('users')
          .doc(user.id)
          .collection('desapegos')
          .orderBy('created', descending: true)
          .limit(100)
          .get();

      AllAds = snapAnuncio.docs.map((a) => Ad.fromDocument(a)).toList();
      loading = false;
    } catch (e){}
  }

  @observable
  bool loading = false;

  void refresh() => _getMyAds();

  @action
  Future<void> soldAd(Ad ad) async {
    loading = true;
    await Ad().sold(ad);
    refresh();
  }

  @action
  Future<void> deleteAd(Ad ad) async {
    loading = true;
    await Ad().delete(ad);
    refresh();
  }

  @action
  Future<void> destacarAd(Ad ad) async {
    loading = true;
    await Ad().destacar(ad);
    refresh();
  }

  @action
  Future<void> soldDestaque(Ad ad) async {
    loading = true;
    await Ad().soldDestaque(ad);
    refresh();
  }
}
