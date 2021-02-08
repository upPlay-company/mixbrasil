import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mix_brasil/model/lojas/loja.dart';
import 'package:mix_brasil/model/user/user_manager.dart';
import 'package:mix_brasil/screens/lojas/lojas_screen.dart';
import 'package:provider/provider.dart';

class LojasTile extends StatefulWidget {
  final String type;
  final LojasData lojas;

  LojasTile(this.type, this.lojas);

  @override
  _LojasTileState createState() => _LojasTileState();
}

class _LojasTileState extends State<LojasTile> {
  @override
  Widget build(BuildContext context) {
    final userManager = context.watch<UserManager>();

    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    int counter = 0;

    void saveViews() async {
      ++counter;
      final viewsTotal = counter + widget.lojas.views;

      DocumentReference firestoreRefUser = firestore
          .collection('users')
          .doc(widget.lojas.idUser)
          .collection('loja')
          .doc(widget.lojas.idAdsUser);

      DocumentReference firestoreRefAds = firestore
          .collection('categorias')
          .doc(widget.lojas.idCat)
          .collection('lojas')
          .doc(widget.lojas.id);

      await firestoreRefAds.update({'views': viewsTotal});
      await firestoreRefUser.update({'views': viewsTotal});
    }

    //Declarações de funções
    Widget lojaTile() {
      return InkWell(
        onTap: () {
          saveViews();
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ProductScreen(widget.lojas)),
          );
        },
        child: Container(
          height: 120,
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
          child: Card(
            elevation: 8,
            color: Colors.cyan[50],
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 8, top: 8, bottom: 8),
                  child: SizedBox(
                    height: 135,
                    width: 127,
                    child: CachedNetworkImage(
                      imageUrl: widget.lojas.img.isEmpty ?
                      'https://static.thenounproject.com/png/194055-200.png' :
                      widget.lojas.img.first,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.lojas.name,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w800),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.lojas.promocao,
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Colors.grey[700]),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Text(
                            'A partir de',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                                color: Colors.black),
                          ),
                          Text(
                            ' R\$${widget.lojas.price.toStringAsFixed(2)}',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                                color: Theme.of(context).primaryColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }
    //Fim da Declarações de funções

    if (userManager.isLoggedIn && userManager.user.address.state == widget.lojas.state)
      return lojaTile();
    else if (!userManager.isLoggedIn)
      return lojaTile();
    /*Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => ReplaceNotLoja()),
        // retorna pra mesma pagina sem informação
      );*/
    else
      return Container();
  }
}
