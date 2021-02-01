import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mix_brasil/model/lojas/loja.dart';
import 'package:mix_brasil/screens/login/login_screen.dart';
import 'package:mix_brasil/screens/trabalhe_conosco/trabalhe_conosco.dart';

//Variaveis Globais
final Color primaryColor = Color(0xff078c9f);

class ProductScreen extends StatefulWidget {

  final LojasData lojas;

  ProductScreen(this.lojas);

  @override
  _ProductScreenState createState() => _ProductScreenState(lojas);
}

class _ProductScreenState extends State<ProductScreen> {
  final LojasData lojas;

  _ProductScreenState(this.lojas);

  double whiteMargin = 2.5;
  double imageMargin = 4.0;

//TODO: Ainda existe coisas static, é pra criar um array de imagens de oferta, ou a variavel promocao vai ter as imagens do card de ofertas
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
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
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width,
              child: Carousel(
                images: widget.lojas.img.map((url) {
                  return NetworkImage(url);
                }).toList(),
                boxFit: BoxFit.cover,
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
              child: Container(
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
                      child: Center(
                        child: Expanded(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  story(
                                    "\nOfertas",
                                    showModal: _showModalOfertas,
                                  ),
                                  story(
                                    "\nCupons",
                                    showModal: _showModalCupons,
                                  ),
                                  story(
                                    "Trabalhe conosco",
                                    rota: TrabalheConosco(lojas),
                                  ),
                                ],
                              ),
                              styleButton(),
                              ListView.builder(
                                physics: ScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: lojas.imgDestacadas.length,
                                itemBuilder: (_, index){
                                  return cardOfertas(index);
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )
      );
  }

  //Declarações de funções
  Widget cardOfertas(index) {
    return Card(
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        children: [
          Image.network(lojas.imgOfertas[index]),
        ],
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 5,
      margin: EdgeInsets.only(top: 15, bottom: 10, left: 30, right: 30),
    );
  }

  Widget styleButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: SizedBox(
        width: 120,
        height: 50,
        child: Container(
          child: Center(
            child: Text(
              "OFERTAS",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).secondaryHeaderColor,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
          ),
        ),
      ),
    );
  }

  void _showModalCupons() {
    showModalBottomSheet<void>(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.97,
          child: Carousel(
            images: widget.lojas.imgCupons.map((url) {
              return NetworkImage(url);
            }).toList(),
            borderRadius: true,
            radius: Radius.circular(30),
            dotSize: 4.0,
            dotSpacing: 15.0,
            dotBgColor: Colors.transparent,
            dotColor: primaryColor,
          ),
        );
      },
    );
  }

  void _showModalOfertas() {
    showModalBottomSheet<void>(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.97,
          child: Carousel(
            images: widget.lojas.imgOfertas.map((url) {
              return NetworkImage(url);
            }).toList(),
            borderRadius: true,
            radius: Radius.circular(30),
            dotSize: 4.0,
            dotSpacing: 15.0,
            dotBgColor: Colors.transparent,
            dotColor: primaryColor,
          ),
        );
      },
    );
  }

  //Função story recebe parametros opcional, você passa uma rota ou passa uma função
  Widget story(String title, {Widget rota, Function showModal}) {
    return GestureDetector(
      onTap: showModal ??
          () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => rota),
            );
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
