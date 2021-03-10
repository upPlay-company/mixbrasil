import 'package:mix_brasil/repositories/user_repository.dart';
import 'package:mobx/mobx.dart';
import 'package:mix_brasil/helpers/extensions.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {
  @observable
  String email;

  @action
  void setEmail(String value) => email = value;

  @computed
  bool get emailValid => email != null && email.isEmailValid();
  String get emailError =>
      email == null || emailValid ? null : 'E-mail inválido';

  @observable
  String password;

  @action
  void setPassword(String value) => password = value;

  @computed
  bool get passwordValid => password != null && password.length >= 4;
  String get passwordError =>
      password == null || passwordValid ? null : 'Senha inválida';

  @computed
  Function get loginPressed =>
      emailValid && passwordValid && !loading ? _login : null;

  @computed
  Function get recoverPassword => _recover;

  @computed
  Function get loginFacebook => _face;

  @observable
  bool loading = false;

  @observable
  String error;

  @action
  Future<void> _login() async {
    loading = true;
    error = null;

    try {
      await UserRepository().signIn(email: email, password: password);
    } catch (e) {
      error = e;
    }

    loading = false;
  }

  @action
  Future<void> _face() async {
    loading = true;
    error = null;

    try {
      await UserRepository().facebookLogin();
    } catch (e) {
      error = e;
    }

    loading = false;
  }

  @action
  Future<void> _recover() async {
    loading = true;
    error = null;

    try {
      UserRepository().recoverPass(email);
    } catch (e) {
      error = e;
    }

    loading = false;
  }
}
