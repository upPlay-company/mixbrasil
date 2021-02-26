// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'myads_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MyAdsStore on _MyAdsStore, Store {
  Computed<List<Ad>> _$activeAdsComputed;

  @override
  List<Ad> get activeAds =>
      (_$activeAdsComputed ??= Computed<List<Ad>>(() => super.activeAds,
              name: '_MyAdsStore.activeAds'))
          .value;

  final _$AllAdsAtom = Atom(name: '_MyAdsStore.AllAds');

  @override
  List<Ad> get AllAds {
    _$AllAdsAtom.reportRead();
    return super.AllAds;
  }

  @override
  set AllAds(List<Ad> value) {
    _$AllAdsAtom.reportWrite(value, super.AllAds, () {
      super.AllAds = value;
    });
  }

  final _$loadingAtom = Atom(name: '_MyAdsStore.loading');

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

  final _$hideCardAtom = Atom(name: '_MyAdsStore.hideCard');

  @override
  bool get hideCard {
    _$hideCardAtom.reportRead();
    return super.hideCard;
  }

  @override
  set hideCard(bool value) {
    _$hideCardAtom.reportWrite(value, super.hideCard, () {
      super.hideCard = value;
    });
  }

  final _$soldAdAsyncAction = AsyncAction('_MyAdsStore.soldAd');

  @override
  Future<void> soldAd(Ad ad) {
    return _$soldAdAsyncAction.run(() => super.soldAd(ad));
  }

  final _$deleteAdAsyncAction = AsyncAction('_MyAdsStore.deleteAd');

  @override
  Future<void> deleteAd(Ad ad) {
    return _$deleteAdAsyncAction.run(() => super.deleteAd(ad));
  }

  final _$destacarAdAsyncAction = AsyncAction('_MyAdsStore.destacarAd');

  @override
  Future<void> destacarAd(Ad ad) {
    return _$destacarAdAsyncAction.run(() => super.destacarAd(ad));
  }

  final _$soldDestaqueAsyncAction = AsyncAction('_MyAdsStore.soldDestaque');

  @override
  Future<void> soldDestaque(Ad ad) {
    return _$soldDestaqueAsyncAction.run(() => super.soldDestaque(ad));
  }

  final _$_MyAdsStoreActionController = ActionController(name: '_MyAdsStore');

  @override
  void setHidePag(bool value) {
    final _$actionInfo = _$_MyAdsStoreActionController.startAction(
        name: '_MyAdsStore.setHidePag');
    try {
      return super.setHidePag(value);
    } finally {
      _$_MyAdsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
AllAds: ${AllAds},
loading: ${loading},
hideCard: ${hideCard},
activeAds: ${activeAds}
    ''';
  }
}
