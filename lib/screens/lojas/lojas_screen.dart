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
  double whiteMargin = 2.5;
  double imageMargin = 4.0;

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;

    return Stack(
      children: [
        Scaffold(
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
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.arrow_back),
            backgroundColor: Theme.of(context).primaryColor,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        ),
        Positioned(
          top: 240,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20), topLeft: Radius.circular(20)),
            ),
            child: Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
        height: 70,
        width: 70,
        margin: EdgeInsets.only(top: 15),
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
