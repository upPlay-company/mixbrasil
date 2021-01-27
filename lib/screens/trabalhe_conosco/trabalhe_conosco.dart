import 'package:flutter/material.dart';


class TrabalheConosco extends StatelessWidget {
  final dynamic title = "Trabalhe Conosco";
  String conteudo = "teste";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: title,
      ),
      body: Container(
        child: RichText(
          text: TextSpan(
            text: 'Descrição ',
            style: DefaultTextStyle.of(context).style,
            children: <TextSpan>[
              TextSpan(text: conteudo??"Não a vagas", style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: ' world!'),
            ],
          ),
        ),
      ),
    );
  }
}
