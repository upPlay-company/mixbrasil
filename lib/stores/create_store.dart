import 'package:mix_brasil/model/cep/address.dart';
import 'package:mix_brasil/model/desapego/desapego_category.dart';
import 'package:mobx/mobx.dart';

import 'cep_store.dart';

part 'create_store.g.dart';

class CreateStore = _CreateStore with _$CreateStore;

abstract class _CreateStore with Store {

  ObservableList images = ObservableList();

  @observable
  DesapegoCategory category;

  @action
  void setCategory(DesapegoCategory value) => category = value;

  CepStore cepStore;

  @computed
  Address get address => cepStore.address;
  bool get addressValid => address != null;
  String get addressError {
    if (!showErrors || addressValid)
      return null;
    else
      return 'Campo obrigatório';
  }

  @observable
  bool showErrors = false;

}