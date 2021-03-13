import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mix_brasil/model/desapego/desapego_destaque.dart';
import 'package:mix_brasil/model/user/user_manager.dart';
import 'package:mix_brasil/screens/desapego/components/itens_desapego_destaque.dart';
import 'package:provider/provider.dart';


class SectionDestaquesDesapego extends StatefulWidget {

  SectionDestaquesDesapego(this.desapegoDestaque);

  final DesapegoDestaque desapegoDestaque;

  @override
  _SectionDestaquesDesapegoState createState() => _SectionDestaquesDesapegoState();
}

class _SectionDestaquesDesapegoState extends State<SectionDestaquesDesapego> {

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  int counter = 0;

  void saveViews() async {
    ++counter;
    final viewsTotal = counter + widget.desapegoDestaque.views;

    DocumentReference firestoreRefUser = firestore
        .collection('users')
        .doc(widget.desapegoDestaque.idUser)
        .collection('desapegos')
        .doc(widget.desapegoDestaque.idAdsUser);

    DocumentReference firestoreRefAds = firestore
        .collection('destaque_desapego')
        .doc(widget.desapegoDestaque.id);

    await firestoreRefAds.update({'viewsDestaque': viewsTotal});
    await firestoreRefUser.update({'viewsDestaque': viewsTotal});
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
                      ItensDestaqueDesapego(widget.desapegoDestaque)),
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
                          imageUrl: widget.desapegoDestaque.img.isEmpty
                              ?
                          'https://static.thenounproject.com/png/194055-200.png'
                              :
                          widget.desapegoDestaque.img.first,
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
                                    widget.desapegoDestaque.name,
                                    style: TextStyle(
                                      fontSize: 14,
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
                                size: 12,
                                color: Colors.grey[700],
                              ),
                              Expanded(
                                child: Text(
                                  '${widget.desapegoDestaque.cidade} ${widget.desapegoDestaque?.district == null ? '' : '/'} ${widget.desapegoDestaque?.district ?? ''}',
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
                              'Criado em: ${widget.desapegoDestaque.created
                                  .toDate()
                                  .day}/${widget.desapegoDestaque.created
                                  .toDate()
                                  .month}/${widget.desapegoDestaque.created
                                  .toDate()
                                  .year}',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.grey[700]),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 2, right: 10,),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  'R\$${widget.desapegoDestaque.price
                                      .toStringAsFixed(2)}',
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
              )
          )
      );
    }

    final DateTime dateTime = DateTime.now();

    DateTime _pickedDate = widget.desapegoDestaque.created.toDate();

    final date = dateTime.difference(_pickedDate).inDays <= 6;


    if (userManager.isLoggedIn && userManager.user.idState?.initials == widget.desapegoDestaque.estado && date)
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
