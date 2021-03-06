import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mix_brasil/stores/myads_store.dart';

class HidePag extends StatelessWidget {
  
  HidePag({this.store});
  

  final MyAdsStore store;


  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return Column(
        children: [
          RadioListTile<String>(
            title: Text('Cartão de credito'),
            value: 'Cartão de credito',
            onChanged: store.setHidePagCard,
            groupValue: store.hideCard,
            activeColor: Theme.of(context).primaryColor,
          ),
          RadioListTile<String>(
            title: Text('Boleto'),
            onChanged: store.setHidePagCard,
            value: 'Boleto',
            groupValue: store.hideCard,
            activeColor: Theme.of(context).primaryColor,
          ),
          RadioListTile<String>(
            title: Text('Pix'),
            onChanged: store.setHidePagCard,
            value: 'Pix',
            groupValue: store.hideCard,
            activeColor: Theme.of(context).primaryColor,
          )
        ],
      );
    });
  }
}
