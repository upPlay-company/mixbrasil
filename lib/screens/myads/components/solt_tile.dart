import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mix_brasil/model/anuncio/ad.dart';
import 'package:mix_brasil/stores/myads_store.dart';
import 'package:mix_brasil/helpers/extensions.dart';


class SoldTile extends StatelessWidget {
  SoldTile(this.ad, this.store);

  final Ad ad;
  final MyAdsStore store;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 8,
        child: Container(
          height: 120,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 135,
                  width: 127,
                  child: CachedNetworkImage(
                    imageUrl: ad.images.isEmpty
                        ? 'https://static.thenounproject.com/png/194055-200.png'
                        : ad.images.first,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        ad.title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      Text(
                        ad.price.formattedMoney(),
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  IconButton(
                    icon: Icon(Icons.delete),
                    iconSize: 20,
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      store.deleteAd(ad);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
