import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mix_brasil/model/criar_loja/criar_loja.dart';
import 'package:mix_brasil/stores/my_lojas_store.dart';

class DestacadolojasTile extends StatelessWidget {

  DestacadolojasTile(this.adLojas, this.store);
  final AdLojas adLojas;
  final MyLojasStore store;

  final List<MenuChoice> choices = [
    MenuChoice(index: 0, title: 'Excluir', iconData: Icons.delete)
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
                    imageUrl: adLojas.img.isEmpty ?
                    'https://static.thenounproject.com/png/194055-200.png' :
                    adLojas.img.first,
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
                        adLojas.name,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Text(
                        'Cliques na Loja: ${adLojas.views}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[800],
                        ),
                      ),
                      Text(
                        'Cliques WhatsApp: ${adLojas.viewsWhats}',
                        style: TextStyle(
                          fontSize: 14,
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

  void deleteAd(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) =>
          AlertDialog(
            title: Text('Excluir'),
            content: Text('Confirmar a exclusão de ${adLojas.name}?'),
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
                  //store.deleteAd(ad);
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
