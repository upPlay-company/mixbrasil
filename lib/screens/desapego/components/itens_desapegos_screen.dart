import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:mix_brasil/model/desapego/desapego.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

class ItensDesapegoScreen extends StatefulWidget {
  final DesapegoData desapego;

  ItensDesapegoScreen(this.desapego);

  @override
  _ItensDesapegoScreenState createState() =>
      _ItensDesapegoScreenState(desapego);
}

class _ItensDesapegoScreenState extends State<ItensDesapegoScreen> {
  final DesapegoData desapego;

  _ItensDesapegoScreenState(this.desapego);

  @override
  Widget build(BuildContext context) {
    final clearNumber = desapego.number.replaceAll(RegExp('[^0-9]'), '');
    final Color primaryColor = Theme
        .of(context)
        .primaryColor;
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: FloatingActionButton(
                child: Icon(Icons.arrow_back),
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16.0))),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, right: 30),
              child: SizedBox(
                width: 55,
                height: 55,
                child: RaisedButton(
                  child: Icon(Icons.favorite_outline_outlined, color: Colors.red,),
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16.0))),
                  onPressed: (){}
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      body: ListView(
        children: [
          Stack(
            children: [
              Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.5,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                child: Carousel(
                  images: widget.desapego.img.map((url) {
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
                                Expanded(
                                  child: Text(
                                    desapego.name.toUpperCase(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10,),
                                Text(
                                  'R\$${desapego.price.toStringAsFixed(2)}',
                                  textScaleFactor: 1.4,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Theme
                                        .of(context)
                                        .primaryColor,
                                    fontSize: 14,
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
                              "${desapego.cidade} \n",
                              style: TextStyle(
                                fontSize: 16,
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
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: "\n",
                                      ),
                                      TextSpan(
                                        text: desapego.descricao + "\n\n",
                                        style: TextStyle(
                                          fontSize: 14,
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
                                    color: Theme
                                        .of(context)
                                        .secondaryHeaderColor,
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Text(
                                        desapego.number,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
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
        height: 50,
        width: MediaQuery
            .of(context)
            .size
            .width,
        color: Theme
            .of(context)
            .secondaryHeaderColor,
        child: Center(
          child: Text(
            "ANUCIANTE: " + desapego.anunciante.toUpperCase(),
            style: TextStyle(
              fontSize: 14,
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

  /*void saveFavoritos(){
    final user = GetIt.I<UserManager>().user;

    final Map<String, dynamic> data = {
      'name': desapego.name,
      'descricao': desapego.descricao,
      'price': desapego.price,
      'categoria': desapego.category,
      'number': desapego.number,
      'user': desapego.idUser,
      'img': desapego.img
    };

    FirebaseFirestore.instance.collection('users').doc(user.id).collection('favoritos').add(data);

  }*/
}