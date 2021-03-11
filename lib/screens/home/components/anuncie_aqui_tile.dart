import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:mix_brasil/model/adm/adm.dart';
import 'package:mix_brasil/screens/criar_loja/criar_loja_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class AnuncieAquiTile extends StatelessWidget {
  const AnuncieAquiTile(this.adm);

  final Adm adm;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: 350,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/wwww.png'),
                  fit: BoxFit.cover)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Anúncie agora",
                  style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "NO MIX BRASIL",
                  style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 32.0,
                ),
                SizedBox(
                  height: 54.0,
                  // ignore: deprecated_member_use
                  child: RaisedButton(
                    child: Text(
                      'Criar Loja',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    textColor: Colors.white,
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => CriarLojaScreen()
                      ));
                    },
                    disabledColor:
                        Theme.of(context).primaryColor.withAlpha(100),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Text(
                  "Anúncie para todo Brasil o seu negocio nos banner's da Mix! Quem anuncia Vende! CLIQUE NO BOTÃO E SAIBA MAIS...",
                  style:
                      TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.50),
          child: Container(
            height: 220,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/Imagem 02.png'),
                    fit: BoxFit.cover)),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.83),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  height: 54.0,
                  // ignore: deprecated_member_use
                  child: RaisedButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          LineIcons.whatSApp,
                          size: 20,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Banners/Dúvidas',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                    textColor: Colors.white,
                    color: Color(0xff2dc64f),
                    onPressed: () {
                      _launchURL(
                          'whatsapp://send?phone=+55${adm.whats}&text=Quero anúncia no MIX BRASIL');
                    },
                    disabledColor:
                        Theme.of(context).primaryColor.withAlpha(100),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
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
