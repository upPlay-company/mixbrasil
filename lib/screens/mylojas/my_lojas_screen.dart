import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mix_brasil/common/empty_card.dart';
import 'package:mix_brasil/model/dicas_mix/dicas_mix_lojas_manager.dart';
import 'package:mix_brasil/screens/mylojas/components/dicas_mix_lojas_tile.dart';
import 'package:mix_brasil/stores/my_lojas_store.dart';
import 'package:provider/provider.dart';
import 'components/active_lojas_tile.dart';
import 'components/destacados_lojas_tile.dart';

class MyLojasScreen extends StatefulWidget {

  MyLojasScreen({this.inicialPage = 0});

  final int inicialPage;

  @override
  _MyLojasScreenState createState() => _MyLojasScreenState();
}

class _MyLojasScreenState extends State<MyLojasScreen>
    with SingleTickerProviderStateMixin {

  final MyLojasStore store = MyLojasStore();

  TabController tabController;

  @override
  void initState() {
    super.initState();

    tabController =
        TabController(length: 3, vsync: this, initialIndex: widget.inicialPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Minhas Lojas',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        elevation: 0,
        bottom: TabBar(
          indicator: BoxDecoration(color: Theme.of(context).secondaryHeaderColor),
          labelColor: Colors.white,
          controller: tabController,
          indicatorColor: Theme.of(context).primaryColor,
          tabs: [
            Tab(child: Text('ATIVOS', style: TextStyle(fontSize: 12))),
            Tab(child: Text('DESTACADOS', style: TextStyle(fontSize: 12))),
            Tab(child: Text('DICAS MIX', style: TextStyle(fontSize: 12))),
            ],
          )
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
              Observer(
                builder: (_) {
                  if (store.activeAds.isEmpty)
                    return EmptyCard('Você não possui nenhum lojas ativo.');

                  return ListView.builder(
                    itemCount: store.activeAds.length,
                    itemBuilder: (_, index) {
                      return ActiveLojasTile(store.activeAds[index], store);
                    },
                  );
                },
              ),
              Observer(builder: (_) {
                if (store.destacadoAds.isEmpty)
                  return EmptyCard(
                      'Você não possui nenhum lojas destacadas.');

                return ListView.builder(
                  itemCount: store.destacadoAds.length,
                  itemBuilder: (_, index) {
                    return DestacadolojasTile(store.destacadoAds[index], store);
                  },
                );
              }),
              Consumer<DicasMixLojasManager>(
                builder: (_, dicasLojasManager, __){
                  if(dicasLojasManager.loading)
                    return CircularProgressIndicator();

                  return Container(
                    child: ListView.builder(
                      itemCount: dicasLojasManager.dicasMixLojas.length,
                      itemBuilder: (_, index){
                        return DicasMixLojasTile(dicasLojasManager.dicasMixLojas[index]);
                      },
                    ),
                  );
                },
              )
            ],
          );
        },
      )
    );
  }
}