import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mix_brasil/model/desapego/desapego.dart';
import 'package:mix_brasil/screens/desapego/components/itens_desapegos_screen.dart';
import 'package:mix_brasil/stores/favorite_store.dart';
import 'package:mix_brasil/helpers/extensions.dart';

class FavoriteTile extends StatelessWidget {
  FavoriteTile(this.desapego);

  final DesapegoData desapego;
  final FavoriteStore favoriteStore = FavoriteStore();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => ItensDesapegosScreen(desapego)));
      },
      child: Container(
        height: 135,
        margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
        child: Card(
          clipBehavior: Clip.antiAlias,
          elevation: 8,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 135,
                  width: 127,
                  child: CachedNetworkImage(
                    imageUrl: desapego.img.isEmpty
                        ? 'https://static.thenounproject.com/png/194055-200.png'
                        : desapego.img.first,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        desapego.name,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        desapego.price.formattedMoney(),
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                          GestureDetector(
                            onTap: () => favoriteStore.deleteFavorite(desapego),
                            child: Icon(
                              Icons.delete_outline,
                              color: Colors.grey,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
