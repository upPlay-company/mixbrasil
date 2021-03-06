import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:get_it/get_it.dart';
import 'package:mix_brasil/model/cep/uf.dart';
import 'package:mix_brasil/model/user/user.dart';
import 'package:mix_brasil/stores/user_manager_store.dart';

class UserRepository {

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  UserUser user;

  Future<void> loadCurrentUser({User firebaseUser}) async {
    final User currentUser = firebaseUser ?? auth.currentUser;
    if (currentUser != null) {
      final DocumentSnapshot docUser =
      await firestore.collection('users').doc(currentUser.uid).get();
      user = UserUser.fromDocument(docUser);

      user.saveToken();
    }
  }

  // ignore: missing_return
  Future<UserUser> signIn({String email, String password}) async {
      final UserCredential result = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      await loadCurrentUser(firebaseUser: result.user);

      GetIt.I<UserManagerStore>().setUser(user);
  }

  // ignore: missing_return
  Future<UserUser> signUp(UserUser user) async {
      final UserCredential result = await auth.createUserWithEmailAndPassword(
          email: user.email, password: user.password);

      user.id = result.user.uid;
      this.user = user;

      await user.saveData();

      await loadCurrentUser(firebaseUser: result.user);

      user.saveToken();

      GetIt.I<UserManagerStore>().setUser(user);
  }

  // ignore: missing_return
  Future<UserUser> facebookLogin() async {
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
              email: firebaseUser.email,
              phone: firebaseUser.phoneNumber
          );

          await user.saveData();

          user.saveToken();

          GetIt.I<UserManagerStore>().setUser(user);
        }
        break;
      case FacebookLoginStatus.cancelledByUser:
        break;
      case FacebookLoginStatus.error:
        Future.error(result.errorMessage);
        break;
    }
  }

  void signOut() {
    auth.signOut();
    user = null;
  }

  void recoverPass(String email) {
    auth.sendPasswordResetEmail(email: email);
  }

  Future<void> save(UserUser user) async {
      await user.save();
  }

  Future<void> saveState(UF uf, UserUser user) async {
    await user.saveState(uf, user);
  }
}