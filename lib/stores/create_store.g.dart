// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CreateStore on _CreateStore, Store {
  Computed<Address> _$addressComputed;

  @override
  Address get address => (_$addressComputed ??=
          Computed<Address>(() => super.address, name: '_CreateStore.address'))
      .value;

  final _$categoryAtom = Atom(name: '_CreateStore.category');

  @override
  DesapegoCategory get category {
    _$categoryAtom.reportRead();
    return super.category;
  }

  @override
  set category(DesapegoCategory value) {
    _$categoryAtom.reportWrite(value, super.category, () {
      super.category = value;
    });
  }

  final _$showErrorsAtom = Atom(name: '_CreateStore.showErrors');

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

  final _$_CreateStoreActionController = ActionController(name: '_CreateStore');

  @override
  void setCategory(DesapegoCategory value) {
    final _$actionInfo = _$_CreateStoreActionController.startAction(
        name: '_CreateStore.setCategory');
    try {
      return super.setCategory(value);
    } finally {
      _$_CreateStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
category: ${category},
showErrors: ${showErrors},
address: ${address}
    ''';
  }
}
