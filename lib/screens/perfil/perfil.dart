import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:getwidget/getwidget.dart';
import 'package:line_icons/line_icons.dart';
import 'package:mix_brasil/screens/favoritos/favoritos_screen.dart';
import 'package:mix_brasil/screens/minha_conta/minha_conta.dart';
import 'package:mix_brasil/screens/myads/myads_screen.dart';
import 'package:mix_brasil/screens/mylojas/my_lojas_screen.dart';
import 'package:mix_brasil/stores/user_manager_store.dart';
import 'package:mix_brasil/common/entra_screen.dart';
import 'package:mix_brasil/screens/privacidade/privacidade_e_seguranca_screen.dart';

class Perfil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();

    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Container(
        color: Colors.grey[50],
        child: ListView(
          children: [
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 20, top: 10),
                  child: Text(
                    "PERFIL",
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
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
                          height: MediaQuery.of(context).size.height * 0.22,
                          width: MediaQuery.of(context).size.width * 0.9,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: Theme.of(context).secondaryHeaderColor,
                          ),
                          child: Center(
                            child: Padding(
                                padding: const EdgeInsets.only(top: 75),
                                child: Observer(builder: (_){
                                  return Column(
                                    children: [
                                      Text(
                                        '${userManagerStore.user?.name ?? 'Olá Convidado'}',
                                        style: TextStyle(
                                          decoration: TextDecoration.none,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w900,
                                          fontSize: 18,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          if (userManagerStore.isLoggedIn) {
                                            userManagerStore.logout();
                                            Navigator.of(context)
                                                .pushNamed('/base');
                                          } else {
                                            Navigator.of(context)
                                                .pushNamed('/login');
                                          }
                                        },
                                        child: Text(
                                          userManagerStore.isLoggedIn
                                              ? 'Sair'
                                              : 'Entre Agora',
                                          style: TextStyle(
                                            decoration: TextDecoration.none,
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                })),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Observer(builder: (_){
                        if (userManagerStore.isLoggedIn && userManagerStore.user?.img?.isEmpty != null)
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: GFAvatar(
                                size: 84,
                                backgroundImage: NetworkImage(
                                  userManagerStore.user.img?.first ??
                                      'https://ipc.digital/wp-content/uploads/2016/07/icon-user-default.png',
                                ),
                              ),
                            ),
                          );
                        else
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: GFAvatar(
                                size: 84,
                                backgroundImage: NetworkImage(
                                  'https://ipc.digital/wp-content/uploads/2016/07/icon-user-default.png',
                                ),
                              ),
                            ),
                          );
                      })
                    )
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    if(userManagerStore.isLoggedIn)
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_) => MyAdsScreen()));
                    else
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_) => FacaLoginScreen()));
                  },
                  child: rowsColumns(
                    "Meus Desapegos",
                    Icons.card_giftcard,
                    Icons.arrow_forward_ios,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if(userManagerStore.isLoggedIn)
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_) => MyLojasScreen()));
                    else
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_) => FacaLoginScreen()));
                  },
                  child: rowsColumns(
                    "Minhas Lojas",
                    LineIcons.store,
                    Icons.arrow_forward_ios,
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    if(userManagerStore.isLoggedIn)
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => FavoritosScreen()),
                      );
                    else
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => FacaLoginScreen()),
                      );
                  },
                  child: rowsColumns(
                    "Meus Favoritos",
                    Icons.favorite,
                    Icons.arrow_forward_ios,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if(userManagerStore.isLoggedIn)
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => MinhaContaScreen()),
                      );
                    else
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => FacaLoginScreen()),
                      );
                  },
                  child: rowsColumns(
                    "Perfil",
                    Icons.account_circle,
                    Icons.arrow_forward_ios,
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => PrivacidadeSegurancaScreen())
                    );
                  },
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
      ),
    );
  }

  Widget rowsColumns(String title, IconData iconLeft, IconData iconRight) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 15,
        top: 8,
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                height: 35,
                width: 35,
                child: Icon(
                  iconLeft,
                  size: 25,
                  color: Colors.white,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Color(0xFF3CA59D),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 5,
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
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
                  size: 20,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
