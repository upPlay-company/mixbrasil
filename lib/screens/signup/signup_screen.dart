import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mix_brasil/helpers/validators.dart';
import 'package:mix_brasil/model/user/user.dart';
import 'package:mix_brasil/model/user/user_manager.dart';
import 'package:mix_brasil/screens/cep_user/cep_screen.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {

  static final _UsNumberTextInputFormatter _numberTextInputFormatter = new _UsNumberTextInputFormatter();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final UserUser user = UserUser();

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
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.fromLTRB(20, 30, 20, 10),
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
                                    validator: (nome){
                                      if(nome.isEmpty){
                                        return 'Digite seu nome';
                                      }
                                      return null;
                                    },
                                    onSaved: (name) => user.name = name,
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
                              padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
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
                                    onSaved: (email) => user.email = email,
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
                              padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
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
                                          return 'Digite seu telefone';
                                        }
                                        return null;
                                      },
                                    inputFormatters: <TextInputFormatter>[
                                      LengthLimitingTextInputFormatter(15),
                                      // ignore: deprecated_member_use
                                      WhitelistingTextInputFormatter.digitsOnly,
                                      _numberTextInputFormatter
                                    ],
                                    onSaved: (phone) => user.phone = phone,
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
                                    onSaved: (pass) => user.password = pass,
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
                              padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor.withAlpha(50),
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    autocorrect: false,
                                    obscureText: true,
                                    enabled: !userManager.loading,
                                    validator: (pass) {
                                      if(pass.isEmpty)
                                        return 'Campo obrigatório';
                                      else if(pass.length < 6)
                                        return 'Senha muito curta';
                                      return null;
                                    },
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                    onSaved: (pass) => user.confirmPassword = pass,
                                    decoration:
                                    InputDecoration(
                                        border: InputBorder.none,
                                        icon: Icon(Icons.highlight),
                                        hintText: 'Confirma a senha'
                                    ),
                                  ),
                                ),
                              )
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                            child: SizedBox(
                              height: 54,
                              width: MediaQuery.of(context).size.width,
                              child: RaisedButton(
                                onPressed: userManager.loading ? null : () async {
                                  if(formKey.currentState.validate()){
                                    formKey.currentState.save();
                                    if(user.password != user.confirmPassword){
                                      scaffoldKey.currentState.showSnackBar(
                                        SnackBar(
                                          content: const Text('Senhas não coincidem!',
                                            style: TextStyle(fontSize: 16, color: Colors.red),
                                          ),
                                          backgroundColor: Colors.black,
                                        ),
                                      );
                                      return;
                                    }
                                    userManager.signUp(
                                        user: user,
                                        onSuccess: (){
                                          Navigator.of(context).push(MaterialPageRoute(
                                            builder: (_) => CepUserScreen()
                                          ));
                                        },
                                        onFail: (e){
                                          scaffoldKey.currentState.showSnackBar(
                                              SnackBar(
                                                content: Text('Falha no login: $e',
                                                  style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                                                ),
                                                backgroundColor: Theme.of(context).primaryColor,
                                                behavior: SnackBarBehavior.floating,
                                                margin: EdgeInsets.all(16),
                                                duration: Duration(seconds: 2),
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                                              )
                                          );
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
                                      fontSize: 16,
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

class _UsNumberTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue
      ) {
    final int newTextLength = newValue.text.length;
    int selectionIndex = newValue.selection.end;
    int usedSubstringIndex = 0;
    final StringBuffer newText = StringBuffer();
    if (newTextLength >= 1) {
      newText.write('(');
      if (newValue.selection.end >= 1)
        selectionIndex++;
    }
    if (newTextLength >= 4) {
      newText.write(newValue.text.substring(0, usedSubstringIndex = 2) + ') ');
      if (newValue.selection.end >= 2)
        selectionIndex += 2;
    }
    if (newTextLength >= 7) {
      newText.write(newValue.text.substring(2, usedSubstringIndex = 7) + '-');
      if (newValue.selection.end >= 7)
        selectionIndex++;
    }
    if (newTextLength >= 11) {
      newText.write(newValue.text.substring(7, usedSubstringIndex = 11) + ' ');
      if (newValue.selection.end >= 15)
        selectionIndex++;
    }
    // Dump the rest.
    if (newTextLength >= usedSubstringIndex)
      newText.write(newValue.text.substring(usedSubstringIndex));
    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}


