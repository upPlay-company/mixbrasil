import 'package:get_it/get_it.dart';
import 'package:mix_brasil/model/cep/uf.dart';
import 'package:mix_brasil/repositories/user_repository.dart';
import 'package:mix_brasil/stores/user_manager_store.dart';
import 'package:mobx/mobx.dart';
part 'filter_state_city_store.g.dart';

class FilterStateCityStore = _FilterStateCityStore with _$FilterStateCityStore;

abstract class _FilterStateCityStore with Store {

  @observable
  UF uf;

  @action
  void setState(UF value) => uf = value;

  @computed
  bool get stateValid => uf != null;
  String get stateError {
    if (stateValid || showErrors)
      return null;
    else
      return 'Campo obrigatório';
  }

  @computed
  bool get formValid =>
            stateValid;
  @computed
  Function get sendPressed => formValid ? _send : null;

  @observable
  bool showErrors = false;

  @action
  void invalidSendPressed() => showErrors = true;

  @observable
  bool saveState = false;

  @action
  Future<void> _send() async {

    final user = GetIt.I<UserManagerStore>();

    await UserRepository().saveState(uf, user.user);

    user.setUser(user.user);

    saveState = true;
  }
}