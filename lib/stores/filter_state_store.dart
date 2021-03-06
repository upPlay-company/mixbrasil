import 'package:mix_brasil/model/cep/uf.dart';
import 'package:mix_brasil/repositories/ibge_repository.dart';
import 'package:mobx/mobx.dart';

part 'filter_state_store.g.dart';

class FilterStateStore = _FilterStateStore with _$FilterStateStore;

abstract class _FilterStateStore with Store {

  _FilterStateStore(){
    _loadState();
  }

  ObservableList<UF> listState = ObservableList<UF>();

  @action
  void setStates(List<UF> state) {
    listState.clear();
    listState.addAll(state);
  }

  @observable
  String error;

  @computed
  List<UF> get allStateList =>
      List.from(listState)..insert(0, UF(id: 0, name: 'Brasil'));

  @action
  void setError(String value) => error = value;

  Future<void> _loadState() async {

    final state = await IBGERepository().getUFList();

    setStates(state);
  }

}