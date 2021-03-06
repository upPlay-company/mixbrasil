import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mix_brasil/screens/desapego/components/desapego_tile.dart';

class DesapegoCategorias extends StatelessWidget {
  //inicio
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text('Todas as categorias', style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
      body: FutureBuilder<QuerySnapshot>(
          future: FirebaseFirestore.instance.collection("desapego").get(),
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
