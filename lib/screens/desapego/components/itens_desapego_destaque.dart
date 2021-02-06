import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mix_brasil/model/desapego/desapego_destaque.dart';
import 'package:url_launcher/url_launcher.dart';

class ItensDestaqueDesapego extends StatefulWidget {

  final DesapegoDestaque desapegoDestaque;

  ItensDestaqueDesapego(this.desapegoDestaque);

  @override
  _ItensDestaqueDesapegoState createState() =>
      _ItensDestaqueDesapegoState(desapegoDestaque);
}

class _ItensDestaqueDesapegoState extends State<ItensDestaqueDesapego> {

  final DesapegoDestaque desapegoDestaque;
  String nameAnuciante = "mauricio";


  _ItensDestaqueDesapegoState(this.desapegoDestaque);

  @override
  Widget build(BuildContext context) {
    final clearNumber = desapegoDestaque.number.replaceAll(RegExp('[^0-9]'), '');
    final Color primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      backgroundColor: Colors.white,
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
          Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width,
                child: Carousel(
                  images: widget.desapegoDestaque.img.map((url) {
                    return NetworkImage(url);
                  }).toList(),
                  dotSize: 4.0,
                  dotSpacing: 15.0,
                  dotBgColor: Colors.transparent,
                  dotColor: primaryColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 280,
                ),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 20.0,
                              left: 20,
                              right: 20,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: 140,
                                  child: Text(
                                    desapegoDestaque.name.toUpperCase(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                Text(
                                  'R\$${desapegoDestaque.price.toStringAsFixed(2)}',
                                  textScaleFactor: 1.4,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 20,
                            ),
                            child: Text(
                              "${desapegoDestaque.cidade} \n",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                RichText(
                                  textAlign: TextAlign.start,
                                  text: TextSpan(
                                    text: 'DESCRIÇÃO \n',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.black,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: "\n",
                                      ),
                                      TextSpan(
                                        text: desapegoDestaque.descricao + "\n\n",
                                        style: TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Center(
                                  child: RaisedButton(
                                    onPressed: () {
                                      _launchURL(
                                          'whatsapp://send?phone=+55$clearNumber&text=Olá, ainda está disponível?'
                                      );
                                    },
                                    color: Theme.of(context).secondaryHeaderColor,
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Text(
                                        desapegoDestaque.number,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 22),
                                      ),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 70,
        width: MediaQuery.of(context).size.width,
        color: Theme.of(context).secondaryHeaderColor,
        child: Center(
          child: Text(
            "ANUCIANTE: " + nameAnuciante.toUpperCase(),
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}