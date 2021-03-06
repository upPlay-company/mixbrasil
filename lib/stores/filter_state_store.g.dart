// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_state_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FilterStateStore on _FilterStateStore, Store {
  Computed<List<UF>> _$allStateListComputed;

  @override
  List<UF> get allStateList =>
      (_$allStateListComputed ??= Computed<List<UF>>(() => super.allStateList,
              name: '_FilterStateStore.allStateList'))
          .value;

  final _$errorAtom = Atom(name: '_FilterStateStore.error');

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

  final _$_FilterStateStoreActionController =
      ActionController(name: '_FilterStateStore');

  @override
  void setStates(List<UF> state) {
    final _$actionInfo = _$_FilterStateStoreActionController.startAction(
        name: '_FilterStateStore.setStates');
    try {
      return super.setStates(state);
    } finally {
      _$_FilterStateStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setError(String value) {
    final _$actionInfo = _$_FilterStateStoreActionController.startAction(
        name: '_FilterStateStore.setError');
    try {
      return super.setError(value);
    } finally {
      _$_FilterStateStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
error: ${error},
allStateList: ${allStateList}
    ''';
  }
}
