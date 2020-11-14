import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mix_brasil/model/categorias/categorias.dart';
import 'package:provider/provider.dart';

class SectionCategorias extends StatelessWidget {
  
  SectionCategorias(this.categorias);

  final Categorias categorias;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: categorias,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 32,
              child: Consumer<Categorias>(
                builder: (_, categorias, __) {
                  return ListView.builder(
                    itemCount: categorias.name.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (_, index) {
                      return GestureDetector(
                        onTap: (){

                        },
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 50,
                              child: Icon(
                                Icons.person, size: 30,
                              ),
                            ),
                            Expanded(
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 5, left: 10),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(categorias.name, style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 50,
                              child: Icon(
                                Icons.arrow_forward_ios, size: 20,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ],
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
