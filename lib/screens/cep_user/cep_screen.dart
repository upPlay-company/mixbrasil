import 'package:flutter/material.dart';
import 'package:mix_brasil/model/user/user_manager.dart';
import 'package:provider/provider.dart';

import 'components/address_card.dart';

class CepUserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Endereço'),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          AddressCard(),
          Consumer<UserManager>(
            builder: (_, userManager, __){
              return RaisedButton(
                child: Text('Confirmar'),
                onPressed: userManager.isAddressValid ? (){
                  Navigator.of(context).pushNamed('/base');
                } : null,
              );
            },
          )
        ],
      ),
    );
  }
}
