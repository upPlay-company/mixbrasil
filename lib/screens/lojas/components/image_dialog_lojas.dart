
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageDialogLojas extends StatelessWidget {

  ImageDialogLojas({@required this.image});

  final dynamic image;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
          width: 700,
          child: PhotoView(
            backgroundDecoration: BoxDecoration(
              color: Colors.transparent,
            ),
            imageProvider: NetworkImage(image),
          )),
    );
  }
}
