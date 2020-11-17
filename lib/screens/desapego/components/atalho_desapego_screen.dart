import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mix_brasil/model/desapego/atalho_cat_desapego.dart';

class AtalhoDesapegoScreen extends StatelessWidget {

  AtalhoDesapegoScreen(this.atalhoCatDesapego);

  final AtalhoCatDesapego atalhoCatDesapego;

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 180,
                height: 60,
                child: RaisedButton(
                    onPressed: () {},
                    color: Theme.of(context).secondaryHeaderColor,
                    child: Text(
                      atalhoCatDesapego.name,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            topRight: Radius.circular(20)))),
              ),
              SizedBox(
                width: 180,
                height: 60,
                child: RaisedButton(
                    onPressed: () {},
                    color: Theme.of(context).secondaryHeaderColor,
                    child: Text(
                      'CARROS',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            topRight: Radius.circular(20)))),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 180,
                  height: 60,
                  child: RaisedButton(
                      onPressed: () {},
                      color: Theme.of(context).secondaryHeaderColor,
                      child: Text(
                        'PARA SUA CASA',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              topRight: Radius.circular(20)))),
                ),
                SizedBox(
                  width: 180,
                  height: 60,
                  child: RaisedButton(
                      onPressed: () {},
                      color: Theme.of(context).secondaryHeaderColor,
                      child: Text(
                        'SERVIÇOS',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              topRight: Radius.circular(20)))),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
