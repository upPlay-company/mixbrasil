import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:mix_brasil/model/lojas/loja.dart';

class ProductScreen extends StatefulWidget {

  final LojasData lojas;

  ProductScreen(this.lojas);

  @override
  _ProductScreenState createState() => _ProductScreenState(lojas);
}

class _ProductScreenState extends State<ProductScreen> {

  final LojasData lojas;

  _ProductScreenState(this.lojas);

  @override
  Widget build(BuildContext context) {

    final Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: Text(lojas.name),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 0.9,
            child: Carousel(
              images: lojas.img.map((url){
                return NetworkImage(url);
              }).toList(),
              dotSize: 4.0,
              dotSpacing: 15.0,
              dotBgColor: Colors.transparent,
              dotColor: primaryColor,
              autoplay: false,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  lojas.descricao,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 3,
                ),
                Text(
                  "R\$ ${lojas.price.toStringAsFixed(2)}",
                  style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: primaryColor
                  ),
                ),
                SizedBox(height: 16.0,),
                Text(
                  "Tamanho",
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
