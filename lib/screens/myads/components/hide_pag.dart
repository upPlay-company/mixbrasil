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
          RadioListTile(
            title: Text('Cartão de credito'),
            value: store.hidePhoneTrue,
            groupValue: store.hidePhone,
            onChanged: store.setHidePhone,
            activeColor: Theme.of(context).primaryColor,
          ),
          RadioListTile(
            title: Text('Boleto'),
            groupValue: store.hidePhone,
            onChanged: store.setHidePhone,
            activeColor: Theme.of(context).primaryColor,
          )
        ],
      );
    });
  }
}
