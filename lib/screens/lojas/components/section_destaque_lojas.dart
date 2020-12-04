import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SectionDestaqueLojas extends StatelessWidget {

  final DocumentSnapshot snapshot;

  SectionDestaqueLojas(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 50,
        height: 28,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(snapshot.data()['img']),
                fit: BoxFit.contain
            )
        ),
      ),
      title: Text(snapshot.data()["name"], style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold),
      ),
      trailing: Icon(Icons.keyboard_arrow_right, color: Colors.cyan,),
      onTap: (){
        Navigator.of(context).push(
            MaterialPageRoute(builder:
                (context)=>Container())
        );
      },
    );
  }
}
