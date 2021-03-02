import 'package:flutter/material.dart';
import 'file:///D:/Aplicativos-construcao/APP-mix-brasil/mix_brasil/lib/screens/cep_user/state_list.dart';

class FilterLocal extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Escolha uma localidade'),
      ),
      body: Card(
        margin: EdgeInsets.all(20),
        elevation: 8,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            StateList()
          ],
        ),
      ),
    );
  }
}
