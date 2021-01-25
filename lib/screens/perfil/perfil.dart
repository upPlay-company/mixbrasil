import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:mix_brasil/model/user/user_manager.dart';
import 'package:mix_brasil/screens/minha_conta/minha_conta.dart';
import 'package:provider/provider.dart';

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
                padding: const EdgeInsets.only(bottom: 20, top: 10),
                child: Text(
                  "PERFIL",
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
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
                        height: MediaQuery.of(context).size.height * 0.22,
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: Theme.of(context).secondaryHeaderColor,
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 75),
                            child: Consumer<UserManager>(
                              builder: (_, userManager, __){
                                return Column(
                                  children: [
                                    Text(
                                      '${userManager.user?.name ?? 'Olá Convidado'}',
                                      style: TextStyle(
                                        decoration: TextDecoration.none,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 24,
                                      ),
                                    ),
                                    SizedBox(height: 10,),
                                    GestureDetector(
                                      onTap: (){
                                        if(userManager.isLoggedIn){
                                          userManager.signOut();
                                          Navigator.of(context).pushNamed('/base');
                                        } else {
                                          Navigator.of(context).pushNamed('/login');
                                        }
                                      },
                                      child: Text(
                                        userManager.isLoggedIn
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
                              },
                            )
                          ),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Consumer<UserManager>(
                      builder: (_, userManager, __){
                        if(userManager.isLoggedIn)
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
                                    userManager.user?.img ?? 'https://ipc.digital/wp-content/uploads/2016/07/icon-user-default.png',
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
                      },
                    ),
                  )
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
                onTap: (){
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => MinhaContaScreen()),
                  );
                },
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
