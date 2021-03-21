import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mix_brasil/stores/edit_account_store.dart';
import 'package:mobx/mobx.dart';

class MinhaContaScreen extends StatefulWidget {
  @override
  _MinhaContaScreenState createState() => _MinhaContaScreenState();
}

class _MinhaContaScreenState extends State<MinhaContaScreen> {
  final EditAccountStore store = EditAccountStore();

  @override
  void initState() {
    super.initState();

    when((_) => store.saveUser == true, () {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Dados atualizados com sucesso!'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: (){
                Navigator.of(context).pop();
              },
              child: Text('Ok', style: TextStyle(color: Theme.of(context).primaryColor),),
            ),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          centerTitle: true,
          iconTheme: new IconThemeData(color: Colors.black),
          title: Text(
            'MINHA CONTA',
            style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Principal'),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: ListView(
          children: [
            SizedBox(
              height: 30,
            ),
            Container(
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  image:
                      DecorationImage(image: AssetImage('images/Mix 230.png'))),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              color: Colors.white70,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 16, right: 16, top: 10, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Observer(builder: (_) {
                      return TextFormField(
                        initialValue: store.user.name,
                        keyboardType: TextInputType.name,
                        onChanged: store.setName,
                        decoration: InputDecoration(
                          labelText: 'Nome*',
                          errorText: store.nameError,
                          labelStyle: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context).primaryColor),
                        ),
                      );
                    }),
                    TextFormField(
                      readOnly: true,
                      initialValue: store.user.email,
                      onChanged: store.setEmail,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).primaryColor),
                        suffixIcon: Icon(Icons.lock),
                      ),
                    ),
                    Observer(builder: (_) {
                      return TextFormField(
                        initialValue: store.user.phone,
                        keyboardType: TextInputType.number,
                        onChanged: store.setPhone,
                        inputFormatters: <TextInputFormatter>[
                          LengthLimitingTextInputFormatter(15),
                          FilteringTextInputFormatter.digitsOnly,
                          TelefoneInputFormatter()
                        ],
                        decoration: InputDecoration(
                          errorText: store.phoneError,
                          labelText: 'Telefone*',
                          labelStyle: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context).primaryColor),
                        ),
                      );
                    }),
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
                          // ignore: deprecated_member_use
                          child: Observer(builder: (_){
                            // ignore: deprecated_member_use
                            return RaisedButton(
                              onPressed: store.savePressed,
                              color: Theme.of(context).primaryColor,
                              child: store.user.loading
                                  ? const CircularProgressIndicator(
                                valueColor:
                                AlwaysStoppedAnimation(Colors.white),
                              )
                                  : Text(
                                'ATUALIZAR',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                    fontFamily: 'Principal'),
                              ),
                              disabledColor:
                              Theme.of(context).primaryColor.withAlpha(100),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                            );
                          }),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
