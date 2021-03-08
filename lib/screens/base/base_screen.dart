import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:mix_brasil/screens/categorias/categorias_screens.dart';
import 'package:mix_brasil/screens/desapego/desapego_screen.dart';
import 'package:mix_brasil/screens/home/home_screen.dart';
import 'package:mix_brasil/screens/perfil/perfil.dart';
import 'package:bmnav/bmnav.dart' as bmnav;

class BaseScreen extends StatefulWidget {

  @override
  _BaseScreenState createState() => _BaseScreenState();
}


class _BaseScreenState extends State<BaseScreen> {

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
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Container(
          height: 70,
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
          ]),
          child: SafeArea(
            child: bmnav.BottomNav(
              iconStyle: bmnav.IconStyle(color: Colors.black, onSelectColor: Theme.of(context).primaryColor),
              index: _selectedIndex,
              labelStyle: bmnav.LabelStyle(textStyle: TextStyle(color: Colors.black, fontSize: 12), onSelectTextStyle: TextStyle(color: Theme.of(context).primaryColor, fontSize: 14)),
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
          ),
        ),
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
    );
  }
}
