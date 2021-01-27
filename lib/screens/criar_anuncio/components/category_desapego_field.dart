import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mix_brasil/screens/criar_anuncio/components/category_desapego_screen.dart';
import 'package:mix_brasil/stores/create_store.dart';

class CategoryDesapegoField extends StatelessWidget {

  CategoryDesapegoField(this.createStore);

  final CreateStore createStore;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return ListTile(
          title: createStore.category == null ? Text(
            'Categoria *',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: Colors.grey,
              fontSize: 18
            ),
          ) : Text(
              'Categoria *',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.grey,
                  fontSize: 14
              )
          ),
          subtitle: createStore.category == null ? null :
          Text('${createStore.category.name}',
                style: TextStyle(
                       color: Colors.black,
                       fontSize: 17
          ),),
          trailing: Icon(Icons.keyboard_arrow_down),
          onTap: () async {
            final categories = await showDialog(context: context, builder: (_) => CategoryDesapegoScreen(
              showAll: false,
              selected: createStore.category,
            ));
            if(categories != null){
              createStore.setCategory(categories);
            }
          },
        );
      },
    );
  }
}
