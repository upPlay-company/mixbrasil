
import 'package:flutter/material.dart';

class ImageDialogLojas extends StatelessWidget {

  ImageDialogLojas({@required this.image});

  final dynamic image;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      elevation: 8,
      child: Container(
          width: 700,
          child: Image.network(image, fit: BoxFit.cover,)),
    );
  }
}
