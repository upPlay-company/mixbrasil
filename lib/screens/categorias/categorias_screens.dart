import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mix_brasil/screens/categorias/components/section_categorias.dart';

class CategoriasScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  color: Colors.grey[50],
                  height: 55,
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Text(
                          'Categorias',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
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
                  return CategoryTile(snapshot: doc,);
                }).toList();
                return SliverList(
                  delegate: SliverChildListDelegate(children),
                );
              },
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 59,),
            )
          ],
        ),
      ),
    );
  }
}
