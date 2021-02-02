import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mix_brasil/model/home/home_manager.dart';
import 'package:mix_brasil/model/lojas/loja_destaque_manager.dart';
import 'package:mix_brasil/model/user/user_manager.dart';
import 'package:mix_brasil/screens/home/components/section_at_categorias.dart';
import 'package:mix_brasil/screens/home/components/section_header.dart';
import 'package:provider/provider.dart';
import 'components/anuncie_aqui_screen.dart';
import 'components/section_banner.dart';
import 'components/section_destaques.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: Colors.transparent,
              padding: const EdgeInsets.only(left: 35),
              child: SizedBox(
                  width: 160,
                  height: 44,
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => AnuncieAquiScreen()
                      ));
                    },
                    color: Theme.of(context).secondaryHeaderColor,
                    child: Flexible(
                      child: Container(
                        child: Text(
                          'Anúncie aqui',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                  )
              ),
            ),
          ],
        ),
        body: CustomScrollView(slivers: [
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
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: SizedBox(
                        width: 140,
                        child: Consumer<UserManager>(
                          builder: (_, userManager, __){
                            if(userManager.isLoggedIn)
                              return RaisedButton(
                                onPressed: () {
                                  Navigator.of(context).pushNamed('/cep');
                                },
                                color: Theme.of(context).secondaryHeaderColor,
                                child: Padding(
                                  padding: const EdgeInsets.only(top:5),
                                  child: Column(
                                    children: [
                                      Text(
                                        'Você está em:',
                                        style: TextStyle(color: Colors.white, fontSize: 14),
                                      ),
                                      Flexible(
                                        child: Container(
                                          child: Text(
                                            '${userManager.user?.address?.city ?? 'Manaus'}',
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(color: Colors.white, fontSize: 18),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                ),
                              );
                            else
                              return RaisedButton(
                                onPressed: () {
                                  Navigator.of(context).pushNamed('/cep');
                                },
                                color: Theme.of(context).secondaryHeaderColor,
                                child: Padding(
                                  padding: const EdgeInsets.only(top:5),
                                  child: Column(
                                    children: [
                                      Text(
                                        'Você está em:',
                                        style: TextStyle(color: Colors.white, fontSize: 14),
                                      ),
                                      Text(
                                        'Manaus',
                                        style: TextStyle(color: Colors.white, fontSize: 20),
                                      ),
                                    ],
                                  ),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                ),
                              );
                          },
                        )
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Consumer<HomeManager>(
            builder: (_, homeManager, __) {
              if (homeManager.loading) {
                return SliverToBoxAdapter(
                  child: LinearProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.black),
                    backgroundColor: Colors.transparent,
                  ),
                );
              }

              final List<Widget> children =
                  homeManager.sections.map<Widget>((section) {
                switch (section.type) {
                  case 'banners':
                    return SectionBanner(section);
                  default:
                    return Container();
                }
              }).toList();

              return SliverList(
                delegate: SliverChildListDelegate(children),
              );
            },
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.only(top: 20),
              height: 200.0,
              child: FutureBuilder<QuerySnapshot>(
                future: FirebaseFirestore.instance
                    .collection("categorias")
                    .orderBy('pos')
                    .get(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  else
                    return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.all(4.0),
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return SectionAtCategorias(
                            snapshot: snapshot.data.docs[index],
                          );
                        });
                },
              ),
            ),
          ),
          Consumer<HomeManager>(
            builder: (_, homeManager, __) {
              if (homeManager.loading) {
                return SliverToBoxAdapter(
                  child: LinearProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.black),
                    backgroundColor: Colors.transparent,
                  ),
                );
              }

              final List<Widget> children =
                  homeManager.sections.map<Widget>((section) {
                switch (section.type) {
                  case 'titulo_destaques':
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
          Consumer<LojasDestaqueManager>(
            builder: (_, lojadestaqueManager, __) {
              if(lojadestaqueManager.loading) {
                return SliverToBoxAdapter(
                  child: LinearProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.black),
                    backgroundColor: Colors.transparent,
                  ),
                );
              }
              final List<Widget> children =
                  lojadestaqueManager.lojasDestaque.map<Widget>((section) {
                    return SectionDestaques(section);
              }).toList();
              return SliverList(
                delegate: SliverChildListDelegate(children),
              );
            },
          ),
        ]));
  }
}
