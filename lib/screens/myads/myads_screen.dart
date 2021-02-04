import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mix_brasil/stores/myads_store.dart';

import 'components/active_tile.dart';

class MyAdsScreen extends StatelessWidget {
  final MyAdsStore store = MyAdsStore();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/Fundo_mix.png'), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            'Meus Anúncios',
            style: TextStyle(color: Colors.black, fontSize: 22),
          ),
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Observer(builder: (_){
            if(store.activeAds.isEmpty)
              return Container();

            return ListView.builder(
              itemCount: store.activeAds.length,
              itemBuilder: (_, index){
                return ActiveTile(store.activeAds[index], store);
              },
            );
          },
        ),
      ),
    );
  }
}
