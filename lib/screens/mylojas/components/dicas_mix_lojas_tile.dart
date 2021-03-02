import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mix_brasil/model/dicas_mix/dicas_mix_lojas.dart';

class DicasMixLojasTile extends StatelessWidget {
  DicasMixLojasTile(this.dicasMixLojas);

  final DicasMixLojas dicasMixLojas;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SizedBox(
        width: 127,
        child: CachedNetworkImage(
          imageUrl: dicasMixLojas.img,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
