import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:mix_brasil/helpers/validators.dart';
import 'package:mix_brasil/model/user/user.dart';
import 'package:mix_brasil/model/user/user_manager.dart';
import 'package:mix_brasil/screens/base/base_screen.dart';
import 'package:mix_brasil/screens/cep_user/cep_screen.dart';
import 'package:mix_brasil/screens/signup/signup_screen.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  //Declarações de funções
  Widget _snackBarRecover(String msgRecovery, dynamic scaffoldKey) {
    return scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(
        msgRecovery,
        style: TextStyle(
            fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
      ),
      backgroundColor: Color(0xff078c9f),
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(16),
      duration: Duration(seconds: 2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
    ));
  }

  //Fim Declarações de funções

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/Fundo_mix.png'), fit: BoxFit.cover)),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.transparent,
        body: Center(
          child: SingleChildScrollView(
            child: Consumer<UserManager>(
              builder: (_, userManager, __) {
                if (userManager.loadingFacebook) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      color: Colors.transparent,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(
                            Theme.of(context).primaryColor),
                      ),
                    ),
                  );
                }

                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Form(
                      key: formKey,
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
                          Padding(
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
                                    controller: emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    enabled: !userManager.loading,
                                    autocorrect: false,
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                    validator: (email) {
                                      if (!emailValid(email)) {
                                        return 'Email inválido';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        icon: Icon(Icons.email),
                                        hintText: 'Email'),
                                  ),
                                ),
                              )),
                          Padding(
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
                                    controller: passController,
                                    autocorrect: false,
                                    obscureText: true,
                                    enabled: !userManager.loading,
                                    validator: (pass) {
                                      if (pass.isEmpty || pass.length < 6) {
                                        return 'Senha inválida';
                                      }
                                      return null;
                                    },
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        icon: Icon(Icons.lock),
                                        hintText: 'Senha'),
                                  ),
                                ),
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  if (emailController.text.isEmpty)
                                    _snackBarRecover(
                                        "Insira seu e-mail para recuperação!",
                                        scaffoldKey);
                                  else {
                                    print(emailController.text);
                                    userManager
                                        .recoverPass(emailController.text);
                                    _snackBarRecover(
                                        "Verifique seu e-mail", scaffoldKey);
                                  }
                                },
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
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
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                            child: SizedBox(
                              height: 54,
                              width: MediaQuery.of(context).size.width,
                              // ignore: deprecated_member_use
                              child: RaisedButton(
                                onPressed: userManager.loading
                                    ? null
                                    : () {
                                        if (formKey.currentState.validate()) {
                                          userManager.signIn(
                                              user: UserUser(
                                                  email: emailController.text,
                                                  password:
                                                      passController.text),
                                              onFail: (e) {
                                                // ignore: deprecated_member_use
                                                scaffoldKey.currentState.showSnackBar(SnackBar(
                                                  content: Text(
                                                    'Falha no login: $e',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  backgroundColor:
                                                      Theme.of(context)
                                                          .primaryColor,
                                                  behavior:
                                                      SnackBarBehavior.floating,
                                                  margin: EdgeInsets.all(16),
                                                  duration:
                                                      Duration(seconds: 2),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100)),
                                                ));
                                              },
                                              onSuccess: () {
                                                if (userManager.user.address ==
                                                    null)
                                                  return Navigator.of(context)
                                                      .push(MaterialPageRoute(
                                                          builder: (_) =>
                                                              CepUserScreen()));
                                                else
                                                  return Navigator.of(context)
                                                      .push(MaterialPageRoute(
                                                          builder: (_) =>
                                                              BaseScreen()));
                                              });
                                        }
                                      },
                                color: Theme.of(context).primaryColor,
                                child: userManager.loading
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
                                    .primaryColor
                                    .withAlpha(100),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                          ),
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
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
                            child: SizedBox(
                              height: 54,
                              width: MediaQuery.of(context).size.width,
                              // ignore: deprecated_member_use
                              child: RaisedButton(
                                onPressed: () {
                                  userManager.facebookLogin(onFail: (e) {
                                    scaffoldKey.currentState
                                        // ignore: deprecated_member_use
                                        .showSnackBar(SnackBar(
                                        content: Text(
                                        'Falha no login: $e',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      backgroundColor:
                                          Theme.of(context).primaryColor,
                                      behavior: SnackBarBehavior.floating,
                                      margin: EdgeInsets.all(16),
                                      duration: Duration(seconds: 2),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                    ));
                                  }, onSuccess: () {
                                    if (userManager.user.address == null)
                                      return Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (_) => CepUserScreen()));
                                    else
                                      return Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (_) => BaseScreen()));
                                  });
                                },
                                color: Theme.of(context).primaryColor,
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
                          ),
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
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
