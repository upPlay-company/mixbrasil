import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mix_brasil/model/home/section_destaque.dart';
import 'package:provider/provider.dart';

class SectionDestaques extends StatelessWidget {
  SectionDestaques(this.section2);

  final Section2 section2;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: section2,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 120,
              child: Consumer<Section2>(
                builder: (_, section2, __) {
                  return ListView.builder(
                    itemCount: section2.img.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (_, index) {
                      return Container(
                          height: 120,
                          child: Card(
                            color: Colors.cyan[50],
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: SizedBox(
                                    width: 140,
                                    height: 100,
                                    child: AspectRatio(
                                      aspectRatio: 1,
                                      child: Image.network(
                                        section2.img.first,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(height: 10,),
                                      Text(
                                        section2.name,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w800),
                                      ),
                                      SizedBox(height: 5,),
                                      Text(
                                        section2.titulo,
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.grey[700]),
                                      ),
                                      SizedBox(height: 20,),
                                      Row(
                                        children: [
                                          Text(
                                            'A partir de',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w800,
                                                color: Colors.black),
                                          ),
                                          Text(
                                            ' R\$${section2.price.toStringAsFixed(2)}',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w800,
                                                color: Theme.of(context).primaryColor
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ));
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
