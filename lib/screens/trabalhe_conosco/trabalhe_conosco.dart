import 'package:flutter/material.dart';


class TrabalheConosco extends StatelessWidget {
  final dynamic title = "Trabalhe Conosco";

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
              TextSpan(text: 'Disponibilidade de horario', style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: ' world!'),
            ],
          ),
        ),
      ),
    );
  }
}
