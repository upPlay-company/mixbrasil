import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mix_brasil/model/lojas/loja.dart';
import 'package:mix_brasil/screens/trabalhe_conosco/trabalhe_conosco.dart';
import 'package:line_icons/line_icons.dart';
import 'package:photo_view/photo_view.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mix_brasil/screens/lojas/components/image_dialog_lojas.dart';

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

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  int counter = 0;

  void saveViewsWhats() async {
    ++counter;
    final viewsTotal = counter + widget.lojas.viewsWhats;

    DocumentReference firestoreRefUser = firestore
        .collection('users')
        .doc(widget.lojas.idUser)
        .collection('lojas')
        .doc(widget.lojas.idAdsUser);

    DocumentReference firestoreRefAds = firestore
        .collection('categorias')
        .doc(widget.lojas.idCat)
        .collection('lojas')
        .doc(widget.lojas.id);

    await firestoreRefAds.update({'viewsWhats': viewsTotal});
    await firestoreRefUser.update({'viewsWhats': viewsTotal});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                  saveViewsWhats();
                  final clearNumber = lojas.number.replaceAll(RegExp('[^0-9]'), '');
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
              images: widget.lojas.img.map((url) {
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
              dotIncreasedColor: primaryColor,
              showIndicator: true,
              autoplay: false,
            ),
          ),
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
                    image: lojas.imgDestacadas[index],
                )
            );
          },
          child: Container(
            child: Image.network(lojas.imgDestacadas[index], fit: BoxFit.cover,)),
        ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 5,
      margin: EdgeInsets.only(top: 15, bottom: 10, left: 30, right: 30),
    );
  }

  Widget styleButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 15, right: 100, left: 100),
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
        return Scaffold(
          floatingActionButton: GestureDetector(
            onTap: (){
              Navigator.of(context).pop();
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 30, right: 10),
              child: Icon(Icons.close, color: Colors.white,),
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
          body: Container(
            child: Carousel(
              images: widget.lojas.imgCupons.map((url) {
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
              dotIncreasedColor: primaryColor,
              autoplay: false,
            ),
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
        return Scaffold(
          floatingActionButton: GestureDetector(
            onTap: (){
              Navigator.of(context).pop();
              },
            child: Padding(
              padding: const EdgeInsets.only(top: 30, right: 10),
              child: Icon(Icons.close, color: Colors.white,),
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
          body: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20)
            ),
            child: Carousel(
              images: widget.lojas.imgOfertas.map((url) {
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
              dotIncreasedColor: primaryColor,
              autoplay: false,
            ),
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
