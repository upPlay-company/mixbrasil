import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mix_brasil/model/categorias/categorias_manager.dart';
import 'package:mix_brasil/model/desapego/desapego_manager.dart';
import 'package:mix_brasil/screens/categorias/categorias_lojas_screen.dart';
import 'package:mix_brasil/screens/inicial/inicial_screen.dart';
import 'package:provider/provider.dart';
import 'model/categorias/categorias.dart';
import 'model/home/home_manager.dart';
import 'model/lojas/lojas_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
          create: (_) => LojasManager(),
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
        ChangeNotifierProxyProvider<CategoriasManager, LojasManager>(
            create: (_) => LojasManager(),
            lazy: false,
            update: (_, categoriasManager, lojaManager) =>
                lojaManager..updateCategorias(categoriasManager)
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
            case 'lojas_categorias':
              return MaterialPageRoute(
                builder:  (_) => CategoriasLojasScreen(
                  settings.arguments as Categorias,
                ),
              );
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
