import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'desapego_lojas_screen.dart';

class DesapegoTile extends StatelessWidget {

  final DocumentSnapshot snapshot;

  DesapegoTile({this.snapshot});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Container(
            width: 50,
            height: 25,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(snapshot.data()['image']),
                    fit: BoxFit.contain
                )
            ),
          ),
          title: Text(snapshot.data()["name"], style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold),
          ),
          trailing: Icon(Icons.keyboard_arrow_right, color: Colors.cyan,),
          onTap: (){
            Navigator.of(context).push(
                MaterialPageRoute(builder:
                    (context)=>DesapegoLojaScreen(snapshot))
            );
          },
        ),
        Container(
          decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey[300]))
          ),
        )
      ],
    );
  }
}
