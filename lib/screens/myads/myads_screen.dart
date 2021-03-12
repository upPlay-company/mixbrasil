import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mix_brasil/model/dicas_mix/dicas_mix_desapegos_manager.dart';
import 'package:mix_brasil/screens/myads/components/destacados_tile.dart';
import 'package:mix_brasil/stores/myads_store.dart';
import 'package:provider/provider.dart';
import 'components/active_tile.dart';
import 'components/dicas_mix_desapegos_tile.dart';
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

    tabController =
        TabController(length: 4, vsync: this, initialIndex: widget.inicialPage);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[50],
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            'Meus Desapegos',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          iconTheme: IconThemeData(color: Colors.white),
          automaticallyImplyLeading: true,
          centerTitle: true,
          elevation: 0,
          bottom: TabBar(
            indicator: BoxDecoration(color: Theme.of(context).secondaryHeaderColor),
            labelColor: Colors.white,
            controller: tabController,
            indicatorColor: Theme.of(context).primaryColor,
            tabs: [
              Tab(child: Text('DICAS MIX', style: TextStyle(fontSize: 10))),
              Tab(child: Text('ATIVOS', style: TextStyle(fontSize: 10))),
              Tab(child: Text('DESTACADOS', style: TextStyle(fontSize: 10))),
              Tab(child: Text('VENDIDOS', style: TextStyle(fontSize: 10))),
            ],
          ),
        ),
        body: Observer(
          builder: (_) {
            if (store.loading)
              return Center(
                child: CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation(Theme.of(context).primaryColor),
                ),
              );
            return TabBarView(
              controller: tabController,
              children: [
                Consumer<DicasMixDesapegosManager>(
                  builder: (_, dicasDesapegosManager, __){
                    if(dicasDesapegosManager.loading)
                      return CircularProgressIndicator();

                    return Container(
                      child: ListView.builder(
                        itemCount: dicasDesapegosManager.dicasMixDesapegos.length,
                        itemBuilder: (_, index){
                          return DicasMixDesapegosTile(dicasDesapegosManager.dicasMixDesapegos[index]);
                        },
                      ),
                    );
                  },
                ),
                Observer(
                  builder: (_) {
                    if (store.activeAds.isEmpty)
                      return EmptyCard('Você não possui nenhum anúncio ativo.');

                    return ListView.builder(
                      itemCount: store.activeAds.length,
                      itemBuilder: (_, index) {
                        return ActiveTile(store.activeAds[index], store);
                      },
                    );
                  },
                ),
                Observer(builder: (_) {
                  if (store.destacadoAds.isEmpty)
                    return EmptyCard(
                        'Você não possui nenhum anúncio destacados.');

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
