import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:mix_brasil/model/adm/adm_manager.dart';
import 'package:mix_brasil/model/categorias/categorias_manager.dart';
import 'package:mix_brasil/model/desapego/destaque_desapego_manager.dart';
import 'package:mix_brasil/model/dicas_mix/dicas_mix_desapegos_manager.dart';
import 'package:mix_brasil/model/dicas_mix/dicas_mix_lojas_manager.dart';
import 'package:mix_brasil/model/home/banners_manager.dart';
import 'package:mix_brasil/model/lojas/loja_destaque_manager.dart';
import 'package:mix_brasil/model/user/user_manager.dart';
import 'package:mix_brasil/screens/base/base_screen.dart';
import 'package:mix_brasil/screens/inicial/inicial_screen.dart';
import 'package:mix_brasil/screens/login/login_screen.dart';
import 'package:mix_brasil/screens/desapego/desapego_screen.dart';
import 'package:mix_brasil/stores/category_desapego_store.dart';
import 'package:mix_brasil/stores/category_lojas_store.dart';
import 'package:mix_brasil/stores/favorite_store.dart';
import 'package:mix_brasil/stores/filter_state_store.dart';
import 'package:provider/provider.dart';
import 'model/home/home_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupLocators();
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
        ChangeNotifierProvider(
          create: (_) => AdmManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => BannersManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => DicasMixLojasManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => DicasMixDesapegosManager(),
          lazy: false,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Mix Brasil',
        theme: ThemeData(
          primaryColor: Color(0xff078c9f),
          secondaryHeaderColor: Color(0xfffea102),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        supportedLocales: const [
          Locale('pt', 'BR'),
        ],
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        initialRoute: 'inicial',
        onGenerateRoute: (settings){
          switch(settings.name){
            case '/desapego_destaque':
              return MaterialPageRoute(
                builder: (_) => DesapegoScreen(),
              );
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

void setupLocators() {
  GetIt.I.registerSingleton(CategoryDesapegoStore());
  GetIt.I.registerSingleton(UserManager());
  GetIt.I.registerSingleton(FavoriteStore());
  GetIt.I.registerSingleton(CategoryLojasStore());
  GetIt.I.registerSingleton(FilterStateStore());
}
