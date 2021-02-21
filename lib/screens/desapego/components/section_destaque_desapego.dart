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
  @override
  Widget build(BuildContext context) {

    final userManager = context.watch<UserManager>();

    if(userManager.isLoggedIn && userManager.user.address.state == widget.desapegoDestaque.estado)
      return InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => ItensDestaqueDesapego(widget.desapegoDestaque)),
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
                          imageUrl: widget.desapegoDestaque.img.isEmpty ?
                          'https://static.thenounproject.com/png/194055-200.png' :
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
                              Text(
                                '${widget.desapegoDestaque.cidade}/${userManager.user.address.district}',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.grey[700]),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20,),
                            child: Text(
                              'Criado em: ${widget.desapegoDestaque.created.toDate().day}/${widget.desapegoDestaque.created.toDate().month}/${widget.desapegoDestaque.created.toDate().year}',
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
                                  'R\$${widget.desapegoDestaque.price.toStringAsFixed(2)}',
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
              )
          )
      );
    else if(!userManager.isLoggedIn)
      return InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => ItensDestaqueDesapego(widget.desapegoDestaque)),
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
                        imageUrl: widget.desapegoDestaque.img.isEmpty ?
                        'https://static.thenounproject.com/png/194055-200.png' :
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
                            Text(
                              '${widget.desapegoDestaque.cidade}',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.grey[700]),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20,),
                          child: Text(
                            'Criado em: ${widget.desapegoDestaque.created.toDate().day}/${widget.desapegoDestaque.created.toDate().month}/${widget.desapegoDestaque.created.toDate().year}',
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
                                'R\$${widget.desapegoDestaque.price.toStringAsFixed(2)}',
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
    else
      return Container();
  }
}
