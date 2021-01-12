/*
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Facebook Login",
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var facebookLogin = new FacebookLogin();
  String photo = "";

  void loginWithFacebook() async {
    var result = await facebookLogin.logInWithReadPermissions(['email', 'public_profile']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        User user = await FirebaseAuth.instance.signInWithFacebook(accessToken: result.accessToken.token);

        setState(() {
          photo = user.photoUrl;
        });
        break;
      case FacebookLoginStatus.cancelledByUser:
        print("Facebook login cancelled");
        break;
      case FacebookLoginStatus.error:
        print(result.errorMessage);
        break;
    }
  }

  void facebookLogout() {
    facebookLogin.logOut();
    FirebaseAuth.instance.signOut();
    setState(() {
      photo = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Login"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              (photo != "")
                  ? Image.network(photo)
                  : new RaisedButton(
                child: Text("Conectar com o Facebook"),
                color: Colors.lightBlue,
                textColor: Colors.white,
                onPressed: loginWithFacebook,
              ),
              new RaisedButton(
                child: Text("Sair"),
                color: Colors.lightBlue,
                textColor: Colors.white,
                onPressed: facebookLogout,
              )
            ],
          ),
        ));
  }
}*/
