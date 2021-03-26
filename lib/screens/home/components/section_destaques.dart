import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mix_brasil/model/lojas/destaque.dart';
import 'package:mix_brasil/model/lojas/loja_destaque_manager.dart';
import 'package:mix_brasil/model/user/user_manager.dart';
import 'package:mix_brasil/screens/home/components/lojas_destaques_screen.dart';
import 'package:provider/provider.dart';

class SectionDestaques extends StatefulWidget {

  final String type;
  final DestaqueLoja lojasDestaque;

  SectionDestaques(this.type, this.lojasDestaque);

  @override
  _SectionDestaquesState createState() => _SectionDestaquesState();
}

class _SectionDestaquesState extends State<SectionDestaques> {
  @override
  Widget build(BuildContext context) {

    final userManager = context.watch<UserManager>();

    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    int counter = 0;

    void saveViews() async {
      ++counter;
      final viewsTotal = counter + widget.lojasDestaque.views;

      DocumentReference firestoreRefUser = firestore
          .collection('users')
          .doc(widget.lojasDestaque.idUser)
          .collection('lojas')
          .doc(widget.lojasDestaque.idAdsUser);

      DocumentReference firestoreRefAds = firestore
          .collection('destaque_home')
          .doc(widget.lojasDestaque.id);

      await firestoreRefAds.update({'views': viewsTotal});
      await firestoreRefUser.update({'viewsDestaque': viewsTotal});
    }

    Widget lojaTile() {
      return InkWell(
        onTap: () {
          saveViews();
          if (widget.lojasDestaque.id != null) {
            final product = context
                .read<LojasDestaqueManager>()
                .findProductByID(widget.lojasDestaque.id);
            if (product != null) {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => LojasDestaqueScreen(widget.lojasDestaque)),
              );
            }
          }
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
          height: 130,
          child: Card(
            elevation: 8,
            color: Colors.cyan[50],
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8, left: 8,),
                  child: SizedBox(
                    height: 135,
                    width: 127,
                    child: CachedNetworkImage(
                      imageUrl: widget.lojasDestaque.img.isEmpty ?
                      'https://static.thenounproject.com/png/194055-200.png' :
                      widget.lojasDestaque.img.first,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.lojasDestaque.name,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w800),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 14,
                              color: Colors.grey[700],
                            ),
                            Text(
                              '${widget.lojasDestaque.city}',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.grey[700]),
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              widget.lojasDestaque.promocao,
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.grey[700]),
                            ),
                            SizedBox(height: 5,),
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
                                  ' R\$${widget.lojasDestaque.price.toStringAsFixed(2)}',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w800,
                                      color: Theme
                                          .of(context)
                                          .primaryColor),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }

    final DateTime dateTime = DateTime.now();

    DateTime _pickedDate = widget.lojasDestaque.created.toDate();

    final date = dateTime.difference(_pickedDate).inDays <= 6;

    if (userManager.isLoggedIn && userManager.user.idState?.initials == widget.lojasDestaque.state && date)
      return lojaTile();
    else if (userManager.isLoggedIn && userManager.user.idState?.name == 'Brasil' && date)
      return lojaTile();
    else if (userManager.isLoggedIn && userManager.user.idState?.initials == null && date)
      return lojaTile();
    else if (!userManager.isLoggedIn && date)
      return lojaTile();
    else
      return Container();
  }
}
