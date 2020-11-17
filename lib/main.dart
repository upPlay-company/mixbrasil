import 'package:flutter/material.dart';
import 'package:mix_brasil/model/categorias/categorias_manager.dart';
import 'package:mix_brasil/model/desapego/desapego_manager.dart';
import 'package:mix_brasil/model/home/destaque_manager.dart';
import 'package:mix_brasil/screens/inicial/inicial_screen.dart';
import 'package:provider/provider.dart';
import 'model/home/home_manager.dart';

void main() {
  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => HomeManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => HomeDestaques(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => CategoriasManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => DesapegoManager(),
          lazy: false,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Color(0xff078c9f),
          secondaryHeaderColor: Color(0xfffea102),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: 'inicial',
        onGenerateRoute: (settings){
          switch(settings.name){
            case '/inicial':
            default:
              return MaterialPageRoute(
                builder: (_) => InicialScreen()
              );
          }
        },
      ),
    );
  }
}
