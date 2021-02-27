import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mix_brasil/screens/criar_anuncio/components/category_desapego_screen.dart';
import 'package:mix_brasil/screens/criar_loja/components/category_screen.dart';
import 'package:mix_brasil/stores/create_loja_store.dart';

class CategoryField extends StatelessWidget {
  CategoryField(this.createLojaStore);

  final CreateLojaStore createLojaStore;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return Column(
          children: [
            ListTile(
              title: createLojaStore.category == null
                  ? Text(
                'Categoria *',
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Colors.grey,
                    fontSize: 18),
              )
                  : Text('Categoria *',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.grey,
                      fontSize: 14)),
              subtitle: createLojaStore.category == null
                  ? null
                  : Text(
                '${createLojaStore.category.name}',
                style: TextStyle(color: Colors.black, fontSize: 17),
              ),
              trailing: Icon(Icons.keyboard_arrow_down),
              onTap: () async {
                final categories = await showDialog(
                    context: context,
                    builder: (_) => CategoryScreen(
                      showAll: false,
                      selected: createLojaStore.category,
                    ));
                if (categories != null) {
                  createLojaStore.SetCategory(categories);
                }
              },
            ),
            if (createLojaStore.categoryError != null)
              Container(
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                    border: Border(top: BorderSide(color: Colors.red))),
                padding: const EdgeInsets.fromLTRB(16, 8, 0, 8),
                child: Text(
                  createLojaStore.categoryError,
                  style: TextStyle(color: Colors.red, fontSize: 12),
                ),
              )
            else
              Container(
                decoration: BoxDecoration(
                    border: Border(top: BorderSide(color: Colors.grey[500]))
                ),
              )
          ],
        );
      },
    );
  }
}
