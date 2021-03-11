import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mix_brasil/model/cep/uf.dart';
import 'package:mix_brasil/model/desapego/desapego.dart';
import 'package:mix_brasil/model/user/user.dart';
import 'package:mix_brasil/repositories/user_repository.dart';
import 'package:mobx/mobx.dart';

part 'user_manager_store.g.dart';

class UserManagerStore = _UserManagerStore with _$UserManagerStore;

abstract class _UserManagerStore with Store {

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  _UserManagerStore(){
    _loadCurrentUser();
  }

  @observable
  UserUser user;

  @action
  void setUser(UserUser value) => user = value;

  @computed
  bool get isLoggedIn => user != null;

  Future<void> _loadCurrentUser({User firebaseUser}) async {
    final User currentUser = firebaseUser ?? auth.currentUser;
    if (currentUser != null) {
      final DocumentSnapshot docUser =
      await firestore.collection('users').doc(currentUser.uid).get();
      user = UserUser.fromDocument(docUser);

      user.saveToken();
      setUser(user);
    }
  }

  Future<void> logout() async {
    UserRepository().signOut();
    setUser(null);
  }


  // ignore: missing_return
  Future<List<DesapegoData>> getFavoritos(UserUser user) async {
    final QuerySnapshot snapAnuncio = await firestore
        .collection('users')
        .doc(user.id)
        .collection('favoritos').get();

    snapAnuncio.docs.map((a) => DesapegoData.fromDocument(a)).toList();
  }

  Future<void> saveIdState(UF uf, UserUser user) async {
    DocumentReference firestoreRef = firestore
        .collection('users')
        .doc(user.id);

    await firestoreRef.update({'filtro_state': uf.initials, 'name_state': uf.name});

  }
}