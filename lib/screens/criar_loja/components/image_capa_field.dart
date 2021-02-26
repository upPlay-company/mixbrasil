import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mix_brasil/screens/criar_anuncio/components/image_dialog.dart';
import 'package:mix_brasil/screens/criar_anuncio/components/image_source_dialog.dart';
import 'package:mix_brasil/stores/create_loja_store.dart';

class ImagesCapaField extends StatelessWidget {

  ImagesCapaField(this.createLojaStore);

  final CreateLojaStore createLojaStore;

  @override
  Widget build(BuildContext context) {

    void onImageSelected(File image){
      createLojaStore.imgCapa.add(image);
      Navigator.of(context).pop();
    }

    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: 5),
          color: Theme.of(context).primaryColor.withAlpha(430),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Capa da Loja', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w800),
              )
            ],
          ),
        ),
        Container(
            color: Theme.of(context).primaryColor.withAlpha(430),
            height: 120,
            child: Observer(
              builder: (_) {
                return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: createLojaStore.imgCapa.length < 1 ?
                    createLojaStore.imgCapa.length + 1 : 1,
                    itemBuilder: (_, index) {
                      if(index == createLojaStore.imgCapa.length)
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
                          child: GestureDetector(
                            onTap: (){
                              if(Platform.isAndroid){
                                showModalBottomSheet(
                                    context: context,
                                    builder: (_) => ImageSourceDialog(onImageSelected)
                                );
                              } else {
                                showCupertinoModalPopup(
                                    context: context,
                                    builder: (_) => ImageSourceDialog(onImageSelected)
                                );
                              }
                            },
                            child: CircleAvatar(
                              radius: 44,
                              backgroundColor: Theme.of(context).primaryColor,
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
                                      image: createLojaStore.imgCapa[index],
                                      onDelete: () => createLojaStore.imgCapa.removeAt(index)
                                  )
                              );
                            },
                            child: CircleAvatar(
                              radius: 44,
                              backgroundImage: createLojaStore.imgCapa[index] is File
                                  ? FileImage(
                                createLojaStore.imgCapa[index],
                              )
                                  : NetworkImage(createLojaStore.imgCapa[index]),
                            ),
                          ),
                        );
                    }
                );
              },
            )
        ),
        Observer(builder: (_){
          if(createLojaStore.imgCapaError != null)
            return Container(
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(color: Colors.red)
                  )
              ),
              padding: const EdgeInsets.fromLTRB(16, 8, 0, 0),
              child: Text(
                createLojaStore.imgCapaError,
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 12
                ),
              ),
            );
          else return Container();
          },
        ),
      ],
    );
  }
}