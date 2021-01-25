import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mix_brasil/stores/create_store.dart';

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
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 8,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ImagesField(createStore),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Título *',
              labelStyle: labelStyle,
              contentPadding: contentPadding
            ),
          ),
          TextFormField(
            decoration: InputDecoration(
                labelText: 'Descrição *',
                labelStyle: labelStyle,
                contentPadding: contentPadding
            ),
            maxLines: null,
          ),
          TextFormField(
            decoration: InputDecoration(
                labelText: 'Preço *',
                labelStyle: labelStyle,
                contentPadding: contentPadding,
                prefixText: 'R\$',
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              RealInputFormatter(centavos: true)
            ],
          ),
        ],
      ),
    );
  }
}
