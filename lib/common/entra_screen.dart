import 'package:flutter/material.dart';
import 'package:mix_brasil/screens/login/login_screen.dart';

class FacaLoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return         Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/Fundo_mix.png'), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Icon(
                    Icons.login,
                    size: 80.0,
                    color: Theme.of(context).primaryColor,
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Text(
                    "Faça login!",
                    style: TextStyle(
                        fontSize: 25.0, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 32.0,
                  ),
                  SizedBox(
                    height: 54.0,
                    child: RaisedButton(
                      child: Text(
                        "Entrar",
                        style: TextStyle(fontSize: 22.0),
                      ),
                      textColor: Colors.white,
                      color: Theme.of(context).primaryColor,
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => LoginScreen()));
                      },
                      disabledColor:
                      Theme.of(context).primaryColor.withAlpha(100),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('/base');
                  },
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: Text(
                      'Voltar',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Principal'),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
