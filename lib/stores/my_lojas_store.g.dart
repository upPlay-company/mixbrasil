// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_lojas_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MyLojasStore on _MyLojasStore, Store {
  Computed<List<AdLojas>> _$activeAdsComputed;

  @override
  List<AdLojas> get activeAds =>
      (_$activeAdsComputed ??= Computed<List<AdLojas>>(() => super.activeAds,
              name: '_MyLojasStore.activeAds'))
          .value;

  final _$AllAdsAtom = Atom(name: '_MyLojasStore.AllAds');

  @override
  List<AdLojas> get AllAds {
    _$AllAdsAtom.reportRead();
    return super.AllAds;
  }

  @override
  set AllAds(List<AdLojas> value) {
    _$AllAdsAtom.reportWrite(value, super.AllAds, () {
      super.AllAds = value;
    });
  }

  final _$loadingAtom = Atom(name: '_MyLojasStore.loading');

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

  @override
  String toString() {
    return '''
AllAds: ${AllAds},
loading: ${loading},
activeAds: ${activeAds}
    ''';
  }
}
