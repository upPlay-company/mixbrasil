import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mix_brasil/model/home/section.dart';
import 'package:provider/provider.dart';

class SectionAtCategorias extends StatelessWidget {

  SectionAtCategorias(this.section);

  final Section section;

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider.value(
      value: section,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 200,
              child: Consumer<Section>(
                builder: (_, section, __){
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: section.img.length,
                    itemBuilder: (_, index){
                      return Padding(
                        padding: const EdgeInsets.only(top: 15, right: 5),
                        child: Container(
                          height: 100,
                          width: 150,
                          child: Card(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                    height: 100,
                                    width: 100,
                                    child: Image.network(
                                      section.img[index],
                                      fit: BoxFit.cover,)),
                                SizedBox(height: 10,),
                                Text(section.titulo[index],
                                      style: TextStyle(fontSize: 18,
                                          fontWeight: FontWeight.w600),)
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
