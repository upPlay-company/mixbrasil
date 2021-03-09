import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:get_it/get_it.dart';
import 'package:mix_brasil/helpers/firebase.error.dart';
import 'package:mix_brasil/model/user/user.dart';
import 'package:mix_brasil/stores/user_manager_store.dart';

class UserRepository {

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  UserUser user;

  Future<UserUser> signIn({String email, String password, Function onFail, Function onSuccess}) async {
      final UserCredential result = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      await UserManagerStore().loadCurrentUser(firebaseUser: result.user);

      GetIt.I<UserManagerStore>().setUser(user);
  }

  Future<UserUser> signUp({UserUser user, Function onFail, Function onSuccess}) async {
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
  }

  Future<UserUser> facebookLogin({Function onFail, Function onSuccess}) async {
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
  }

  void signOut() {
    auth.signOut();
    user = null;
  }
}