// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_lojas_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CategoryLojasStore on _CategoryLojasStore, Store {
  Computed<List<Categorias>> _$allDesapegoCategoryListComputed;

  @override
  List<Categorias> get allDesapegoCategoryList =>
      (_$allDesapegoCategoryListComputed ??= Computed<List<Categorias>>(
              () => super.allDesapegoCategoryList,
              name: '_CategoryLojasStore.allDesapegoCategoryList'))
          .value;

  final _$errorAtom = Atom(name: '_CategoryLojasStore.error');

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

  final _$_CategoryLojasStoreActionController =
      ActionController(name: '_CategoryLojasStore');

  @override
  void setCategories(List<Categorias> categories) {
    final _$actionInfo = _$_CategoryLojasStoreActionController.startAction(
        name: '_CategoryLojasStore.setCategories');
    try {
      return super.setCategories(categories);
    } finally {
      _$_CategoryLojasStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setError(String value) {
    final _$actionInfo = _$_CategoryLojasStoreActionController.startAction(
        name: '_CategoryLojasStore.setError');
    try {
      return super.setError(value);
    } finally {
      _$_CategoryLojasStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
error: ${error},
allDesapegoCategoryList: ${allDesapegoCategoryList}
    ''';
  }
}
