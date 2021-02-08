import 'dart:io';

import 'package:flutter/material.dart';

class ImageDialog extends StatelessWidget {

  ImageDialog({@required this.image, @required this.onDelete});

  final dynamic image;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if(image is File)
            Image.file(image)
          else Image.network(image),
          FlatButton(
            onPressed: (){
              Navigator.of(context).pop();
              onDelete();
            },
            child: Text('Excluir'),
            textColor: Colors.red,
          )
        ],
      ),
    );
  }
}
