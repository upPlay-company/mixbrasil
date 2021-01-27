import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:mix_brasil/helpers/validators.dart';
import 'package:mix_brasil/model/user/user_manager.dart';
import 'package:mix_brasil/style/style_screen_pattern.dart';
import 'package:provider/provider.dart';

class MinhaContaScreen extends StatelessWidget {
  static final _UsNumberTextInputFormatter2 _numberTextInputFormatter =
      new _UsNumberTextInputFormatter2();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return StyleScreenPattern(
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          centerTitle: true,
          iconTheme: new IconThemeData(color: Colors.black),
          title: Text(
            'MINHA CONTA',
            style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.bold,
                fontFamily: 'Principal'),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Consumer<UserManager>(
          builder: (_, userManager, __) {
            return Form(
              key: formKey,
              child: ListView(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 150,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 110, right: 110, bottom: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: GFAvatar(
                                  size: 84,
                                  backgroundImage: NetworkImage(
                                    userManager.user?.img ??
                                        'https://ipc.digital/wp-content/uploads/2016/07/icon-user-default.png',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    color: Colors.white70,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 16, right: 16, top: 10, bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextFormField(
                            initialValue: userManager.user.name,
                            keyboardType: TextInputType.name,
                            validator: (name) {
                              if (name.isEmpty)
                                return 'Campo obrigatório';
                              else if (name.trim().split(' ').length <= 1)
                                return 'Preencha seu nome e sobrenome';
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'Nome*',
                              labelStyle: TextStyle(
                                  fontSize: 18,
                                  color: Theme.of(context).primaryColor),
                            ),
                            onSaved: (name) => userManager.user.name = name,
                          ),
                          TextFormField(
                            readOnly: true,
                            initialValue: userManager.user.email,
                            keyboardType: TextInputType.emailAddress,
                            validator: (email) {
                              if (!emailValid(email)) {
                                return 'Email inválido';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'Email',
                              labelStyle: TextStyle(
                                  fontSize: 18,
                                  color: Theme.of(context).primaryColor),
                              suffixIcon: Icon(Icons.lock),
                            ),
                          ),
                          TextFormField(
                            readOnly: true,
                            initialValue: userManager.user.address.zipCode,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: 'CEP',
                              labelStyle: TextStyle(
                                  fontSize: 18,
                                  color: Theme.of(context).primaryColor),
                              suffixIcon: Icon(Icons.lock),
                            ),
                          ),
                          TextFormField(
                            initialValue: userManager.user.phone,
                            keyboardType: TextInputType.number,
                            validator: (phone) {
                              if (phone.isEmpty) {
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
                            decoration: InputDecoration(
                              labelText: 'Telefone*',
                              labelStyle: TextStyle(
                                  fontSize: 18,
                                  color: Theme.of(context).primaryColor),
                            ),
                            onSaved: (phone) => userManager.user.phone = phone,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            '(*) Campos obrigatórios',
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Principal',
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 54,
                                width: 200,
                                child: RaisedButton(
                                  onPressed: !userManager.loading
                                      ? () async {
                                          if (formKey.currentState.validate()) {
                                            formKey.currentState.save();
                                            await userManager.user.save();
                                            scaffoldKey.currentState
                                                .showSnackBar(
                                              SnackBar(
                                                content: const Text(
                                                  'Cadastro atualizado com sucesso!',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                backgroundColor: Colors.blue,
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                margin: EdgeInsets.all(16),
                                                duration: Duration(seconds: 2),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100)),
                                              ),
                                            );
                                            context
                                                .read<UserManager>()
                                                .update(userManager.user);
                                          }
                                        }
                                      : null,
                                  color: Theme.of(context).primaryColor,
                                  child: userManager.user.loading
                                      ? const CircularProgressIndicator(
                                          valueColor: AlwaysStoppedAnimation(
                                              Colors.white),
                                        )
                                      : Text(
                                          'ATUALIZAR',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 20,
                                              fontFamily: 'Principal'),
                                        ),
                                  disabledColor: Theme.of(context)
                                      .primaryColor
                                      .withAlpha(100),
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
class _UsNumberTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final int newTextLength = newValue.text.length;
    int selectionIndex = newValue.selection.end;
    int usedSubstringIndex = 0;
    final StringBuffer newText = new StringBuffer();
    if (newTextLength >= 3) {
      newText.write(newValue.text.substring(0, usedSubstringIndex = 2) + "/");
      if (newValue.selection.end >= 2) selectionIndex++;
    }
    if (newTextLength >= 5) {
      newText.write(newValue.text.substring(2, usedSubstringIndex = 4) + "/");
      if (newValue.selection.end >= 4) selectionIndex++;
    }
    if (newTextLength >= 9) {
      newText.write(newValue.text.substring(4, usedSubstringIndex = 8));
      if (newValue.selection.end >= 8) selectionIndex++;
    }
// Dump the rest.
    if (newTextLength >= usedSubstringIndex)
      newText.write(newValue.text.substring(usedSubstringIndex));
    return new TextEditingValue(
      text: newText.toString(),
      selection: new TextSelection.collapsed(offset: selectionIndex),
    );
  }
}

class _UsNumberTextInputFormatter2 extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final int newTextLength = newValue.text.length;
    int selectionIndex = newValue.selection.end;
    int usedSubstringIndex = 0;
    final StringBuffer newText = StringBuffer();
    if (newTextLength >= 1) {
      newText.write('(');
      if (newValue.selection.end >= 1) selectionIndex++;
    }
    if (newTextLength >= 4) {
      newText.write(newValue.text.substring(0, usedSubstringIndex = 2) + ') ');
      if (newValue.selection.end >= 2) selectionIndex += 2;
    }
    if (newTextLength >= 7) {
      newText.write(newValue.text.substring(2, usedSubstringIndex = 7) + '-');
      if (newValue.selection.end >= 7) selectionIndex++;
    }
    if (newTextLength >= 11) {
      newText.write(newValue.text.substring(7, usedSubstringIndex = 11) + ' ');
      if (newValue.selection.end >= 15) selectionIndex++;
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
