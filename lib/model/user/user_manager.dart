import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:mix_brasil/helpers/firebase.error.dart';
import 'package:mix_brasil/model/cep/address.dart';
import 'package:mix_brasil/model/desapego/desapego.dart';
import 'package:mix_brasil/model/user/user.dart';
import 'package:mix_brasil/services/cep_aberto_services.dart';

class UserManager extends ChangeNotifier {
  UserManager() {
    _loadCurrentUser();
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  UserUser user;
  List<UserUser> allUser = [];
  Address address;

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  bool _loadingFacebook = false;
  bool get loadingFacebook => _loadingFacebook;
  set loadingFacebook(bool value) {
    _loadingFacebook = value;
    notifyListeners();
  }

  bool get isLoggedIn => user != null;

  Future<void> signIn(
      {UserUser user, Function onFail, Function onSuccess}) async {
    loading = true;
    try {
      final UserCredential result = await auth.signInWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );

      await _loadCurrentUser(firebaseUser: result.user);

      onSuccess();
    } on FirebaseAuthException catch (e) {
      onFail(getErrorString(e.code));
    }

    loading = false;
  }

  Future<void> facebookLogin({Function onFail, Function onSuccess}) async {
    loadingFacebook = true;

    final result = await FacebookLogin().logIn(['email', 'public_profile']);

    switch(result.status){
      case FacebookLoginStatus.loggedIn:
        final credential = FacebookAuthProvider.credential(
          result.accessToken.token
        );

        final authResult = await auth.signInWithCredential(credential);

        if(authResult != null){
          final firebaseUser = authResult.user;

          user = UserUser(
            id: firebaseUser.uid,
            name: firebaseUser.displayName,
            email: firebaseUser.email
          );

          await user.saveData();

          user.saveToken();

          onSuccess();
        }
        break;
      case FacebookLoginStatus.cancelledByUser:
        break;
      case FacebookLoginStatus.error:
        onFail(result.errorMessage);
        break;
    }
    loadingFacebook = false;
  }

  Future<void> signUp(
      {UserUser user, Function onFail, Function onSuccess}) async {
    loading = true;
    try {
      final UserCredential result = await auth.createUserWithEmailAndPassword(
          email: user.email, password: user.password);

      user.id = result.user.uid;
      this.user = user;

      await user.saveData();

      user.saveToken();

      onSuccess();
    } on FirebaseAuthException catch (e) {
      onFail(getErrorString(e.code));
    }
    loading = false;
  }

  void signOut() {
    auth.signOut();
    user = null;
    notifyListeners();
  }

  void recoverPass(String email) {
    auth.sendPasswordResetEmail(email: email);
  }

  Future<void> _loadCurrentUser({User firebaseUser}) async {
    final User currentUser = firebaseUser ?? auth.currentUser;
    if (currentUser != null) {
      final DocumentSnapshot docUser =
          await firestore.collection('users').doc(currentUser.uid).get();
      user = UserUser.fromDocument(docUser);

      user.saveToken();
      notifyListeners();
    }
  }

  void update(UserUser user) {
    allUser.removeWhere((u) => u.id == user.id);
    allUser.add(user);
    notifyListeners();
  }

  void updateUser(UserManager userManager) {
    user = userManager.user;
    removeAddress();

    if (user != null) {
      _loadUserAddress();
    }
  }

  Future<void> _loadUserAddress() async {
    if (user.address != null) {
      address = user.address;
      notifyListeners();
    }
  }

  bool get isAddressValid => address != null;

  Future<void> getAddress(String cep) async {
    loading = true;
    final cepAbertoService = CepAbertoService();

    try {
      final cepAbertoAddress = await cepAbertoService.getAddressFromCep(cep);

      if (cepAbertoAddress != null) {
        address = Address(
            district: cepAbertoAddress.bairro,
            zipCode: cepAbertoAddress.cep,
            city: cepAbertoAddress.cidade.nome,
            state: cepAbertoAddress.estado.sigla,
            lat: cepAbertoAddress.latitude,
            long: cepAbertoAddress.longitude);
      }

      loading = false;
    } catch (e) {
      loading = false;
      return Future.error('CEP Inválido');
    }
  }

  Future<void> setAddress(Address address) async {
    loading = true;
    this.address = address;
    try {
      user.setAddress(address);
      loading = false;
    } catch (e) {
      return Future.error('Endereço não localizado');
    }
  }


  void removeAddress() {
    address = null;
    notifyListeners();
  }

  Future<List<DesapegoData>> getFavoritos(UserUser user) async {
    final QuerySnapshot snapAnuncio = await firestore
        .collection('users')
        .doc(user.id)
        .collection('favoritos').get();

    snapAnuncio.docs.map((a) => DesapegoData.fromDocument(a)).toList();
  }
}
