import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:mix_brasil/model/adm/adm.dart';
import 'package:url_launcher/url_launcher.dart';


class AnuncieAquiTile extends StatelessWidget {

  const AnuncieAquiTile(this.adm);

  final Adm adm;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Anúncie agora no Mix Brasil!",
            style: TextStyle(
                fontSize: 25.0, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 32.0,
          ),
          SizedBox(
            height: 54.0,
            child: RaisedButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    LineIcons.whatsapp,
                    size: 30,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Clique Aqui',
                    style: TextStyle(fontSize: 22.0),
                  ),
                ],
              ),
              textColor: Colors.white,
              color: Color(0xff2dc64f),
              onPressed: () {
                _launchURL(
                    'whatsapp://send?phone=${adm.whats}&text=Quero anúncia no MIX BRASIL'
                );
              },
              disabledColor:
              Theme.of(context).primaryColor.withAlpha(100),
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
          )
        ],
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
