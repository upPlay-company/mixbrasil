import 'package:get_it/get_it.dart';
import 'package:mix_brasil/model/anuncio/ad.dart';
import 'package:mix_brasil/model/cep/address.dart';
import 'package:mix_brasil/model/desapego/desapego_category.dart';
import 'package:mix_brasil/stores/user_manager_store.dart';
import 'package:mobx/mobx.dart';
import 'cep_store.dart';

part 'create_store.g.dart';

class CreateStore = _CreateStore with _$CreateStore;

abstract class _CreateStore with Store {
  _CreateStore({this.ad}) {
    title = ad.title ?? '';
    description = ad.description ?? '';
    images = ad.images.asObservable();
    category = ad.category;
    priceText = ad.price?.toStringAsFixed(2) ?? '';

    if (ad.address != null)
      cepStore = CepStore(ad.address.zipCode);
    else
      cepStore = CepStore(null);
  }

  final Ad ad;

  ObservableList images = ObservableList();

  @computed
  bool get imagesValid => images.isNotEmpty;
  String get imagesError {
    if (!showErrors || imagesValid)
      return null;
    else
      return 'Insira imagens';
  }

  @observable
  String title = '';

  @action
  void setTitle(String value) => title = value;

  @computed
  bool get titleValid => title.length <= 30;
  String get titleError {
    if (!showErrors || titleValid)
      return null;
    else if (title.isEmpty)
      return 'Campo obrigatório';
    else
      return 'Título muito grande';
  }

  @observable
  String description = '';

  @action
  void setDescription(String value) => description = value;

  @computed
  bool get descriptionValid => description.length > 10;
  String get descriptionError {
    if (!showErrors || descriptionValid)
      return null;
    else if (description.isEmpty)
      return 'Campo obrigatório';
    else
      return 'Descrição muito curta';
  }

  @observable
  DesapegoCategory category;

  @action
  void setCategory(DesapegoCategory value) => category = value;

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

  @computed
  bool get formValid =>
          imagesValid &&
          titleValid &&
          descriptionValid &&
          categoryValid &&
          addressValid &&
          priceValid;

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
    ad.title = title;
    ad.category = category;
    ad.description = description;
    ad.price = price;
    ad.images = images;
    ad.address = address;
    ad.user = GetIt.I<UserManagerStore>().user;

    loading = true;
    try {
      await Ad().save(ad);
      saveAd = true;
    } catch (e) {
      error = e;
    }
    loading = false;
  }

}