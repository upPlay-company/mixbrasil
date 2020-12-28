import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ItemCardWidget extends StatelessWidget {
  String urlImagem ="https://concursos.rhsconsult.com.br/logo/1606161749_produtodeteste95120200210124955.png";
  Widget description;

  ItemCardWidget({this.urlImagem, this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  bottomLeft: Radius.circular(5),
                ),
                child: Image.network(
                  "https://concursos.rhsconsult.com.br/logo/1606161749_produtodeteste95120200210124955.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: description,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
