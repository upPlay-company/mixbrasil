import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageSourceDialog extends StatelessWidget {

  ImageSourceDialog(this.onImageSelected);

  final Function(File) onImageSelected;

  @override
  Widget build(BuildContext context) {
    if(Platform.isAndroid)
      return BottomSheet(
          onClosing: () {},
          builder: (_) => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                  onPressed: getFromCamera,
                  child: Text('Câmera')
              ),
              TextButton(
                  onPressed: getFromGallery,
                  child: Text('Galeria')
              ),
              SizedBox(height: 50,),
            ],
          )
      );
    else
      return CupertinoActionSheet(
        title: Text('Escolha uma foto'),
          actions: [
            CupertinoActionSheetAction(
                onPressed: getFromCamera,
                child: Text('Câmera')
            ),
            CupertinoActionSheetAction(
                onPressed: getFromGallery,
                child: Text('Galeria')
            ),
          ],
        cancelButton: CupertinoActionSheetAction(
            onPressed: Navigator.of(context).pop,
            child: Text('Cancelar',
            style: TextStyle(color: Colors.red),)
        ),
      );
  }

  Future<void> getFromCamera() async {
    final pickerFile = await ImagePicker().getImage(source: ImageSource.camera);
    if(pickerFile == null) return;
    final image = File(pickerFile.path);
    onImageSelected(image);
  }

  Future<void> getFromGallery() async {
    final pickerFile = await ImagePicker().getImage(source: ImageSource.gallery);
    if(pickerFile == null) return;
    final image = File(pickerFile.path);
    onImageSelected(image);
  }

  /*Future<void> imageSelected(File image) async {
    final croppedFile =  await ImageCropper.cropImage(
      sourcePath: image.path,
      aspectRatio: CropAspectRatio(ratioX: 2, ratioY: 2),
      androidUiSettings: AndroidUiSettings(
        toolbarTitle: 'Editar Imagem',
        toolbarColor: Color(0xff078c9f),
        toolbarWidgetColor: Colors.white
      ),
      iosUiSettings: IOSUiSettings(
        title: 'Editar Imagem',
        cancelButtonTitle: 'Cancelar',
        doneButtonTitle: 'Concluir'
      )
    );
    if(croppedFile != null )
      onImageSelected(croppedFile);
  }*/
}
