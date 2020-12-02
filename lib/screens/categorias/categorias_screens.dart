import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mix_brasil/screens/categorias/components/section_categorias.dart';

class CategoriasScreen extends StatelessWidget {
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
                    SizedBox(
                      width: 120,
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
          FutureBuilder<QuerySnapshot>(
            future: FirebaseFirestore.instance.collection('categorias').orderBy('pos').get(),
            builder: (context, snapshot){
              if(!snapshot.hasData){
                return SliverToBoxAdapter(
                  child: LinearProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.cyan),
                    backgroundColor: Colors.transparent,
                  ),
                );
              }

              final List<Widget> children = snapshot.data.docs
                  .map<Widget>((doc) {
                return CategoryTile(doc);
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
