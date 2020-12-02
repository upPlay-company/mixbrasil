import 'package:flutter/material.dart';
import 'package:mix_brasil/model/home/home_manager.dart';
import 'package:mix_brasil/screens/home/components/section_header.dart';
import 'package:provider/provider.dart';
import 'components/section_at_categorias.dart';
import 'components/section_banner.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 80,
            snap: true,
            floating: true,
            elevation: 0,
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            flexibleSpace: Padding(
              padding: const EdgeInsets.only(top: 27),
              child: Container(
                padding: EdgeInsets.only(left: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset('images/Logo mix.png'),
                    SizedBox(
                      width: 140,
                      child: RaisedButton(
                          onPressed: () {},
                          color: Theme.of(context).secondaryHeaderColor,
                          child: Text(
                            //TODO: COLOCAR CIDADE
                            'Manaus',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  topRight: Radius.circular(20)))),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: SizedBox(
                        width: 55,
                        child: RaisedButton(
                          color: Theme.of(context).primaryColor,
                          onPressed: () {},
                          child: Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.horizontal(
                                  left: Radius.circular(10),
                                  right: Radius.circular(10))),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Consumer<HomeManager>(
            builder: (_, homeManager, __){
              if(homeManager.loading){
                return SliverToBoxAdapter(
                  child: LinearProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.black),
                    backgroundColor: Colors.transparent,
                  ),
                );
              }

              final List<Widget> children = homeManager.sections
                  .map<Widget>((section) {
                switch(section.type){
                  case 'at_categorias' :
                    return SectionAtCategorias(section);
                  case 'banners' :
                    return SectionBanner(section);
                  case 'titulo_destaques' :
                    return SectionHeader(section);
                  default:
                    return Container();
                }
              }).toList();

              return SliverList(
                delegate: SliverChildListDelegate(children),
              );
            },
          ),
          /*Consumer<LojasManager>(
            builder: (_, lojaManager, __){
              if(lojaManager.loading){
                return SliverToBoxAdapter(
                  child: LinearProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.black),
                    backgroundColor: Colors.transparent,
                  ),
                );
              }

              final List<Widget> children = lojaManager.lojas
                  .map<Widget>((section) {
                    return SectionDestaques(section);
                }).toList();
              return SliverList(
                delegate: SliverChildListDelegate(children),
              );
            },
          )*/
        ],
      ),
    );
  }
}
