import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mix_brasil/model/lojas/destaque.dart';
import 'package:mix_brasil/model/lojas/loja_destaque_manager.dart';
import 'package:mix_brasil/model/user/user_manager.dart';
import 'package:mix_brasil/screens/home/components/lojas_destaques_screen.dart';
import 'package:provider/provider.dart';

class SectionDestaques extends StatelessWidget {

  final DestaqueLoja lojasDestaque;

  SectionDestaques(this.lojasDestaque);

  @override
  Widget build(BuildContext context) {
    final userManager = context.watch<UserManager>();
    if(userManager.isLoggedIn && lojasDestaque.state == userManager.user.address.state){
      return InkWell(
        onTap: () {
          if (lojasDestaque.id != null) {
            final product = context
                .read<LojasDestaqueManager>()
                .findProductByID(lojasDestaque.id);
            if (product != null) {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => LojasDestaqueScreen(lojasDestaque)),
              );
            }
          }
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
          height: 120,
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
                      imageUrl: lojasDestaque.img.isEmpty ?
                      'https://static.thenounproject.com/png/194055-200.png' :
                      lojasDestaque.img.first,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 20),
                  child: Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            lojasDestaque.name,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w800),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          lojasDestaque.promocao,
                          style: TextStyle(
                              fontSize: 13,
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
                              ' R\$${lojasDestaque.price.toStringAsFixed(2)}',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                  color: Theme.of(context).primaryColor),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    } else if(!userManager.isLoggedIn) {
      return InkWell(
        onTap: () {
          if (lojasDestaque.id != null) {
            final product = context
                .read<LojasDestaqueManager>()
                .findProductByID(lojasDestaque.id);
            if (product != null) {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => LojasDestaqueScreen(lojasDestaque)),
              );
            }
          }
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
          height: 120,
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
                      imageUrl: lojasDestaque.img.isEmpty ?
                      'https://static.thenounproject.com/png/194055-200.png' :
                      lojasDestaque.img.first,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 20),
                  child: Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            lojasDestaque.name,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w800),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          lojasDestaque.promocao,
                          style: TextStyle(
                              fontSize: 13,
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
                              ' R\$${lojasDestaque.price.toStringAsFixed(2)}',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                  color: Theme.of(context).primaryColor),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
