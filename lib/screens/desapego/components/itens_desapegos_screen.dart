import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:mix_brasil/model/desapego/desapego.dart';
import 'package:flutter/cupertino.dart';

class ItensDesapegoScreen extends StatefulWidget {

  final DesapegoData desapego;

  ItensDesapegoScreen(this.desapego);

  @override
  _ItensDesapegoScreenState createState() => _ItensDesapegoScreenState(desapego);
}

class _ItensDesapegoScreenState extends State<ItensDesapegoScreen> {
  final DesapegoData desapego;
  _ItensDesapegoScreenState(this.desapego);

  String url =
      "https://st.depositphotos.com/1186248/2240/i/950/depositphotos_22400321-stock-photo-100-percent-rubber-stamp.jpg";

  double whiteMargin = 2.5;

  double imageMargin = 4.0;

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: FloatingActionButton(
          child: Icon(Icons.arrow_back),
          backgroundColor: Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0))),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      body: ListView(
        children: [
          Container(
            child: AspectRatio(
              aspectRatio: 1.3,
              child: Carousel(
                images: widget.desapego.img.map((url) {
                  return NetworkImage(url);
                }).toList(),
                dotSize: 4.0,
                dotSpacing: 15.0,
                dotBgColor: Colors.transparent,
                dotColor: primaryColor,
                autoplay: true,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                topLeft: Radius.circular(30),
              ),
            ),
            child: Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[

                    ],
                  ),
                  styleButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget styleButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: SizedBox(
        width: 120,
        height: 40,
        child: Container(
          child: Center(
            child: Text(
              "Ofertas",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          decoration: BoxDecoration(
            //color: Theme.of(context).secondaryHeaderColor,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
          ),
        ),
      ),
    );
  }

  Widget story(String title, Widget rota) {
    return GestureDetector(
      onTap: () {
        /*Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => rota),
        );*/
      },
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
              child: Text(
                title,
                style: TextStyle(fontSize: 5),
                textAlign: TextAlign.center,
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