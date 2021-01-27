// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_desapego_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CategoryDesapegoStore on _CategoryDesapegoStore, Store {
  Computed<List<DesapegoCategory>> _$allDesapegoCategoryListComputed;

  @override
  List<DesapegoCategory> get allDesapegoCategoryList =>
      (_$allDesapegoCategoryListComputed ??= Computed<List<DesapegoCategory>>(
              () => super.allDesapegoCategoryList,
              name: '_CategoryDesapegoStore.allDesapegoCategoryList'))
          .value;

  final _$errorAtom = Atom(name: '_CategoryDesapegoStore.error');

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

  final _$_CategoryDesapegoStoreActionController =
      ActionController(name: '_CategoryDesapegoStore');

  @override
  void setCategories(List<DesapegoCategory> categories) {
    final _$actionInfo = _$_CategoryDesapegoStoreActionController.startAction(
        name: '_CategoryDesapegoStore.setCategories');
    try {
      return super.setCategories(categories);
    } finally {
      _$_CategoryDesapegoStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setError(String value) {
    final _$actionInfo = _$_CategoryDesapegoStoreActionController.startAction(
        name: '_CategoryDesapegoStore.setError');
    try {
      return super.setError(value);
    } finally {
      _$_CategoryDesapegoStoreActionController.endAction(_$actionInfo);
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
