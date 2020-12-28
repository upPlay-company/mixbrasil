import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:mix_brasil/screens/categorias/categorias_screens.dart';
import 'package:mix_brasil/screens/desapego/desapego_screen.dart';
import 'package:mix_brasil/screens/home/home_screen.dart';

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
    Container(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Container(
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
          ]),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
              child: GNav(
                gap: 3,
                activeColor: Colors.black,
                color: Colors.grey[700],
                iconSize: 25,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                duration: Duration(milliseconds: 800),
                tabBackgroundColor: Colors.white,
                tabs: [
                  GButton(
                    icon: LineIcons.home,
                    text: '',
                  ),
                  GButton(
                    icon: LineIcons.search,
                    text: '',
                  ),
                  GButton(
                    icon: LineIcons.list,
                    text: '',
                  ),
                  GButton(
                    icon: LineIcons.user,
                    text: '',
                  ),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: (index){
                  setState(() {
                    _selectedIndex = index;
                  });
                },
              ),
            ),
          ),
        ),
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        )
    );
  }
}
