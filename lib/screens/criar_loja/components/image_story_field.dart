import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mix_brasil/screens/criar_anuncio/components/image_dialog.dart';
import 'package:mix_brasil/screens/criar_anuncio/components/image_source_dialog.dart';
import 'package:mix_brasil/stores/create_loja_store.dart';

class ImagesStoryField extends StatelessWidget {

  ImagesStoryField(this.createLojaStore);

  final CreateLojaStore createLojaStore;

  @override
  Widget build(BuildContext context) {

    void onImageSelected(File image){
      createLojaStore.imgStory.add(image);
      Navigator.of(context).pop();
    }

    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: 5),
          color: Theme.of(context).primaryColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Imagens Story', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w800),
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
                    itemCount: createLojaStore.imgStory.length < 50 ?
                    createLojaStore.imgStory.length + 1 : 50,
                    itemBuilder: (_, index) {
                      if(index == createLojaStore.imgStory.length)
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
                                      image: createLojaStore.imgStory[index],
                                      onDelete: () => createLojaStore.imgStory.removeAt(index)
                                  )
                              );
                            },
                            child: CircleAvatar(
                              radius: 44,
                              backgroundImage: createLojaStore.imgStory[index] is File
                                  ? FileImage(
                                createLojaStore.imgStory[index],
                              )
                                  : NetworkImage(createLojaStore.imgStory[index]),
                            ),
                          ),
                        );
                    }
                );
              },
            )
        ),
        Observer(builder: (_){
          if(createLojaStore.imgStoryError != null)
            return Container(
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(color: Colors.red)
                  )
              ),
              padding: const EdgeInsets.fromLTRB(16, 8, 0, 0),
              child: Text(
                createLojaStore.imgStoryError,
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