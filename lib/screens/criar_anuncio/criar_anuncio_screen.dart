import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mix_brasil/model/user/user_manager.dart';
import 'package:mix_brasil/screens/login/login_screen.dart';
import 'components/criar_anuncio_tile.dart';

class CriarAnuncioScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final userManager = context.watch<UserManager>();
    if(userManager.isLoggedIn)
      return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/Fundo_mix.png'),
            fit: BoxFit.cover
          )
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text('CRIE SEU DESAPEGO', style: TextStyle(color: Colors.black),),
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(color: Colors.black),
          ),
          body: CriarAnuncioTile(),
        ),
      );
    else
      return
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/Fundo_mix.png'), fit: BoxFit.cover)),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: Text(
                'CRIE SEU DESAPEGO',
                style: TextStyle(color: Colors.black),
              ),
              centerTitle: true,
              elevation: 0,
              backgroundColor: Colors.transparent,
              iconTheme: IconThemeData(color: Colors.black),
              automaticallyImplyLeading: false,
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Icon(
                        Icons.login,
                        size: 80.0,
                        color: Theme.of(context).primaryColor,
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      Text(
                        "Faça o login para criar seu desapego!",
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
                          child: Text(
                            "Entrar",
                            style: TextStyle(fontSize: 22.0),
                          ),
                          textColor: Colors.white,
                          color: Theme.of(context).primaryColor,
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                          },
                          disabledColor:
                          Theme.of(context).primaryColor.withAlpha(100),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed('/base');
                      },
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                        child: Text(
                          'Voltar',
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Principal'),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
  }
}
