import 'package:flutter/material.dart';
import 'package:mix_brasil/model/lojas/loja.dart';

class TrabalheConosco extends StatelessWidget {

  TrabalheConosco(this.lojas);

  final LojasData lojas;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.topRight,
          child: Text("Trabalhe Conosco"),
        ),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "DESCRIÇÃO",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                lojas.trabalheConosco,
                style: TextStyle(
                  fontSize: 15,
                  color: Color(0xFF868a9b),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
