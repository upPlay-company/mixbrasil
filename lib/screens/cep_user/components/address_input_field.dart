import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mix_brasil/model/cep/address.dart';
import 'package:mix_brasil/model/user/user_manager.dart';
import 'package:provider/provider.dart';

class AddressInputField extends StatelessWidget {

  const AddressInputField(this.address);

  final Address address;

  @override
  Widget build(BuildContext context) {
    final userManager = context.watch<UserManager>();

    String emptyValidator(String text) =>
        text.isEmpty ? 'Campo obrigatório' : null;

    if(userManager.isLoggedIn && userManager.user.address == null && address.zipCode != null)
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            enabled: !userManager.loading,
            initialValue: address.street,
            decoration: const InputDecoration(
              isDense: true,
              labelText: 'Rua/Avenida',
              hintText: 'Av. Brasil',
            ),
            validator: emptyValidator,
            onSaved: (t) => address.street = t,
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  enabled: !userManager.loading,
                  initialValue: address.number,
                  decoration: InputDecoration(
                    isDense: true,
                    labelText: 'Número',
                    hintText: '123',
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  keyboardType: TextInputType.number,
                  validator: emptyValidator,
                  onSaved: (t) => address.number = t,
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: TextFormField(
                  enabled: !userManager.loading,
                  initialValue: address.complement,
                  decoration: InputDecoration(
                    isDense: true,
                    labelText: 'Complemento',
                    hintText: 'Opcional',
                  ),
                  onSaved: (t) => address.complement = t,
                ),
              ),
            ],
          ),
          TextFormField(
            enabled: !userManager.loading,
            initialValue: address.district,
            decoration: const InputDecoration(
              isDense: true,
              labelText: 'Bairro',
              hintText: 'Guanabara',
            ),
            validator: emptyValidator,
            onSaved: (t) => address.district = t,
          ),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: TextFormField(
                  enabled: false,
                  initialValue: address.city,
                  decoration: InputDecoration(
                    isDense: true,
                    labelText: 'Cidade',
                    hintText: 'São Paulo',
                  ),
                  validator: emptyValidator,
                  onSaved: (t) => address.city = t,
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: TextFormField(
                  autocorrect: false,
                  enabled: false,
                  initialValue: address.state,
                  decoration: InputDecoration(
                    isDense: true,
                    labelText: 'UF',
                    hintText: 'SP',
                    counterText: '',
                  ),
                  validator: (e) {
                    if(e.isEmpty){
                      return 'Campo obrigatório';
                    } else if(e.length != 2){
                      return 'Inválido';
                    }
                    return null;
                  },
                  onSaved: (t) => address.state = t,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8,),
          if(userManager.loading)
            LinearProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.black),
              backgroundColor: Colors.transparent,
            ),
          RaisedButton(
            color: Colors.black,
            disabledColor: Colors.black.withAlpha(100),
            textColor: Colors.white,
            onPressed: !userManager.loading ? () async {
              if(Form.of(context).validate()){
                Form.of(context).save();
                try {
                  await context.read<UserManager>().setAddress(address);
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
            child: const Text('Salvar Endereço', style: TextStyle(fontSize: 16),),
          )
        ],
      );
    else if(userManager.isLoggedIn && userManager.user.address != null && address.zipCode != null)
      return Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Text(
          '${userManager.user.address.street}, ${userManager.user.address.number}\n${userManager.user.address.district}\n'
              '${userManager.user.address.city} - ${userManager.user.address.state}',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      );
    else return Container();
  }
}