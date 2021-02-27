import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mix_brasil/common/empty_card.dart';
import 'package:mix_brasil/stores/favorite_store.dart';

import 'favorite_tile.dart';


class FavoritosScreen extends StatelessWidget {
  FavoritosScreen({this.hideDrawer = false});

  final bool hideDrawer;

  final FavoriteStore favoriteStore = FavoriteStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('FAVORITOS', style: TextStyle(color: Colors.white, fontSize: 16),),
        centerTitle: true,
        elevation: 0,
      ),
      body: Observer(builder: (_) {
        if (favoriteStore.favoriteList.isEmpty)
          return EmptyCard('Nenhum anúncio favoritado.');

        return ListView.builder(
          padding: const EdgeInsets.all(2),
          itemCount: favoriteStore.favoriteList.length,
          itemBuilder: (_, index) =>
              FavoriteTile(favoriteStore.favoriteList[index]),
        );
      }),
    );
  }
}
