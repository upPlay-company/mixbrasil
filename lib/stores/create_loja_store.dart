import 'package:get_it/get_it.dart';
import 'package:mix_brasil/model/categorias/categorias.dart';
import 'package:mix_brasil/model/cep/address.dart';
import 'package:mix_brasil/model/criar_loja/criar_loja.dart';
import 'package:mix_brasil/model/user/user_manager.dart';
import 'package:mix_brasil/stores/user_manager_store.dart';
import 'package:mobx/mobx.dart';

import 'cep_store.dart';

part 'create_loja_store.g.dart';

class CreateLojaStore = _CreateLojaStore with _$CreateLojaStore;

abstract class _CreateLojaStore with Store {

  _CreateLojaStore({this.adLojas}) {
    name = adLojas.name ?? '';
    promocao = adLojas.promocao ?? '';
    imgCapa = adLojas.img.asObservable();
    imgOfertas = adLojas.imgDestacadas.asObservable();
    imgStory = adLojas.imgOfertas.asObservable();
    imgCupons = adLojas.imgCupons.asObservable();
    vagaEmprego = adLojas.trabalheConosco ?? '';
    whats = adLojas.number ?? '';
    category = adLojas.category;
    priceText = adLojas.price?.toStringAsFixed(2) ?? '';
    cpfCnpjText = adLojas.cpfCnpj ?? '';

    if (adLojas.address != null)
      cepStore = CepStore(adLojas.address.zipCode);
    else
      cepStore = CepStore(null);
  }

  final AdLojas adLojas;

  ObservableList imgCapa = ObservableList();

  @computed
  bool get imgCapaValid => imgCapa.isNotEmpty;
  String get imgCapaError {
    if (!showErrors || imgCapaValid)
      return null;
    else
      return 'Insira imagens';
  }

  ObservableList imgOfertas = ObservableList();

  @computed
  bool get imgOfertasValid => imgOfertas.isNotEmpty;
  String get imgOfertasError {
    if (!showErrors || imgOfertasValid)
      return null;
    else
      return 'Insira imagens';
  }

  ObservableList imgStory = ObservableList();

  @computed
  bool get imgStoryValid => imgStory.isNotEmpty;
  String get imgStoryError {
    if (!showErrors || imgStoryValid)
      return null;
    else
      return 'Insira imagens';
  }

  ObservableList imgCupons = ObservableList();

  @computed
  bool get imgCuponsValid => imgCupons.isNotEmpty;
  String get imgCuponsError {
    if (!showErrors || imgCuponsValid)
      return null;
    else
      return 'Insira imagens';
  }

  @observable
  String name = '';

  @action
  // ignore: non_constant_identifier_names
  void SetName(String value) => name = value;

  @computed
  bool get nameValid => name.length >= 6;
  String get nameError {
    if (!showErrors || nameValid)
      return null;
    else if (name.isEmpty)
      return 'Campo obrigatório';
    else
      return 'Título muito curto';
  }

  @observable
  String promocao = '';

  @action
  // ignore: non_constant_identifier_names
  void SetPromocao(String value) => promocao = value;

  @computed
  bool get promocaoValid => promocao.length <= 30 && promocao.length >= 1;
  String get promocaoError {
    if (!showErrors || promocaoValid)
      return null;
    else if (promocao.isEmpty)
      return 'Campo obrigatório';
    else
      return 'Promoção muito grande';
  }

  @observable
  Categorias category;

  @action
  // ignore: non_constant_identifier_names
  void SetCategory(Categorias value) => category = value;

  @computed
  bool get categoryValid => category != null;
  String get categoryError {
    if (!showErrors || categoryValid)
      return null;
    else
      return 'Campo obrigatório';
  }

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
  String cpfCnpjText = '';

  @action
  void setCpfCnpj(String value) => cpfCnpjText = value;

  @computed

  bool get cpfcnpjValid => cpfCnpjText.length >= 11;
  String get cpjCnpjError {
    if(!showErrors || cpfcnpjValid){
      return null;
    } else if(cpfCnpjText.isEmpty)
      return 'Campo obrigatório';
    else {
      return 'inválido';
    }
  }

  @observable
  String priceText = '';

  @action
  void setPrice(String value) => priceText = value;

  @computed
  num get price {
    if (priceText.contains(',')) {
      return num.tryParse(priceText.replaceAll(RegExp('[^0-9]'), '')) / 100;
    } else {
      return num.tryParse(priceText);
    }
  }

  bool get priceValid => price != null && price <= 9999999;
  String get priceError {
    if (!showErrors || priceValid)
      return null;
    else if (priceText.isEmpty)
      return 'Campo obrigatório';
    else
      return 'Preço inválido';
  }

  @observable
  String vagaEmprego = '';

  @action
  // ignore: non_constant_identifier_names
  void SetVagaEmprego(String value) => vagaEmprego = value;

  @computed
  bool get vagaValid => vagaEmprego.length >= 5;
  String get vagaError {
    if (!showErrors || vagaValid)
      return null;
    else if (vagaEmprego.isEmpty)
      return 'Campo obrigatório';
    else
      return 'Descrição da vaga muito curta';
  }

  @observable
  String whats = '';

  @action
  void setWhats(String value) => whats = value;

  @computed
  bool get whatsValid => whats.length >= 11;
  String get whatsError {
    if (!showErrors || whatsValid)
      return null;
    else if (whats.isEmpty)
      return 'Campo obrigatório';
    else
      return 'Número inválido';
  }

  @computed
  bool get formValid =>
          imgCapaValid &&
          imgStoryValid &&
          imgCuponsValid &&
          imgOfertasValid&&
          promocaoValid &&
          categoryValid &&
          addressValid &&
          priceValid &&
          nameValid &&
          vagaValid &&
          cpfcnpjValid &&
          whatsValid;

  @computed
  Function get sendPressed => formValid ? _send : null;

  @observable
  bool showErrors = false;

  @action
  void invalidSendPressed() => showErrors = true;

  @observable
  String error;

  @observable
  bool loading = false;

  @observable
  bool saveAd = false;

  @action
  Future<void> _send() async {
    adLojas.name = name;
    adLojas.promocao = promocao;
    adLojas.category = category;
    adLojas.price = price;
    adLojas.img = imgCapa;
    adLojas.imgDestacadas = imgOfertas;
    adLojas.imgOfertas = imgStory;
    adLojas.imgCupons = imgCupons;
    adLojas.trabalheConosco = vagaEmprego;
    adLojas.number = whats;
    adLojas.user = GetIt.I<UserManagerStore>().user;
    adLojas.address = address;
    adLojas.cpfCnpj = cpfCnpjText;

    loading = true;
    try {
      await AdLojas().save(adLojas);
      saveAd = true;
    } catch (e) {
      error = e;
    }
    loading = false;
  }

}