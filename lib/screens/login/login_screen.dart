import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:line_icons/line_icons.dart';
import 'package:mix_brasil/common/error_box.dart';
import 'package:mix_brasil/main.dart';
import 'package:mix_brasil/screens/signup/signup_screen.dart';
import 'package:mix_brasil/stores/login_store.dart';
import 'package:mix_brasil/stores/user_manager_store.dart';
import 'package:mix_brasil/style/style_screen_pattern.dart';
import 'package:mobx/mobx.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginStore loginStore = LoginStore();

  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();

  @override
  void initState() {
    super.initState();

    when((_) => userManagerStore.user != null, () {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => MyApp()), (Route<dynamic> route) => false,);
    });
  }

  @override
  Widget build(BuildContext context) {
    return StyleScreenPattern(
      child: WillPopScope(
        onWillPop: () => Future.value(false),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  elevation: 8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          'Entre',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Observer(builder: (_) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: ErrorBox(
                            message: loginStore.error,
                          ),
                        );
                      }),
                      Observer(builder: (_){
                        return Padding(
                            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withAlpha(50),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  enabled: !loginStore.loading,
                                  autocorrect: false,
                                  onChanged: loginStore.setEmail,
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                  decoration: InputDecoration(
                                      errorText: loginStore.emailError,
                                      border: InputBorder.none,
                                      icon: Icon(Icons.email),
                                      hintText: 'Email'),
                                ),
                              ),
                            ));
                      }),
                      Observer(builder: (_){
                        return Padding(
                            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withAlpha(50),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  autocorrect: false,
                                  obscureText: true,
                                  enabled: !loginStore.loading,
                                  onChanged: loginStore.setPassword,
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                  decoration: InputDecoration(
                                      errorText: loginStore.passwordError,
                                      border: InputBorder.none,
                                      icon: Icon(Icons.lock),
                                      hintText: 'Senha'),
                                ),
                              ),
                            ));
                      }),
                      Observer(builder: (_){
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: loginStore.recoverPassword,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                child: Text(
                                  'Esqueceu sua senha?',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Principal'),
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                      Observer(builder: (_){
                        return Padding(
                          padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                          child: SizedBox(
                            height: 54,
                            width: MediaQuery.of(context).size.width,
                            // ignore: deprecated_member_use
                            child: RaisedButton(
                              onPressed: loginStore.loginPressed,
                              color: Theme.of(context).primaryColor,
                              child: loginStore.loading
                                  ? const CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(
                                    Colors.white),
                              )
                                  : Text(
                                'Entre',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                    fontFamily: 'Principal'),
                              ),
                              disabledColor: Theme.of(context)
                                  .primaryColor,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                        );
                      }),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                            child: Container(
                              height: 0.8,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          Text(
                            'OU',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                            child: Container(
                              height: 0.8,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ],
                      ),
                      Observer(builder: (_){
                        return Padding(
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
                          child: SizedBox(
                            height: 54,
                            width: MediaQuery.of(context).size.width,
                            // ignore: deprecated_member_use
                            child: RaisedButton(
                              onPressed: loginStore.loginFacebook,
                              color: Color(0xff166fe6),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    LineIcons.facebook,
                                    size: 25,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    'Entre pelo facebook',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                        fontFamily: 'Principal'),
                                  ),
                                ],
                              ),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                        );
                      }),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SignUpScreen()));
                        },
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Não tem conta? ',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Principal'),
                              ),
                              Text(
                                'Clique aqui',
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Principal'),
                              )
                            ],
                          ),
                        ),
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
                                    color: Colors.grey,
                                    fontSize: 14,
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
              ),
            ),
          ),
        ),
      ),
    );
  }
}
