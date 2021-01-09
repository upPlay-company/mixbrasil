import 'package:flutter/material.dart';
import 'package:mix_brasil/model/cep/address.dart';
import 'package:mix_brasil/model/user/user_manager.dart';
import 'package:provider/provider.dart';

import 'address_input_field.dart';
import 'cep_input_field.dart';

class AddressCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
          child: Consumer<UserManager>(
            builder: (_, userManager, __){
              final address = userManager.address ?? Address();
              if(userManager.isLoggedIn)
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
              else
                // TODO: FAZER LOGIN
                return Container(child: Text('Faça seu login'),);
            },
          )
      ),
    );
  }
}