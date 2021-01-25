import 'package:flutter/material.dart';


class StyleScreenPattern extends StatelessWidget {

  StyleScreenPattern({this.child});

  final child;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/Fundo_mix.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: child,
      ),
    );
  }
}

