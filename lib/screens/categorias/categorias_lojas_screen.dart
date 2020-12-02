import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mix_brasil/model/lojas/loja.dart';

import 'components/lojas_tile.dart';

class CategoryScreen extends StatelessWidget {

  final DocumentSnapshot snapshot;

  CategoryScreen(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Text(snapshot.data()["name"]),
            centerTitle: true,
          ),
          body: FutureBuilder<QuerySnapshot>(
            future: FirebaseFirestore.instance.collection("categorias").doc(snapshot.id)
                .collection("lojas").get(),
            builder: (context, snapshot){
              if(!snapshot.hasData)
                return Center(child: CircularProgressIndicator(),);
              else
                return ListView.builder(
                    padding: EdgeInsets.all(4.0),
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index){
                      LojasData data = LojasData.fromDocument(snapshot.data.docs[index]);
                      data.category = this.snapshot.id;
                      return LojasTile("list", data);
                    }
                );
            },
          )
      ),
    );
  }
}