import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mix_brasil/screens/criar_anuncio/components/cep_field.dart';
import 'package:mix_brasil/stores/create_store.dart';
import 'category_desapego_field.dart';
import 'images_field.dart';

class CriarAnuncioTile extends StatelessWidget {

  final CreateStore createStore = CreateStore();

  final labelStyle = TextStyle(
      fontWeight: FontWeight.w800,
      color: Colors.grey,
      fontSize: 18
  );

  final contentPadding = const EdgeInsets.fromLTRB(16, 10, 12, 10);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: Card(
          clipBehavior: Clip.antiAlias,
          margin: const EdgeInsets.symmetric(horizontal: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              ImagesField(createStore),
              Observer(builder: (_){
                return TextFormField(
                  onChanged: createStore.setTitle,
                  decoration: InputDecoration(
                      labelText: 'Título *',
                      labelStyle: labelStyle,
                      contentPadding: contentPadding,
                      errorText: createStore.titleError
                  ),
                );
              }),
              Observer(builder: (_){
                  return TextFormField(
                    onChanged: createStore.setDescription,
                    decoration: InputDecoration(
                        labelText: 'Descrição *',
                        labelStyle: labelStyle,
                        contentPadding: contentPadding,
                        errorText: createStore.descriptionError,
                    ),
                    maxLines: null,
                  );
                },
              ),
              CategoryDesapegoField(createStore),
              CepField(createStore),
              Observer(builder: (_){
                  return TextFormField(
                    onChanged: createStore.setPrice,
                    decoration: InputDecoration(
                        labelText: 'Preço *',
                        labelStyle: labelStyle,
                        contentPadding: contentPadding,
                        prefixText: 'R\$',
                        errorText: createStore.priceError
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      RealInputFormatter(centavos: true)
                    ],
                  );
                },
              ),
              SizedBox(height: 10,),
              Observer(builder: (_){
                  return SizedBox(
                    height: 50,
                    child: GestureDetector(
                      onTap: createStore.invalidSendPressed,
                      child: RaisedButton(
                        onPressed: createStore.sendPressed,
                        child: Text('Enviar', style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                            fontFamily: 'Principal'),
                        ),
                        textColor: Colors.white,
                        color: Theme.of(context).primaryColor,
                        disabledColor: Theme.of(context)
                            .primaryColor
                            .withAlpha(100),
                        elevation: 0,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
