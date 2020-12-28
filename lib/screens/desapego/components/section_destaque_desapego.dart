import 'package:flutter/material.dart';
import 'package:mix_brasil/model/desapego/desapego_destaque.dart';
import 'package:mix_brasil/screens/desapego/components/itens_desapego_destaque.dart';


class SectionDestaquesDesapego extends StatelessWidget {

  SectionDestaquesDesapego(this.desapegoDestaque);

  final DesapegoDestaque desapegoDestaque;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => ItensDestaqueDesapego(desapegoDestaque)),
          );
        },
        child: Container(
            height: 120,
            padding: EdgeInsets.only(top: 15),
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            child: Card(
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: SizedBox(
                      width: 130,
                      height: 100,
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Image.network(
                          desapegoDestaque.img.first,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    //teste
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 3.0),
                                child: Text(
                                  desapegoDestaque.name,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 15,
                              color: Colors.grey[700],
                            ),
                            Text(
                              "Concessonária FORD",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.grey[700]),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 18, right: 10,),
                          child: Row(
                            children: <Widget>[
                              Text(
                                'R\$${desapegoDestaque.price.toStringAsFixed(2)}',
                                textScaleFactor: 1.2,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )));
  }
}
