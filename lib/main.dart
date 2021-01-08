import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mix_brasil/model/categorias/categorias_manager.dart';
import 'package:mix_brasil/model/desapego/destaque_desapego_manager.dart';
import 'package:mix_brasil/model/lojas/loja_destaque_manager.dart';
import 'package:mix_brasil/model/user/user_manager.dart';
import 'package:mix_brasil/screens/base/base_screen.dart';
import 'package:mix_brasil/screens/inicial/inicial_screen.dart';
import 'package:mix_brasil/screens/login/login_screen.dart';
import 'package:provider/provider.dart';
import 'model/home/home_manager.dart';

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
          create: (_) => CategoriasManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => LojasDestaqueManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => DestaqueDesapegoManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => UserManager(),
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
            case '/login':
              return MaterialPageRoute(
                builder: (_) => LoginScreen(),
              );
            case '/base':
              return MaterialPageRoute(
                builder: (_) => BaseScreen(),
              );
            case '/inicial':
            default:
              return MaterialPageRoute(
                builder: (_) => InicialScreen(),
              );
          }
        },
      ),
    );
  }
}
