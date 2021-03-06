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
        width: 170,
        child: Card(
          elevation: 4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                  height: 40,
                  width: 40,
                  child: Image.network(
                    snapshot.data()['image'],
                    fit: BoxFit.cover,)),
              SizedBox(height: 10,),
              Row(
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        snapshot.data()['name'],
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 14,
                            fontWeight: FontWeight.w600),),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}