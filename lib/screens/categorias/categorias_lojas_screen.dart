import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mix_brasil/model/lojas/loja.dart';
import 'components/lojas_tile.dart';

class CategoryScreen extends StatelessWidget {
  
  final DocumentSnapshot snapshot;

  CategoryScreen(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(snapshot.data()["name"], style: TextStyle(fontSize: 18),),
          iconTheme: IconThemeData(size: 10, color: Colors.white),
          /*actions: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: SizedBox(
                    width: 55,
                    height: 100,
                    child: GestureDetector(
                      onTap: () {
                        // TODO: SEARCH LOJAS
                      },
                      child: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],*/
        ),
        body: FutureBuilder<QuerySnapshot>(
          future: FirebaseFirestore.instance
              .collection("categorias")
              .doc(snapshot.id)
              .collection("lojas")
              .get(),
               builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Center(
                child: CircularProgressIndicator(),
              );
            else
              return ListView.builder(
                  padding: EdgeInsets.all(4.0),
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    LojasData data =
                        LojasData.fromDocument(snapshot.data.docs[index]);
                    data.category = this.snapshot.id;
                    return LojasTile("list", data);
                  });
          },
        ));
  }
}
