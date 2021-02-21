import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mix_brasil/screens/criar_anuncio/components/image_dialog.dart';
import 'package:mix_brasil/model/user/user.dart';
import 'package:mix_brasil/screens/minha_conta/componets/image_source_sheet_perfil.dart';

class ImageField extends StatelessWidget {

  ImageField(this.user);

  final UserUser user;

  @override
  Widget build(BuildContext context) {
    return FormField(
      builder: (image){
        void onImageSelected(File file){
          user.img.add(file);
          image.didChange(user.img);
          Navigator.of(context).pop();
        }
        return Column(
          children: [
            Container(
                color: Colors.transparent,
                width: 140,
                height: 130,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount:  user.img.length < 1 ?
                    user.img.length + 1 : 1,
                    itemBuilder: (_, index) {
                      if(index == user.img.length)
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
                          child: GestureDetector(
                            onTap: (){
                              if(Platform.isAndroid){
                                showModalBottomSheet(
                                    context: context,
                                    builder: (_) => ImageSourceSheet(onImageSelected: onImageSelected)
                                );
                              } else {
                                showCupertinoModalPopup(
                                    context: context,
                                    builder: (_) => ImageSourceSheet(onImageSelected: onImageSelected)
                                );
                              }
                            },
                            child: CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.grey[300],
                              child: Icon(
                                Icons.camera_alt,
                                size: 40,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                      else
                        return Padding(
                          padding: EdgeInsets.fromLTRB(
                              8,
                              8,
                              index == 4 ? 8 : 0,
                              8),
                          child: GestureDetector(
                            onTap: (){
                              showDialog(
                                  context: context,
                                  builder: (_) => ImageDialog(
                                      image: user.img[index],
                                      onDelete: (){
                                        user.img.removeAt(index);
                                        image.didChange(user.img);
                                      }
                                  )
                              );
                            },
                            child: CircleAvatar(
                              radius: 60,
                              backgroundImage: user.img[index] is File
                                  ? FileImage(
                                user.img[index],
                              )
                                  : NetworkImage(user.img[index]),
                            ),
                          ),
                        );
                    }
                )
            ),
          ],
        );
      },
    );
  }
}