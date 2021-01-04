import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mix_brasil/helpers/validators.dart';
import 'package:mix_brasil/model/user/user.dart';
import 'package:mix_brasil/model/user/user_manager.dart';
import 'package:mix_brasil/screens/base/base_screen.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passConfirmController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

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
        key: scaffoldKey,
        backgroundColor: Colors.transparent,
        body: Center(
          child: SingleChildScrollView(
            child: Consumer<UserManager>(
              builder: (_, userManager, __){
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text('Cadastro',
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.fromLTRB(20, 30, 20, 20),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor.withAlpha(50),
                                    borderRadius: BorderRadius.circular(10)
                                ),
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
                                    validator: (nome){
                                      if(nome.isEmpty){
                                        return 'Digite seu nome';
                                      }
                                      return null;
                                    },
                                    decoration:
                                    InputDecoration(
                                        border: InputBorder.none,
                                        icon: Icon(Icons.person),
                                        hintText: 'Nome'
                                    ),
                                  ),
                                ),
                              )
                          ),
                          Padding(
                              padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor.withAlpha(50),
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    keyboardType: TextInputType.emailAddress,
                                    enabled: !userManager.loading,
                                    autocorrect: false,
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                    validator: (email){
                                      if(!emailValid(email)){
                                        return 'Email inválido';
                                      }
                                      return null;
                                    },
                                    decoration:
                                    InputDecoration(
                                        border: InputBorder.none,
                                        icon: Icon(Icons.email),
                                        hintText: 'Email'
                                    ),
                                  ),
                                ),
                              )
                          ),
                          Padding(
                              padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor.withAlpha(50),
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    enabled: !userManager.loading,
                                    autocorrect: false,
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                      validator: (phone){
                                        if(phone.isEmpty){
                                          return 'Digite seu nome';
                                        }
                                        return null;
                                      },
                                    decoration:
                                    InputDecoration(
                                        border: InputBorder.none,
                                        icon: Icon(Icons.phone),
                                        hintText: 'Número de Telefone'
                                    ),
                                  ),
                                ),
                              )
                          ),
                          Padding(
                              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor.withAlpha(50),
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    controller: passController,
                                    autocorrect: false,
                                    obscureText: true,
                                    enabled: !userManager.loading,
                                    validator: (pass) {
                                      if(pass.isEmpty || pass.length < 6){
                                        return 'Senha inválida';
                                      }
                                      return null;
                                    },
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                    decoration:
                                    InputDecoration(
                                        border: InputBorder.none,
                                        icon: Icon(Icons.lock),
                                        hintText: 'Senha'
                                    ),
                                  ),
                                ),
                              )
                          ),
                          Padding(
                              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor.withAlpha(50),
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    controller: passConfirmController,
                                    autocorrect: false,
                                    obscureText: true,
                                    enabled: !userManager.loading,
                                    validator: (pass) {
                                      if(passController.text != passConfirmController.text){
                                        return 'Senha não corresponde';
                                      }
                                      return null;
                                    },
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                    decoration:
                                    InputDecoration(
                                        border: InputBorder.none,
                                        icon: Icon(Icons.highlight),
                                        hintText: 'Confirme a senha'
                                    ),
                                  ),
                                ),
                              )
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                            child: SizedBox(
                              height: 54,
                              width: MediaQuery.of(context).size.width,
                              child: RaisedButton(
                                onPressed: userManager.loading ? null : (){
                                  if(formKey.currentState.validate()){
                                    userManager.signIn(
                                        user: UserUser(
                                            confirmPassword: passConfirmController.text,
                                        ),
                                        onFail: (e){
                                          scaffoldKey.currentState.showSnackBar(
                                              SnackBar(
                                                content: Text('Falha ao entrar: $e'),
                                                backgroundColor: Colors.red,
                                              )
                                          );
                                        },
                                        onSuccess: (){
                                          Navigator.of(context).push(MaterialPageRoute(
                                              builder: (_) => BaseScreen()
                                          ));
                                        }
                                    );
                                  }
                                },
                                color: Theme.of(context).primaryColor,
                                child: userManager.loading ?
                                const CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation(Colors.white),
                                ) : Text(
                                  'CADASTRA - SE',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20,
                                      fontFamily: 'Principal'
                                  ),
                                ),
                                disabledColor: Theme.of(context).primaryColor.withAlpha(100),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)
                                ),
                              ),
                            ),
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
