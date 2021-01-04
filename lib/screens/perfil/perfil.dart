import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:line_icons/line_icons.dart';

class Perfil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView(
        children: [
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 20,),
                child: Text(
                  "PERFIL",
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                    fontSize: 30,
                  ),
                ),
              ),
              Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 70,
                      bottom: 20,
                    ),
                    child: Center(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.25,
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: Theme.of(context).secondaryHeaderColor,
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 125),
                            child: Column(
                              children: [
                                Text(
                                  "João Mason fred",
                                  style: TextStyle(
                                    decoration: TextDecoration.none,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 24,
                                  ),
                                ),
                                Text(
                                  "UI/UX Designer",
                                  style: TextStyle(
                                    decoration: TextDecoration.none,
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w100,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: GFAvatar(
                          size: 84,
                          backgroundImage: NetworkImage(
                              "https://scontent.fbsb13-1.fna.fbcdn.net/v/t31.0-8/19025169_1686185865011035_6264956930674587635_o.jpg?_nc_cat=109&ccb=2&_nc_sid=09cbfe&_nc_eui2=AeGHKzEPSTrPpIelfOylTw26CDz5-Gw7MegIPPn4bDsx6LaIERqzP-BDn5-u6VXqXX6_qBemL9-BJRGo0xttFz7J&_nc_ohc=y8z79LW0tiIAX_y8sR8&_nc_ht=scontent.fbsb13-1.fna&oh=3f64dbb097c3b22bb9116d23e8806437&oe=601379A6"),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              GestureDetector(
                child: rowsColumns(
                  "Meus Anúncios",
                  Icons.card_giftcard,
                  Icons.arrow_forward_ios,
                ),
              ),
              GestureDetector(
                child: rowsColumns(
                  "Meus Favoritos",
                  Icons.bookmark,
                  Icons.arrow_forward_ios,
                ),
              ),
              GestureDetector(
                child: rowsColumns(
                  "Plano Profissional",
                 Icons.monetization_on_rounded,
                  Icons.arrow_forward_ios,
                ),
              ),
              GestureDetector(
                child: rowsColumns(
                  "Perfil",
                  Icons.account_circle,
                  Icons.arrow_forward_ios,
                ),
              ),
              GestureDetector(
                child: rowsColumns(
                  "Segurança e privacidade",
                  Icons.vpn_key,
                  Icons.arrow_forward_ios,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }


  Widget rowsColumns(String title, IconData iconLeft, IconData iconRight) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 15, top: 8,
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                height: 40,
                width: 40,
                child: Icon(
                  iconLeft,
                  size: 30,
                  color: Colors.white,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Color(0xFF3CA59D),
                ),
              ),
              SizedBox(width: 10,),
              Expanded(
                flex: 5,
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    decoration: TextDecoration.none,
                    color: Colors.black,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Icon(
                  iconRight,
                  color: Color(0xFF3CA59D),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
