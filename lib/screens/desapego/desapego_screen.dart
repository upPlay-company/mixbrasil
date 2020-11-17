import 'package:flutter/material.dart';
import 'package:mix_brasil/model/desapego/desapego_manager.dart';
import 'package:provider/provider.dart';

class DesapegoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(slivers: [
        SliverAppBar(
          expandedHeight: 105,
          title: Text(
            'DESAPEGOS',
            style: TextStyle(color: Colors.black, fontSize: 25),
          ),
          snap: true,
          floating: true,
          elevation: 0,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          flexibleSpace: Padding(
            padding: const EdgeInsets.only(top: 52),
            child: Container(
              padding: EdgeInsets.only(left: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 190,
                    child: RaisedButton(
                      color: Theme.of(context).primaryColor,
                      onPressed: () {},
                      child: Text(
                        'Todas Categorias',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
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
                      SizedBox(
                        width: 5,
                      ),
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
        Consumer<DesapegoManager>(
          builder: (_, desapegoManager, __){
            if(desapegoManager.loading){
              return SliverToBoxAdapter(
                child: LinearProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.black),
                  backgroundColor: Colors.transparent,
                ),
              );
            }

            final List<Widget> children = desapegoManager.atalhoCatDesapego
                .map<Widget>((atalhoCatDesapego) {
                  return SizedBox(
                    width: 180,
                    height: 60,
                    child: RaisedButton(
                        onPressed: () {},
                        color: Theme.of(context).secondaryHeaderColor,
                        child: Text(
                          atalhoCatDesapego.name,
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                topRight: Radius.circular(20)))),
                  );
            }).toList();

            return SliverList(
              delegate: SliverChildListDelegate(children),
            );
          },
        ),
      ]),
    );
  }
}
