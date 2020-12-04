import 'package:flutter/material.dart';
import 'package:mix_brasil/model/lojas/loja.dart';
import 'package:mix_brasil/screens/lojas/lojas_screen.dart';

class LojasTile extends StatelessWidget {

  final String type;
  final LojasData lojas;

  LojasTile(this.type, this.lojas);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: (){
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context)=>ProductScreen(lojas)),
          );
        },
        child: Container(
            height: 120,
            child: Card(
              color: Colors.cyan[50],
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: SizedBox(
                      width: 130,
                      height: 100,
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Image.network(
                          lojas.img.first,
                          fit: BoxFit.contain,
                        ),
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
                        SizedBox(height: 10,),
                        Text(
                          lojas.name,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800),
                        ),
                        SizedBox(height: 5,),
                        Text(
                          lojas.descricao,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Colors.grey[700]),
                        ),
                        SizedBox(height: 20,),
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
                              ' R\$${lojas.price.toStringAsFixed(2)}',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                  color: Theme.of(context).primaryColor
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ))
    );
  }
}