import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mix_brasil/model/anuncio/ad.dart';
import 'package:mix_brasil/helpers/extensions.dart';
import 'package:mix_brasil/screens/criar_anuncio/criar_anuncio_screen.dart';
import 'package:mix_brasil/stores/myads_store.dart';

class DestacadoTile extends StatelessWidget {

  DestacadoTile(this.ad, this.store);
  final Ad ad;
  final MyAdsStore store;

  final List<MenuChoice> choices = [
    MenuChoice(index: 0, title: 'Já vendi', iconData: Icons.thumb_up),
    MenuChoice(index: 1, title: 'Excluir', iconData: Icons.delete)
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
      child: Card(
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
                    imageUrl: ad.images.isEmpty ?
                    'https://static.thenounproject.com/png/194055-200.png' :
                    ad.images.first,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        ad.title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Text(
                        ad.price.formattedMoney(),
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 15),
                      ),
                      Text(
                        '${ad.views} visitas',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[800],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  PopupMenuButton<MenuChoice>(
                    onSelected: (choice) {
                      switch (choice.index) {
                        case 0:
                          soldAd(context);
                          break;
                        case 1:
                          deleteAd(context);
                          break;
                      }
                    },
                    icon: Icon(
                      Icons.more_vert,
                      size: 20,
                      color: Theme.of(context).primaryColor,
                    ),
                    itemBuilder: (_) {
                      return choices
                          .map(
                            (choice) =>
                            PopupMenuItem<MenuChoice>(
                              value: choice,
                              child: Row(
                                children: [
                                  Icon(
                                    choice.iconData,
                                    size: 20,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    choice.title,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                      ).toList();
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

  Future<void> editAd(BuildContext context) async {
    final success = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => CriarAnuncioScreen(ad: ad),
      ),
    );
    if (success != null && success) store.refresh();
  }
  void soldAd(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Vendido'),
        content: Text('Confirmar a venda de ${ad.title}?'),
        actions: [
          TextButton(
            onPressed: Navigator.of(context).pop,
            child: Text('Não', style: TextStyle(color: Theme.of(context).primaryColor,),),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              store.soldDestaque(ad);
            },
            child: Text('Sim', style: TextStyle(color: Colors.red),),
          ),
        ],
      ),
    );
  }

  void deleteAd(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) =>
          AlertDialog(
            title: Text('Excluir'),
            content: Text('Confirmar a exclusão de ${ad.title}?'),
            actions: [
              TextButton(
                onPressed: Navigator
                    .of(context)
                    .pop,
                child: Text('Não', style: TextStyle(color: Theme
                    .of(context)
                    .primaryColor,)
                  ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  store.deleteAd(ad);
                },
                child: Text('Sim', style: TextStyle(color: Colors.red),),
              ),
            ],
          ),
    );
  }
}

class MenuChoice {
  MenuChoice({this.index, this.title, this.iconData});

  final int index;
  final String title;
  final IconData iconData;
}
