import 'package:flutter/material.dart';
import 'package:mix_brasil/model/categorias/categorias_manager.dart';
import 'package:mix_brasil/screens/categorias/components/section_categorias.dart';
import 'package:provider/provider.dart';

class CategoriasScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    SizedBox(
                      width: 120,
                      child: RaisedButton(
                          onPressed: () {},
                          color: Theme.of(context).secondaryHeaderColor,
                          child: Text(
                            'Manaus',
                            style: TextStyle(color: Colors.white, fontSize: 22),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  topRight: Radius.circular(20)))),
                    ),
                    SizedBox(
                      width: 130,
                      child: RaisedButton(
                        color: Theme.of(context).primaryColor,
                        onPressed: () {},
                        child: Text(
                          'Categorias',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20
                          ),
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
                          width: 55,
                          height: 100,
                          child: RaisedButton(
                            color: Theme.of(context).primaryColor,
                            onPressed: () {},
                            child: Icon(
                              Icons.filter_list_rounded,
                              color: Colors.white,
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.horizontal(
                                    left: Radius.circular(10),
                                    right: Radius.circular(10))),
                          ),
                        ),
                        SizedBox(width: 5,),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: SizedBox(
                            width: 55,
                            height: 100,
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
                    )
                  ],
                ),
              ),
            ),
          ),
          Consumer<CategoriasManager>(
            builder: (_, categoriasManager, __){
              if(categoriasManager.loading){
                return SliverToBoxAdapter(
                  child: LinearProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.black),
                    backgroundColor: Colors.transparent,
                  ),
                );
              }

              final List<Widget> children = categoriasManager.categorias
                  .map<Widget>((categorias) {
                    return SectionCategorias(categorias);
                }).toList();
              return SliverList(
                delegate: SliverChildListDelegate(children),
              );
            },
          ),
        ],
      ),
    );
  }
}
