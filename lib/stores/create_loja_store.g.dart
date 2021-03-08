// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_loja_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CreateLojaStore on _CreateLojaStore, Store {
  Computed<bool> _$imgCapaValidComputed;

  @override
  bool get imgCapaValid =>
      (_$imgCapaValidComputed ??= Computed<bool>(() => super.imgCapaValid,
              name: '_CreateLojaStore.imgCapaValid'))
          .value;
  Computed<bool> _$imgOfertasValidComputed;

  @override
  bool get imgOfertasValid =>
      (_$imgOfertasValidComputed ??= Computed<bool>(() => super.imgOfertasValid,
              name: '_CreateLojaStore.imgOfertasValid'))
          .value;
  Computed<bool> _$imgStoryValidComputed;

  @override
  bool get imgStoryValid =>
      (_$imgStoryValidComputed ??= Computed<bool>(() => super.imgStoryValid,
              name: '_CreateLojaStore.imgStoryValid'))
          .value;
  Computed<bool> _$imgCuponsValidComputed;

  @override
  bool get imgCuponsValid =>
      (_$imgCuponsValidComputed ??= Computed<bool>(() => super.imgCuponsValid,
              name: '_CreateLojaStore.imgCuponsValid'))
          .value;
  Computed<bool> _$nameValidComputed;

  @override
  bool get nameValid =>
      (_$nameValidComputed ??= Computed<bool>(() => super.nameValid,
              name: '_CreateLojaStore.nameValid'))
          .value;
  Computed<bool> _$promocaoValidComputed;

  @override
  bool get promocaoValid =>
      (_$promocaoValidComputed ??= Computed<bool>(() => super.promocaoValid,
              name: '_CreateLojaStore.promocaoValid'))
          .value;
  Computed<bool> _$categoryValidComputed;

  @override
  bool get categoryValid =>
      (_$categoryValidComputed ??= Computed<bool>(() => super.categoryValid,
              name: '_CreateLojaStore.categoryValid'))
          .value;
  Computed<Address> _$addressComputed;

  @override
  Address get address =>
      (_$addressComputed ??= Computed<Address>(() => super.address,
              name: '_CreateLojaStore.address'))
          .value;
  Computed<bool> _$cpfcnpjValidComputed;

  @override
  bool get cpfcnpjValid =>
      (_$cpfcnpjValidComputed ??= Computed<bool>(() => super.cpfcnpjValid,
              name: '_CreateLojaStore.cpfcnpjValid'))
          .value;
  Computed<num> _$priceComputed;

  @override
  num get price => (_$priceComputed ??=
          Computed<num>(() => super.price, name: '_CreateLojaStore.price'))
      .value;
  Computed<bool> _$vagaValidComputed;

  @override
  bool get vagaValid =>
      (_$vagaValidComputed ??= Computed<bool>(() => super.vagaValid,
              name: '_CreateLojaStore.vagaValid'))
          .value;
  Computed<bool> _$whatsValidComputed;

  @override
  bool get whatsValid =>
      (_$whatsValidComputed ??= Computed<bool>(() => super.whatsValid,
              name: '_CreateLojaStore.whatsValid'))
          .value;
  Computed<bool> _$formValidComputed;

  @override
  bool get formValid =>
      (_$formValidComputed ??= Computed<bool>(() => super.formValid,
              name: '_CreateLojaStore.formValid'))
          .value;
  Computed<Function> _$sendPressedComputed;

  @override
  Function get sendPressed =>
      (_$sendPressedComputed ??= Computed<Function>(() => super.sendPressed,
              name: '_CreateLojaStore.sendPressed'))
          .value;

  final _$nameAtom = Atom(name: '_CreateLojaStore.name');

  @override
  String get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  final _$promocaoAtom = Atom(name: '_CreateLojaStore.promocao');

  @override
  String get promocao {
    _$promocaoAtom.reportRead();
    return super.promocao;
  }

  @override
  set promocao(String value) {
    _$promocaoAtom.reportWrite(value, super.promocao, () {
      super.promocao = value;
    });
  }

  final _$categoryAtom = Atom(name: '_CreateLojaStore.category');

  @override
  Categorias get category {
    _$categoryAtom.reportRead();
    return super.category;
  }

  @override
  set category(Categorias value) {
    _$categoryAtom.reportWrite(value, super.category, () {
      super.category = value;
    });
  }

  final _$cpfCnpjTextAtom = Atom(name: '_CreateLojaStore.cpfCnpjText');

  @override
  String get cpfCnpjText {
    _$cpfCnpjTextAtom.reportRead();
    return super.cpfCnpjText;
  }

  @override
  set cpfCnpjText(String value) {
    _$cpfCnpjTextAtom.reportWrite(value, super.cpfCnpjText, () {
      super.cpfCnpjText = value;
    });
  }

  final _$priceTextAtom = Atom(name: '_CreateLojaStore.priceText');

  @override
  String get priceText {
    _$priceTextAtom.reportRead();
    return super.priceText;
  }

  @override
  set priceText(String value) {
    _$priceTextAtom.reportWrite(value, super.priceText, () {
      super.priceText = value;
    });
  }

  final _$vagaEmpregoAtom = Atom(name: '_CreateLojaStore.vagaEmprego');

  @override
  String get vagaEmprego {
    _$vagaEmpregoAtom.reportRead();
    return super.vagaEmprego;
  }

  @override
  set vagaEmprego(String value) {
    _$vagaEmpregoAtom.reportWrite(value, super.vagaEmprego, () {
      super.vagaEmprego = value;
    });
  }

  final _$whatsAtom = Atom(name: '_CreateLojaStore.whats');

  @override
  String get whats {
    _$whatsAtom.reportRead();
    return super.whats;
  }

  @override
  set whats(String value) {
    _$whatsAtom.reportWrite(value, super.whats, () {
      super.whats = value;
    });
  }

  final _$showErrorsAtom = Atom(name: '_CreateLojaStore.showErrors');

  @override
  bool get showErrors {
    _$showErrorsAtom.reportRead();
    return super.showErrors;
  }

  @override
  set showErrors(bool value) {
    _$showErrorsAtom.reportWrite(value, super.showErrors, () {
      super.showErrors = value;
    });
  }

  final _$errorAtom = Atom(name: '_CreateLojaStore.error');

  @override
  String get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(String value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  final _$loadingAtom = Atom(name: '_CreateLojaStore.loading');

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  final _$saveAdAtom = Atom(name: '_CreateLojaStore.saveAd');

  @override
  bool get saveAd {
    _$saveAdAtom.reportRead();
    return super.saveAd;
  }

  @override
  set saveAd(bool value) {
    _$saveAdAtom.reportWrite(value, super.saveAd, () {
      super.saveAd = value;
    });
  }

  final _$_sendAsyncAction = AsyncAction('_CreateLojaStore._send');

  @override
  Future<void> _send() {
    return _$_sendAsyncAction.run(() => super._send());
  }

  final _$_CreateLojaStoreActionController =
      ActionController(name: '_CreateLojaStore');

  @override
  void SetName(String value) {
    final _$actionInfo = _$_CreateLojaStoreActionController.startAction(
        name: '_CreateLojaStore.SetName');
    try {
      return super.SetName(value);
    } finally {
      _$_CreateLojaStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void SetPromocao(String value) {
    final _$actionInfo = _$_CreateLojaStoreActionController.startAction(
        name: '_CreateLojaStore.SetPromocao');
    try {
      return super.SetPromocao(value);
    } finally {
      _$_CreateLojaStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void SetCategory(Categorias value) {
    final _$actionInfo = _$_CreateLojaStoreActionController.startAction(
        name: '_CreateLojaStore.SetCategory');
    try {
      return super.SetCategory(value);
    } finally {
      _$_CreateLojaStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCpfCnpj(String value) {
    final _$actionInfo = _$_CreateLojaStoreActionController.startAction(
        name: '_CreateLojaStore.setCpfCnpj');
    try {
      return super.setCpfCnpj(value);
    } finally {
      _$_CreateLojaStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPrice(String value) {
    final _$actionInfo = _$_CreateLojaStoreActionController.startAction(
        name: '_CreateLojaStore.setPrice');
    try {
      return super.setPrice(value);
    } finally {
      _$_CreateLojaStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void SetVagaEmprego(String value) {
    final _$actionInfo = _$_CreateLojaStoreActionController.startAction(
        name: '_CreateLojaStore.SetVagaEmprego');
    try {
      return super.SetVagaEmprego(value);
    } finally {
      _$_CreateLojaStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setWhats(String value) {
    final _$actionInfo = _$_CreateLojaStoreActionController.startAction(
        name: '_CreateLojaStore.setWhats');
    try {
      return super.setWhats(value);
    } finally {
      _$_CreateLojaStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void invalidSendPressed() {
    final _$actionInfo = _$_CreateLojaStoreActionController.startAction(
        name: '_CreateLojaStore.invalidSendPressed');
    try {
      return super.invalidSendPressed();
    } finally {
      _$_CreateLojaStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
name: ${name},
promocao: ${promocao},
category: ${category},
cpfCnpjText: ${cpfCnpjText},
priceText: ${priceText},
vagaEmprego: ${vagaEmprego},
whats: ${whats},
showErrors: ${showErrors},
error: ${error},
loading: ${loading},
saveAd: ${saveAd},
imgCapaValid: ${imgCapaValid},
imgOfertasValid: ${imgOfertasValid},
imgStoryValid: ${imgStoryValid},
imgCuponsValid: ${imgCuponsValid},
nameValid: ${nameValid},
promocaoValid: ${promocaoValid},
categoryValid: ${categoryValid},
address: ${address},
cpfcnpjValid: ${cpfcnpjValid},
price: ${price},
vagaValid: ${vagaValid},
whatsValid: ${whatsValid},
formValid: ${formValid},
sendPressed: ${sendPressed}
    ''';
  }
}
