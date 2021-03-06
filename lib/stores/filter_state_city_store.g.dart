// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_state_city_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FilterStateCityStore on _FilterStateCityStore, Store {
  Computed<bool> _$stateValidComputed;

  @override
  bool get stateValid =>
      (_$stateValidComputed ??= Computed<bool>(() => super.stateValid,
              name: '_FilterStateCityStore.stateValid'))
          .value;
  Computed<bool> _$formValidComputed;

  @override
  bool get formValid =>
      (_$formValidComputed ??= Computed<bool>(() => super.formValid,
              name: '_FilterStateCityStore.formValid'))
          .value;
  Computed<Function> _$sendPressedComputed;

  @override
  Function get sendPressed =>
      (_$sendPressedComputed ??= Computed<Function>(() => super.sendPressed,
              name: '_FilterStateCityStore.sendPressed'))
          .value;

  final _$ufAtom = Atom(name: '_FilterStateCityStore.uf');

  @override
  UF get uf {
    _$ufAtom.reportRead();
    return super.uf;
  }

  @override
  set uf(UF value) {
    _$ufAtom.reportWrite(value, super.uf, () {
      super.uf = value;
    });
  }

  final _$showErrorsAtom = Atom(name: '_FilterStateCityStore.showErrors');

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

  final _$saveStateAtom = Atom(name: '_FilterStateCityStore.saveState');

  @override
  bool get saveState {
    _$saveStateAtom.reportRead();
    return super.saveState;
  }

  @override
  set saveState(bool value) {
    _$saveStateAtom.reportWrite(value, super.saveState, () {
      super.saveState = value;
    });
  }

  final _$_sendAsyncAction = AsyncAction('_FilterStateCityStore._send');

  @override
  Future<void> _send() {
    return _$_sendAsyncAction.run(() => super._send());
  }

  final _$_FilterStateCityStoreActionController =
      ActionController(name: '_FilterStateCityStore');

  @override
  void setState(UF value) {
    final _$actionInfo = _$_FilterStateCityStoreActionController.startAction(
        name: '_FilterStateCityStore.setState');
    try {
      return super.setState(value);
    } finally {
      _$_FilterStateCityStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void invalidSendPressed() {
    final _$actionInfo = _$_FilterStateCityStoreActionController.startAction(
        name: '_FilterStateCityStore.invalidSendPressed');
    try {
      return super.invalidSendPressed();
    } finally {
      _$_FilterStateCityStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
uf: ${uf},
showErrors: ${showErrors},
saveState: ${saveState},
stateValid: ${stateValid},
formValid: ${formValid},
sendPressed: ${sendPressed}
    ''';
  }
}
