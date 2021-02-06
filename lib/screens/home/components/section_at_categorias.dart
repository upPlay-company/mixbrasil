import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mix_brasil/screens/categorias/categorias_lojas_screen.dart';

class SectionAtCategorias extends StatelessWidget {

  final DocumentSnapshot snapshot;

  SectionAtCategorias({this.snapshot});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).push(
            MaterialPageRoute(builder:
                (context)=>CategoryScreen(snapshot))
        );
      },
      child: Container(
        width: 190,
        child: Card(
          elevation: 8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                  height: 80,
                  width: 80,
                  child: Image.network(
                    snapshot.data()['image'],
                    fit: BoxFit.cover,)),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    snapshot.data()['name'],
                    style: TextStyle(fontSize: 18,
                        fontWeight: FontWeight.w600),),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}