import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mix_brasil/model/anuncio/ad.dart';
import 'package:mix_brasil/helpers/extensions.dart';
import 'package:mix_brasil/screens/criar_anuncio/criar_anuncio_screen.dart';
import 'package:mix_brasil/stores/myads_store.dart';
import 'package:mix_brasil/screens/myads/components/hide_pag.dart';

class ActiveTile extends StatelessWidget {

  ActiveTile(this.ad, this.store);
  final Ad ad;
  final MyAdsStore store;

  final List<MenuChoice> choices = [
    MenuChoice(index: 0, title: 'Editar', iconData: Icons.edit),
    MenuChoice(index: 1, title: 'Já vendi', iconData: Icons.thumb_up),
    MenuChoice(index: 2, title: 'Excluir', iconData: Icons.delete)
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
                          fontSize: 14,
                          color: Colors.grey[800],
                        ),
                      ),
                      GestureDetector(
                        onTap: (){destacarAd(context);},
                        child: Text(
                          'Destacar anúncio',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15, color: Theme.of(context).primaryColor
                          ),
                        ),
                      )
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
                          editAd(context);
                          break;
                        case 1:
                          soldAd(context);
                          break;
                        case 2:
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
          FlatButton(
            onPressed: Navigator.of(context).pop,
            child: Text('Não'),
            textColor: Theme.of(context).primaryColor,
          ),
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
              store.soldAd(ad);
            },
            child: Text('Sim'),
            textColor: Colors.red,
          ),
        ],
      ),
    );
  }

  void deleteAd(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Excluir'),
        content: Text('Confirmar a exclusão de ${ad.title}?'),
        actions: [
          FlatButton(
            onPressed: Navigator.of(context).pop,
            child: Text('Não'),
            textColor: Theme.of(context).primaryColor,
          ),
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
              store.deleteAd(ad);
            },
            child: Text('Sim'),
            textColor: Colors.red,
          ),
        ],
      ),
    );
  }
  void destacarAd(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Destacar anúncio'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Venda mais rápido destacando o anúncio ${ad.title} por apenas R\$5,99 por 7 dias!'),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text('Escolha uma forma de pagamento:'),
            ),
            HidePag(store: store),
          ],
        ),
        actions: [
          FlatButton(
            onPressed: Navigator.of(context).pop,
            child: Text('Não'),
            textColor: Colors.red,
          ),
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
              store.destacarAd(ad);
              showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text('Mensagem enviado com sucesso'),
                    content: Text('Olá, recebemos sua mensagem para destacar o anúncio ${ad.title}, enviaremos o link para pagamento no e-mail ou telefone cadastrado.'),
                    actions: [
                      FlatButton(
                        onPressed: Navigator.of(context).pop,
                        child: Text('Ok'),
                        textColor: Theme.of(context).primaryColor,
                      ),
                    ],
                  ),
              );
            },
            child: Text('Sim'),
            textColor: Theme.of(context).primaryColor,
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
