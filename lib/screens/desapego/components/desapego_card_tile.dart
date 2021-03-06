import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mix_brasil/model/desapego/desapego.dart';
import 'itens_desapegos_screen.dart';
import 'package:provider/provider.dart';
import 'package:mix_brasil/model/user/user_manager.dart';

class DesapegoCardTile extends StatefulWidget {
  final String type;
  final DesapegoData desapego;

  DesapegoCardTile(this.type, this.desapego);

  @override
  _DesapegoCardTileState createState() => _DesapegoCardTileState();
}

class _DesapegoCardTileState extends State<DesapegoCardTile> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  int counter = 0;

  void saveViews() async {
      ++counter;
      final viewsTotal = counter + widget.desapego.views;

      DocumentReference firestoreRefUser = firestore
          .collection('users')
          .doc(widget.desapego.idUser)
          .collection('desapegos')
          .doc(widget.desapego.idAdsUser);

      DocumentReference firestoreRefAds = firestore
          .collection('desapego')
          .doc(widget.desapego.idCat)
          .collection('desapegos')
          .doc(widget.desapego.id);

      await firestoreRefAds.update({'views': viewsTotal});
      await firestoreRefUser.update({'views': viewsTotal});
  }

  @override
  Widget build(BuildContext context) {

    final userManager = context.watch<UserManager>();

      Widget lojaTile() {
        return InkWell(
            onTap: () {
              saveViews();
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) =>
                        ItensDesapegosScreen(widget.desapego)),
              );
            },
            child: Container(
                height: 130,
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                child: Card(
                  elevation: 8,
                  color: Colors.white,
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 8, top: 8, bottom: 8),
                        child: SizedBox(
                          height: 135,
                          width: 127,
                          child: CachedNetworkImage(
                            imageUrl: widget.desapego.img.isEmpty
                                ?
                            'https://static.thenounproject.com/png/194055-200.png'
                                :
                            widget.desapego.img.first,
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
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 3.0),
                                    child: Text(
                                      widget.desapego.name,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5,),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  size: 14,
                                  color: Colors.grey[700],
                                ),
                                Expanded(
                                  child: Text(
                                    '${widget.desapego.cidade} ${widget.desapego?.district == null ? '' : '/'} ${widget.desapego?.district ?? ''}',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.grey[700]),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10,),
                              child: Text(
                                'Criado em: ${widget.desapego.created
                                    .toDate()
                                    .day}/${widget.desapego.created
                                    .toDate()
                                    .month}/${widget.desapego.created
                                    .toDate()
                                    .year}',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.grey[700]),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 2, right: 10,),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    'R\$${widget.desapego.price.toStringAsFixed(
                                        2)}',
                                    textScaleFactor: 1.2,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Theme
                                          .of(context)
                                          .primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )));
      }

    if (userManager.isLoggedIn && userManager.user.idState?.initials == widget.desapego.estado)
      return lojaTile();
    else if (userManager.isLoggedIn && userManager.user.idState?.name == 'Brasil')
      return lojaTile();
    else if (userManager.isLoggedIn && userManager.user.idState?.initials == null)
      return lojaTile();
    else if (!userManager.isLoggedIn)
      return lojaTile();
    else
      return Container();
  }
}
