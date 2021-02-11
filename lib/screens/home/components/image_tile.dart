import 'package:flutter/material.dart';
import 'package:mix_brasil/model/home/banners_itens.dart';
import 'package:mix_brasil/model/user/user_manager.dart';
import 'package:provider/provider.dart';

class ImageTile extends StatelessWidget {
  ImageTile(this.bannersItens);

  final BannersItens bannersItens;

  @override
  Widget build(BuildContext context) {
    final userManager = context.watch<UserManager>();

    if (userManager.isLoggedIn)
      return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            shape: BoxShape.rectangle,
            image: DecorationImage(
              image: NetworkImage(
                  bannersItens.estado == userManager.user.address.state
                      ? bannersItens.img
                      : ''),
              fit: BoxFit.cover,
            )),
      );
    else
      return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            shape: BoxShape.rectangle,
            image: DecorationImage(
              image: NetworkImage(bannersItens.img),
              fit: BoxFit.cover,
            )),
      );
  }
}
