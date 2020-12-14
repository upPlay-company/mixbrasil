import 'package:flutter/material.dart';
import 'package:mix_brasil/screens/desapego/components/desapego_categorias.dart';

class DesapegoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 120,
            snap: true,
            floating: true,
            elevation: 0,
            title: Text(
              'DESAPEGOS',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            flexibleSpace: Padding(
              padding: const EdgeInsets.only(top: 47, bottom: 20),
              child: Container(
                padding: EdgeInsets.only(left: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 200,
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => DesapegoCategorias()));
                        },
                        color: Theme.of(context).primaryColor,
                        child: Text(
                          'Todas as categorias',
                          style: TextStyle(color: Colors.white, fontSize: 18),
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
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverGrid(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200.0,
              mainAxisSpacing: 20.0,
              crossAxisSpacing: 10,
              childAspectRatio: 4.0,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: RaisedButton(
                      onPressed: () {},
                      color: Theme.of(context).secondaryHeaderColor,
                      child: Text(
                        'Manaus',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              topRight: Radius.circular(20)))),
                );
              },
              childCount: 4,
            ),
          ),
        ],
      ),
    );
  }
}
