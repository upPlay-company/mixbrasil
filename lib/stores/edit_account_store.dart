import 'dart:ui';

import 'package:get_it/get_it.dart';
import 'package:mix_brasil/model/user/user.dart';
import 'package:mix_brasil/repositories/user_repository.dart';
import 'package:mix_brasil/stores/user_manager_store.dart';
import 'package:mobx/mobx.dart';

part 'edit_account_store.g.dart';

class EditAccountStore = _EditAccountStore with _$EditAccountStore;

abstract class _EditAccountStore with Store {
  _EditAccountStore() {
    user = userManagerStore.user;
    name = user.name;
    phone = user.phone;
    email = user.email;
  }

  UserUser user;

  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();

  @observable
  String name;

  @action
  void setName(String value) => name = value;

  @computed
  bool get nameValid => name != null && name.length >= 6;
  String get nameError =>
      nameValid || name == null ? null : 'Campo obrigatório';

  @observable
  String email;

  @action
  void setEmail(String value) => name = value;

  @observable
  String phone;

  @action
  void setPhone(String value) => phone = value;

  @computed
  bool get phoneValid => phone != null && phone.length >= 14;
  String get phoneError =>
      phoneValid || phone == null ? null : 'Campo obrigatório';

  @computed
  bool get isFormValid => nameValid && phoneValid;

  @observable
  bool loading = false;

  @observable
  bool saveUser = false;

  @computed
  VoidCallback get savePressed => (isFormValid && !loading) ? _save : null;

  @action
  Future<void> _save() async {
    loading = true;

    user.name = name;
    user.phone = phone;

    try {
      await UserRepository().save(user);
      userManagerStore.setUser(user);
      saveUser = true;
    } catch (e) {
      print(e);
    }

    loading = false;
  }

  void logout() => userManagerStore.logout();
}
