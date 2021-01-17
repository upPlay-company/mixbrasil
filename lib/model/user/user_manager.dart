import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:mix_brasil/helpers/firebase.error.dart';
import 'package:mix_brasil/model/cep/address.dart';
import 'package:mix_brasil/model/user/user.dart';
import 'package:mix_brasil/services/cep_aberto_services.dart';

class UserManager extends ChangeNotifier {
  UserManager() {
    _loadCurrentUser();
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  static final FacebookLogin facebookSignIn = new FacebookLogin();
  String _message = 'Faça login / logout pressionando os botões abaixo.';

  UserUser user;
  Address address;

  bool _loading = false;

  bool get loading => _loading;

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

  Future<void> signUp(
      {UserUser user, Function onFail, Function onSuccess}) async {
    loading = true;
    try {
      final UserCredential result = await auth.createUserWithEmailAndPassword(
          email: user.email, password: user.password);

      user.id = result.user.uid;
      this.user = user;

      await user.saveData();

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

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  //TODO: Implementar a função de recuperação de senha
  void recoverPass(String email) {
    auth.sendPasswordResetEmail(email: email);
  }

  Future<void> _loadCurrentUser({User firebaseUser}) async {
    final User currentUser = firebaseUser ?? auth.currentUser;
    if (currentUser != null) {
      final DocumentSnapshot docUser =
          await firestore.collection('users').doc(currentUser.uid).get();
      user = UserUser.fromDocument(docUser);
      notifyListeners();
    }
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
            street: cepAbertoAddress.logradouro,
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

  //Função para fazer login com o facebook
  Future<Null> loginFacebook() async {
    final FacebookLoginResult result = await facebookSignIn.logIn(['email']);

    //switch para verificar status do login, conforme for,
    // ele trás mensagem avisando sobre o estado atual
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final FacebookAccessToken accessToken = result.accessToken;
        _showMessageFacebook('''
         Logado!
         
         Token: ${accessToken.token}
         User id: ${accessToken.userId}
         Expires: ${accessToken.expires}
         Permissions: ${accessToken.permissions}
         Declined permissions: ${accessToken.declinedPermissions}
         ''');
        break;
      case FacebookLoginStatus.cancelledByUser:
        _showMessageFacebook('Login cancelado pelo usuário.');
        break;
      case FacebookLoginStatus.error:
        _showMessageFacebook('Algo deu errado com o processo de login.\n'
            'Aqui está o erro que o Facebook nos deu: ${result.errorMessage}');
        break;
    }
  }

  //Função para deslogar do facebook
  Future<Null> _logOutFacebook() async {
    await facebookSignIn.logOut();
    _showMessageFacebook('Desconectado.');
  }

  void _showMessageFacebook(String message) {
    notifyListeners();
    _message = message;
  }
}
