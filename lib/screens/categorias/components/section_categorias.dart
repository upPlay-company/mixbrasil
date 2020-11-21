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
        color: Colors.transparent,
        margin: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 28,
              child: Consumer<Categorias>(
                builder: (_, categorias, __) {
                  return ListView.builder(
                    itemCount: categorias.img.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (_, index) {
                      return GestureDetector(
                        onTap: (){
                          //TODO: LISTAR CATEDORIAS
                        },
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 50,
                              height: 28,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(categorias.img),
                                  fit: BoxFit.contain
                                )
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
                                          fontSize: 16,
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
                                Icons.arrow_forward_ios, size: 16,
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
