import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mix_brasil/screens/base/base_screen.dart';
import 'package:mix_brasil/style/style_screen_pattern.dart';

class InicialScreen extends StatefulWidget {
  @override
  _InicialScreenState createState() => _InicialScreenState();
}

class _InicialScreenState extends State<InicialScreen> {

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
    Future.delayed(Duration(seconds: 4)).then((_){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BaseScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return StyleScreenPattern(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('images/Logo mix.png'),
                    )
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('DESENVOLVIDO POR:', style: TextStyle(color: Colors.black, fontSize: 12),),
                  Container(
                    height: 70,
                    width: 120,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('images/Logo Upplay preto.png'),
                        )
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
