import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mix_brasil/screens/myads/components/destacados_tile.dart';
import 'package:mix_brasil/stores/myads_store.dart';
import 'components/active_tile.dart';
import 'components/solt_tile.dart';
import 'package:mix_brasil/common/empty_card.dart';

class MyAdsScreen extends StatefulWidget {

  MyAdsScreen({this.inicialPage = 0});

  final int inicialPage;

  @override
  _MyAdsScreenState createState() => _MyAdsScreenState();
}

class _MyAdsScreenState extends State<MyAdsScreen>
    with SingleTickerProviderStateMixin {
  final MyAdsStore store = MyAdsStore();

  TabController tabController;


  @override
  void initState() {
    super.initState();

    tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: widget.inicialPage
    );
  }

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
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          bottom: TabBar(
            indicator: BoxDecoration(color: Theme.of(context).primaryColor),
            labelColor: Colors.black,
            controller: tabController,
            indicatorColor: Theme.of(context).primaryColor,
            tabs: [
              Tab(
                  child: Text('ATIVOS', style: TextStyle(fontSize: 10))),
              Tab(child: Text('DESTACADOS', style: TextStyle(fontSize: 10))),
              Tab(child: Text('VENDIDOS', style: TextStyle(fontSize: 10))),
            ],
          ),
        ),
        body: Observer(builder: (_){
            if(store.loading)
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor),
                ),
              );
            return TabBarView(
              controller: tabController,
              children: [
                Observer(builder: (_){
                  if(store.activeAds.isEmpty)
                    return EmptyCard('Você não possui nenhum anúncio ativo.');

                  return ListView.builder(
                    itemCount: store.activeAds.length,
                    itemBuilder: (_, index){
                      return ActiveTile(store.activeAds[index], store);
                      },
                    );
                  },
                ),
                Observer(builder: (_) {
                  if (store.destacadoAds.isEmpty)
                    return EmptyCard('Você não possui nenhum anúncio destacados.');

                  return ListView.builder(
                    itemCount: store.destacadoAds.length,
                    itemBuilder: (_, index) {
                      return DestacadoTile(store.destacadoAds[index], store);
                    },
                  );
                }),
                Observer(builder: (_) {
                  if (store.soldAds.isEmpty)
                    return EmptyCard('Você não possui nenhum anúncio vendido.');

                  return ListView.builder(
                    itemCount: store.soldAds.length,
                    itemBuilder: (_, index) {
                      return SoldTile(store.soldAds[index], store);
                    },
                  );
                }),
              ],
            );
          },
        ),
      ),
    );
  }
}
