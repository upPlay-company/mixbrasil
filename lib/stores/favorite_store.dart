import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:mix_brasil/model/desapego/desapego.dart';
import 'package:mix_brasil/stores/user_manager_store.dart';
import 'package:mobx/mobx.dart';

part 'favorite_store.g.dart';

class FavoriteStore = _FavoriteStore with _$FavoriteStore;

abstract class _FavoriteStore with Store {

  final UserManagerStore userManager = GetIt.I<UserManagerStore>();

  _FavoriteStore() {
    _getFavoriteList();
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  DesapegoData desapegoData;

  ObservableList<DesapegoData> favoriteList = ObservableList<DesapegoData>();

  @action
  Future<void> _getFavoriteList() async {
    try {
      favoriteList.clear();
      if (userManager.isLoggedIn) {
        final QuerySnapshot snapAnuncio = await firestore
            .collection('users')
            .doc(userManager.user.id)
            .collection('favoritos').get();
        final favorite = snapAnuncio.docs.map((a) =>
            DesapegoData.fromDocument(a)).toList();
        favoriteList.addAll(favorite);
      }
    } catch (e){
      print(e);
    }
  }

  @action
  Future<void> toggleFavorite(DesapegoData desapego) async {
    try {
      if (favoriteList.any((a) => a.id == desapego.id) ||
          favoriteList.any((a) => a.id == desapego.favoriteUser?.favoriteId)) {
        favoriteList.removeWhere((a) => a.id == desapego.id);
        favoriteList.removeWhere((a) =>
        a.id == desapego.favoriteUser.favoriteId);
        await desapego.delete(desapego: desapego, user: userManager.user);
      } else {
        favoriteList.add(desapego);
        await desapego.save(desapego: desapego, user: userManager.user);
      }
    } catch (e){
      print(e);
    }
  }

  @action
  Future<void> deleteFavorite (DesapegoData desapego) async {
    try {
      await desapego.deleteFavorite(desapego: desapego, user: userManager.user);
    } catch (e){
      print(e);
    }
  }

}