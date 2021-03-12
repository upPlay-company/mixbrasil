import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:line_icons/line_icons.dart';
import 'package:mix_brasil/screens/categorias/categorias_screens.dart';
import 'package:mix_brasil/screens/desapego/desapego_screen.dart';
import 'package:mix_brasil/screens/home/home_screen.dart';
import 'package:mix_brasil/screens/offline/offline_screen.dart';
import 'package:mix_brasil/screens/perfil/perfil.dart';
import 'package:bmnav/bmnav.dart' as bmnav;
import 'package:mix_brasil/stores/connectivity_store.dart';
import 'package:mobx/mobx.dart';

class BaseScreen extends StatefulWidget {

  @override
  _BaseScreenState createState() => _BaseScreenState();
}


class _BaseScreenState extends State<BaseScreen> {

  final ConnectivityStore connectivityStore = GetIt.I<ConnectivityStore>();

  int _selectedIndex = 0;
  /*static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);*/
  static List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    CategoriasScreen(),
    DesapegoScreen(),
    Perfil(),
  ];

  Widget currentScreen = HomeScreen();

  @override
  void initState() {
    super.initState();

    autorun((_) {
      print(connectivityStore.connected);
      if (!connectivityStore.connected) {
        Future.delayed(Duration(milliseconds: 50)).then((value) {
          showDialog(context: context, builder: (_) => OfflineScreen());
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: bmnav.BottomNav(
          iconStyle: bmnav.IconStyle(color: Colors.black, onSelectColor: Theme.of(context).primaryColor),
          index: _selectedIndex,
          labelStyle: bmnav.LabelStyle(textStyle: TextStyle(color: Colors.black, fontSize: 10), onSelectTextStyle: TextStyle(color: Theme.of(context).primaryColor, fontSize: 14)),
          onTap: (i){
            setState(() {
              _selectedIndex = i;
              currentScreen = _widgetOptions[i];
            });
          },
          items: [
            bmnav.BottomNavItem(LineIcons.home, label: 'Home'),
            bmnav.BottomNavItem(LineIcons.search, label: 'Lojas'),
            bmnav.BottomNavItem(LineIcons.list, label: 'Desapego'),
            bmnav.BottomNavItem(LineIcons.user, label: 'Perfil'),
          ],
        ),
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
    );
  }
}
