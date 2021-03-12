import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:mix_brasil/model/lojas/destaque.dart';
import 'package:mix_brasil/screens/lojas/components/image_dialog_lojas.dart';
import 'package:mix_brasil/screens/trabalhe_conosco/trabalhe_conosco_destaque.dart';
import 'package:line_icons/line_icons.dart';
import 'package:photo_view/photo_view.dart';
import 'package:url_launcher/url_launcher.dart';


//Variaveis Globais
final Color primaryColor = Color(0xff078c9f);

class LojasDestaqueScreen extends StatefulWidget {
  //variaveis
  final DestaqueLoja lojasDestaque;

  LojasDestaqueScreen(this.lojasDestaque);

  @override
  _LojasDestaqueScreenState createState() => _LojasDestaqueScreenState(lojasDestaque);
}

class _LojasDestaqueScreenState extends State<LojasDestaqueScreen> {
  final DestaqueLoja lojasDestaque;

  _LojasDestaqueScreenState(this.lojasDestaque);

  double whiteMargin = 2.5;
  double imageMargin = 4.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Row(
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
                // ignore: deprecated_member_use
                child: RaisedButton(
                  child: Icon(LineIcons.whatSApp, color: Colors.white,),
                  color: Color(0xff2dc64f),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16.0))),
                  onPressed: () {
                    final clearNumber = lojasDestaque.number.replaceAll(RegExp('[^0-9]'), '');
                    _launchURL(
                        'whatsapp://send?phone=+55$clearNumber&text=Olá, vi seus anúncios na Mix Brasil. Quero comprar/saber mais!'
                    );
                  },
                ),
              ),
            )
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        body: ListView(
          children: [
            Container(
              color: Colors.grey[100],
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width,
              child: Carousel(
                images: widget.lojasDestaque.img.map((url) {
                  return GestureDetector(
                    onTap: (){
                      showDialog(
                          context: context,
                          builder: (_) => ImageDialogLojas(
                            image: url,
                          )
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(url)
                          )
                      ),
                    ),
                  );
                }).toList(),
                boxFit: BoxFit.cover,
                dotSize: 4.0,
                dotSpacing: 15.0,
                dotBgColor: Colors.transparent,
                showIndicator: false,
                dotColor: primaryColor,
              ),
            ),
            Container(
              color: Colors.white,
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
                                  "\nStory",
                                  showModal: _showModalOfertas,
                                ),
                                story(
                                  "\nCupons",
                                  showModal: _showModalCupons,
                                ),
                                story(
                                  "\nVagas",
                                  rota: TrabalheConoscoDestaque(lojasDestaque),
                                ),
                              ],
                            ),
                            styleButton(),
                            ListView.builder(
                              physics: ScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: lojasDestaque.imgDestacadas.length,
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
          ],
        )
    );
  }

  //Declarações de funções
  Widget cardOfertas(index) {
    return Card(
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: GestureDetector(
        onTap: (){
          showDialog(
              context: context,
              builder: (_) => ImageDialogLojas(
                image: lojasDestaque.imgDestacadas[index],
              )
          );
        },
        child: Container(
            child: Image.network(lojasDestaque.imgDestacadas[index], fit: BoxFit.cover,)),
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
      backgroundColor: Colors.black,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Carousel(
            images: widget.lojasDestaque.imgCupons.map((url) {
              return PhotoView(
                backgroundDecoration: BoxDecoration(
                  color: Colors.black,
                ),
                imageProvider: NetworkImage(url),
              );
            }).toList(),
            boxFit: BoxFit.contain,
            borderRadius: true,
            radius: Radius.circular(30),
            dotSize: 4.0,
            dotSpacing: 15.0,
            dotBgColor: Colors.transparent,
            dotColor: primaryColor,
            autoplayDuration: Duration(seconds: 5),
          ),
        );
      },
    );
  }

  void _showModalOfertas() {
    showModalBottomSheet<void>(
      backgroundColor: Colors.black,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20)
          ),
          child: Carousel(
            images: widget.lojasDestaque.imgOfertas.map((url) {
              return PhotoView(
                backgroundDecoration: BoxDecoration(
                  color: Colors.black,
                ),
                imageProvider: NetworkImage(url),
              );
            }).toList(),
            boxFit: BoxFit.contain,
            radius: Radius.circular(30),
            dotSize: 4.0,
            dotSpacing: 15.0,
            dotBgColor: Colors.transparent,
            dotColor: primaryColor,
            autoplayDuration: Duration(seconds: 5),
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

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
