import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mix_brasil/model/desapego/desapego.dart';
import 'itens_desapegos_screen.dart';

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
    return InkWell(
        onTap: () {
          saveViews();
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => ItensDesapegoScreen(widget.desapego)),
          );
        },
        child: Container(
            height: 120,
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            child: Card(
              elevation: 8,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 8, top: 8, bottom: 8),
                    child: SizedBox(
                      height: 135,
                      width: 127,
                      child: CachedNetworkImage(
                        imageUrl: widget.desapego.img.isEmpty ?
                        'https://static.thenounproject.com/png/194055-200.png' :
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
                          height: 10,
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
                                    fontSize: 18,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 15,
                              color: Colors.grey[700],
                            ),
                            Text(
                              widget.desapego.cidade,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.grey[700]),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 18, right: 10,),
                          child: Row(
                            children: <Widget>[
                              Text(
                                 'R\$${widget.desapego.price.toStringAsFixed(2)}',
                                textScaleFactor: 1.2,
                                 style: TextStyle(
                                   fontWeight: FontWeight.bold,
                                   color: Theme.of(context).primaryColor,
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
}
