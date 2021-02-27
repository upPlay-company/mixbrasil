import 'package:flutter/material.dart';
import 'package:mix_brasil/model/cep/address.dart';
import 'package:mix_brasil/model/user/user_manager.dart';
import 'package:mix_brasil/screens/login/login_screen.dart';
import 'package:provider/provider.dart';
import 'address_input_field.dart';
import 'cep_input_field.dart';

class AddressCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userManager = context.watch<UserManager>();
    if(userManager.isLoggedIn)
      return Card(
        elevation: 8,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
            child: Consumer<UserManager>(
              builder: (_, userManager, __){
                final address = userManager.address ?? Address();
                  return Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Sua localização',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600
                          ),
                        ),
                        CepInputField(address),
                        AddressInputField(address),
                      ],
                    ),
                  );
              },
            )
        ),
      );
    else
      return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.location_on,
            size: 60.0, color: Theme.of(context).primaryColor,),
          SizedBox(height: 16.0,),
          Text("Faça o login para adicionar sua localização!",
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.0,),
          SizedBox(
            height: 54.0,
            // ignore: deprecated_member_use
            child: RaisedButton(
              child: Text("Entrar", style: TextStyle(fontSize: 18.0),),
              textColor: Colors.white,
              color: Theme.of(context).primaryColor,
              onPressed: (){
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context)=>LoginScreen())
                );
              },
              disabledColor: Theme.of(context).primaryColor.withAlpha(100),
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
              ),
            ),
          ),
        ],
      ),
    );
  }
 }