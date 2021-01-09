import 'package:flutter/material.dart';
import 'package:mix_brasil/model/user/user_manager.dart';
import 'components/address_card.dart';
import 'package:provider/provider.dart';

class CepUserScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final userManager = context.watch<UserManager>();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Escolha uma localização'),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          AddressCard(),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: userManager.isAddressValid ? (){
                  Navigator.of(context).pushNamed('/base');
                } : null,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: Text(
                    'Ok',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Principal'
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
