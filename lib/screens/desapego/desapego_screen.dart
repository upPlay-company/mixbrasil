import 'package:flutter/material.dart';
import 'package:mix_brasil/model/desapego/destaque_desapego_manager.dart';
import 'package:mix_brasil/screens/criar_anuncio/criar_anuncio_screen.dart';
import 'package:mix_brasil/screens/desapego/components/desapego_categorias.dart';
import 'package:mix_brasil/screens/desapego/components/search_dialog.dart';
import 'package:provider/provider.dart';

import 'components/section_destaque_desapego.dart';

class DesapegoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: Colors.transparent,
              padding: const EdgeInsets.only(left: 35),
              child: SizedBox(
                  width: 160,
                  height: 44,
                  // ignore: deprecated_member_use
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => CriarAnuncioScreen()));
                    },
                    color: Theme.of(context).secondaryHeaderColor,
                    child: Flexible(
                      child: Container(
                        child: Text(
                          'Criar Desapego',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                  )),
            ),
          ],
        ),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 25, bottom: 5),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10, bottom: 5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'DESAPEGOS',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 55,
                      color: Colors.grey[50],
                      padding: EdgeInsets.only(left: 10),
                      child: Consumer<DestaqueDesapegoManager>(
                        builder: (_, destaqueDesapegoManager, __) {
                          if (destaqueDesapegoManager.search.isEmpty) {
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 190,
                                  // ignore: deprecated_member_use
                                  child: RaisedButton(
                                    onPressed: () {
                                      Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context) =>
                                              DesapegoCategorias()));
                                    },
                                    color: Theme.of(context).primaryColor,
                                    child: Text(
                                      'Todas as categorias',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.horizontal(
                                            left: Radius.circular(10),
                                            right: Radius.circular(10))),
                                  ),
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: SizedBox(
                                        width: 55,
                                        height: 100,
                                        // ignore: deprecated_member_use
                                        child: RaisedButton(
                                          color: Theme.of(context).primaryColor,
                                          onPressed: () async {
                                            final search = await showDialog<String>(
                                                context: context,
                                                builder: (_) => SearchDialog(
                                                    destaqueDesapegoManager.search));
                                            if (search != null) {
                                              destaqueDesapegoManager.search = search;
                                            }
                                          },
                                          child: Icon(
                                            Icons.search,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.horizontal(
                                                  left: Radius.circular(10),
                                                  right: Radius.circular(10))),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            );
                          } else {
                            return Padding(
                              padding: const EdgeInsets.only(left: 20, right: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  LayoutBuilder(
                                    builder: (_, constraints) {
                                      return GestureDetector(
                                        onTap: () async {
                                          final search = await showDialog<String>(
                                              context: context,
                                              builder: (_) => SearchDialog(
                                                  destaqueDesapegoManager.search));
                                          if (search != null) {
                                            destaqueDesapegoManager.search = search;
                                          }
                                        },
                                        child: Container(
                                          child: Text(
                                            destaqueDesapegoManager.search,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.close),
                                    onPressed: () async {
                                      destaqueDesapegoManager.search = '';
                                    },
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Consumer<DestaqueDesapegoManager>(
                builder: (_, destaqueDesapegoManager, __) {
                  final filteredDesapego =
                      destaqueDesapegoManager.filteredDesapegoDestaque;
                  return ListView.builder(
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: filteredDesapego.length,
                    itemBuilder: (_, index) {
                      return SectionDestaquesDesapego(filteredDesapego[index]);
                    },
                  );
                },
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 60,),
            )
          ],
        ),
      ),
    );
  }
}
