import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mix_brasil/screens/desapego/components/desapego_tile.dart';

class DesapegoCategorias extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todas as categorias', style: TextStyle(
            color: Colors.white,
            fontSize: 22,
        ),
        ),
      ),
      body: FutureBuilder<QuerySnapshot>(
          future: FirebaseFirestore.instance.collection("desapego").orderBy('pos').get(),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Center(
                child: CircularProgressIndicator(),
              );

            return ListView(
              children: snapshot.data.docs.map((doc) {
                return DesapegoTile(snapshot: doc,);
              }).toList(),
            );
          }
      ),
    );
  }
}
