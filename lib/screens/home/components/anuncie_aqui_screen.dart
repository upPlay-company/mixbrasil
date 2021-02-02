import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mix_brasil/model/adm/adm.dart';
import 'package:mix_brasil/model/adm/adm_manager.dart';
import 'package:mix_brasil/model/user/user_manager.dart';
import 'package:mix_brasil/screens/login/login_screen.dart';
import 'package:provider/provider.dart';

import 'anuncie_aqui_tile.dart';

class AnuncieAquiScreen extends StatelessWidget {
  AnuncieAquiScreen({this.adm});

  final Adm adm;

  @override
  Widget build(BuildContext context) {
    final userManager = context.watch<UserManager>();

    if (userManager.isLoggedIn)
      return Consumer<AdmManager>(
        builder: (_, admManager, __) {
          return Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/Fundo_mix.png'),
                    fit: BoxFit.cover)),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                title: Text(
                  'ANÚNCIE AGORA',
                  style: TextStyle(color: Colors.black),
                ),
                centerTitle: true,
                elevation: 0,
                backgroundColor: Colors.transparent,
                iconTheme: IconThemeData(color: Colors.black),
              ),
              body: ListView.builder(

                  shrinkWrap: true,
                  itemCount: admManager.adm.length,
                  itemBuilder: (_, index){
                    return AnuncieAquiTile(admManager.adm[index]);
                  }
              ),
            ),
          );
        },
      );
    else
      return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/Fundo_mix.png'), fit: BoxFit.cover)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text(
              'ANÚNCIE AGORA',
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
                      "Faça o login para criar seu anúncio!",
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
