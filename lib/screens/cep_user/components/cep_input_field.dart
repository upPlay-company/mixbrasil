import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mix_brasil/common/custom_icon_button.dart';
import 'package:mix_brasil/model/cep/address.dart';
import 'package:mix_brasil/model/user/user_manager.dart';
import 'package:provider/provider.dart';

class CepInputField extends StatefulWidget {

  CepInputField(this.address);

  final Address address;

  @override
  _CepInputFieldState createState() => _CepInputFieldState();
}

class _CepInputFieldState extends State<CepInputField> {

  final TextEditingController cepController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final userManager = context.watch<UserManager>();

    if(widget.address.zipCode == null)
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextFormField(
            enabled: !userManager.loading,
            controller: cepController,
            decoration: const InputDecoration(
                isDense: true,
                labelText: 'CEP',
                hintText: '12.345-678'
            ),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              CepInputFormatter(),
            ],
            keyboardType: TextInputType.number,
            validator: (cep){
              if(cep.isEmpty)
                return 'Campo obrigatório';
              else if(cep.length != 10)
                return 'CEP Inválido';
              return null;
            },
          ),
          if(userManager.loading)
            LinearProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.black),
              backgroundColor: Colors.transparent,
            ),
          RaisedButton(
            onPressed: !userManager.loading ? () async {
              if(Form.of(context).validate()){
                try {
                  await context.read<UserManager>().getAddress(cepController.text);
                } catch (e){
                  Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text('$e',
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
              }
            }: null,
            color: Colors.black,
            disabledColor: Colors.black.withAlpha(100),
            child: const Text('Buscar CEP',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          )
        ],
      );
    else
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Expanded(
              child: Text(
                'CEP: ${widget.address.zipCode}',
                style: TextStyle(
                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            CustomIconButton(
              iconData: Icons.edit,
              color: Colors.redAccent,
              size: 20,
              onTap: (){
                context.read<UserManager>().removeAddress();
              },
            )
          ],
        ),
      );
  }
}