import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mix_brasil/stores/cep_store.dart';
import 'package:mix_brasil/stores/create_loja_store.dart';

class CepLojasField extends StatelessWidget {

  CepLojasField(this.createLojaStore) : cepStore = createLojaStore.cepStore;

  final CreateLojaStore createLojaStore;
  final CepStore cepStore;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Observer(builder: (_){
          return TextFormField(
            initialValue: cepStore.cep,
            onChanged: cepStore.setCep,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              CepInputFormatter(),
            ],
            decoration: InputDecoration(
              hintText: '12.345-678',
              errorText: createLojaStore.addressError,
              labelText: 'CEP *',
              labelStyle: TextStyle(
                fontWeight: FontWeight.w800,
                color: Colors.grey,
                fontSize: 18,
              ),
              contentPadding: const EdgeInsets.fromLTRB(16, 10, 12, 10),
            ),
          );
        },
        ),
        Observer(builder: (_) {
          if (cepStore.address == null &&
              cepStore.error == null &&
              !cepStore.loading)
            return Container();
          else if (cepStore.address == null && cepStore.error == null)
            return LinearProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor),
              backgroundColor: Colors.transparent,
            );
          else if (cepStore.error != null)
            return Container(
              color: Colors.red.withAlpha(100),
              height: 50,
              padding: const EdgeInsets.all(8),
              alignment: Alignment.center,
              child: Text(
                cepStore.error,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.red,
                ),
              ),
            );
          else {
            final a = cepStore.address;
            return Container(
              color: Theme.of(context).primaryColor.withAlpha(150),
              height: 50,
              padding: const EdgeInsets.all(8),
              alignment: Alignment.center,
              child: Text(
                'Localização: ${a.district}, ${a.cidade.name} - ${a.uf.initials}',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            );
          }
        }),
      ],
    );
  }
}
