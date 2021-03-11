import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mix_brasil/common/error_box.dart';
import 'package:mix_brasil/main.dart';
import 'package:mix_brasil/stores/signup_store.dart';
import 'package:mix_brasil/stores/user_manager_store.dart';
import 'package:mobx/mobx.dart';

class SignUpScreen extends StatefulWidget {

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final SignupStore signupStore = SignupStore();

  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();

  @override
  void initState() {
    super.initState();

    when((_) => userManagerStore.user != null, () {
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => MyApp()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/Fundo_mix.png'),
              fit: BoxFit.cover
          )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text('Cadastro',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    Observer(builder: (_) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: ErrorBox(message: signupStore.error),
                      );
                    }),
                    Observer(builder: (_){
                      return Padding(
                          padding: EdgeInsets.fromLTRB(20, 30, 20, 10),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor.withAlpha(50),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                onChanged: signupStore.setName,
                                keyboardType: TextInputType.emailAddress,
                                enabled: !signupStore.loading,
                                autocorrect: false,
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                                decoration: InputDecoration(
                                    errorText: signupStore.nameError,
                                    border: InputBorder.none,
                                    icon: Icon(Icons.person),
                                    hintText: 'Nome'
                                ),
                              ),
                            ),
                          )
                      );
                    }),
                    Observer(builder: (_){
                      return Padding(
                          padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor.withAlpha(50),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                onChanged: signupStore.setEmail,
                                keyboardType: TextInputType.emailAddress,
                                enabled: !signupStore.loading,
                                autocorrect: false,
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                                decoration:
                                InputDecoration(
                                    errorText: signupStore.emailError,
                                    border: InputBorder.none,
                                    icon: Icon(Icons.email),
                                    hintText: 'Email'
                                ),
                              ),
                            ),
                          )
                      );
                    }),
                    Observer(builder: (_){
                      return Padding(
                          padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor.withAlpha(50),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                onChanged: signupStore.setPhone,
                                keyboardType: TextInputType.number,
                                enabled: !signupStore.loading,
                                autocorrect: false,
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                                inputFormatters: <TextInputFormatter>[
                                  LengthLimitingTextInputFormatter(15),
                                  FilteringTextInputFormatter.digitsOnly,
                                  TelefoneInputFormatter()
                                ],
                                decoration:
                                InputDecoration(
                                    errorText: signupStore.phoneError,
                                    border: InputBorder.none,
                                    icon: Icon(Icons.phone),
                                    hintText: 'Número de Telefone'
                                ),
                              ),
                            ),
                          )
                      );
                    }),
                    Observer(builder: (_){
                      return                     Padding(
                          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor.withAlpha(50),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                onChanged: signupStore.setPass1,
                                autocorrect: false,
                                obscureText: true,
                                enabled: !signupStore.loading,
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                                decoration:
                                InputDecoration(
                                    errorText: signupStore.pass1Error,
                                    border: InputBorder.none,
                                    icon: Icon(Icons.lock),
                                    hintText: 'Senha'
                                ),
                              ),
                            ),
                          )
                      );
                    }),
                    Observer(builder: (_){
                      return Padding(
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor.withAlpha(50),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                onChanged: signupStore.setPass2,
                                autocorrect: false,
                                obscureText: true,
                                enabled: !signupStore.loading,
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                                decoration:
                                InputDecoration(
                                    errorText: signupStore.pass2Error,
                                    border: InputBorder.none,
                                    icon: Icon(Icons.highlight),
                                    hintText: 'Confirma a senha'
                                ),
                              ),
                            ),
                          )
                      );
                    }),
                    Observer(builder: (_){
                      return                     Padding(
                        padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                        child: SizedBox(
                          height: 54,
                          width: MediaQuery.of(context).size.width,
                          // ignore: deprecated_member_use
                          child: RaisedButton(
                            onPressed: signupStore.signUpPressed,
                            color: Theme.of(context).primaryColor,
                            child: signupStore.loading ?
                            const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                            ) : Text(
                              'CADASTRA - SE',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  fontFamily: 'Principal'
                              ),
                            ),
                            disabledColor: Theme.of(context).primaryColor,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                          ),
                        ),
                      );
                    }),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: (){
                            Navigator.of(context).pushNamed('/login');
                          },
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                            child: Text(
                              'Voltar',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Principal'
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ),
        ),
      ),
    );
  }
}

