import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
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

  String image;
  double imageSize = 60.0;
  double whiteMargin = 2.5;
  double imageMargin = 4.0;

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            toolbarHeight: 0.0,
            toolbarOpacity: 0.0,
            bottomOpacity: 0.0,
            backgroundColor: Colors.transparent,
          ),
          body: ListView(
            children: <Widget>[
              AspectRatio(
                aspectRatio: 1.3,
                child: Carousel(
                  images: lojas.img.map((url) {
                    return NetworkImage(url);
                  }).toList(),
                  dotSize: 4.0,
                  dotSpacing: 15.0,
                  dotBgColor: Colors.transparent,
                  dotColor: primaryColor,
                  autoplay: false,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 240,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.amber,
            child: Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      story("Ofertas"),
                      story("Eletros"),
                      story("Cupons"),
                      story("Trabalhe"),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget story(String title) {
    return GestureDetector(
      child: Container(
        height: this.imageSize,
        width: this.imageSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: SweepGradient(
            colors: [
              Colors.cyan,
              Colors.red,
              Colors.amber,
              Colors.grey,
              Colors.green,
            ],
          ),
        ),

        // White background container between image and gradient
        child: Container(
          margin: EdgeInsets.all(whiteMargin),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),

          // Image container
          child: FittedBox(
            child: Container(
              margin: EdgeInsets.all(imageMargin),
              height: 20.0,
              width: 20.0,
              decoration: BoxDecoration(
                // borderRadius: BorderRadius.circular(50.0),
                shape: BoxShape.circle,
              ),
            ),
          ),
          // Image container
          //
        ),
      ),
    );
  }
}
