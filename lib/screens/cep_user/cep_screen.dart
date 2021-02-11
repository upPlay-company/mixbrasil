import 'package:flutter/material.dart';
import 'package:mix_brasil/model/user/user_manager.dart';
import 'components/address_card.dart';
import 'package:provider/provider.dart';

class CepUserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userManager = context.watch<UserManager>();
    if (userManager.isLoggedIn)
      return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/Fundo mix 90.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              'Escolha uma localização',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: ListView(
            children: <Widget>[
              AddressCard(),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: userManager.isAddressValid
                        ? () {
                            Navigator.of(context).pushNamed('/base');
                          }
                        : null,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                      child: Text(
                        'Ok',
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
    else
      return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/Fundo mix 90.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              'Escolha uma localização',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: ListView(
            children: <Widget>[
              AddressCard(),
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
                        'Ok',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 16,
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
