
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mix_brasil/common/error_box.dart';
import 'package:mix_brasil/model/desapego/desapego_category.dart';
import 'package:mix_brasil/stores/category_desapego_store.dart';

class CategoryDesapegoScreen extends StatelessWidget {

  CategoryDesapegoScreen({this.showAll = true, this.selected});

  final DesapegoCategory selected;
  final bool showAll;

  final CategoryDesapegoStore categoryDesapegoStore = GetIt.I<CategoryDesapegoStore>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/Fundo_mix.png'),
          fit: BoxFit.cover
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('Categorias', style: TextStyle(color: Colors.black),),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: Center(
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16)
            ),
            margin: const EdgeInsets.fromLTRB(32, 12, 32, 32),
            child: Observer(builder: (_) {
                if(categoryDesapegoStore.error != null) {
                  return ErrorBox(
                    message: categoryDesapegoStore.error,
                  );
                } else if(categoryDesapegoStore.categoryList.isEmpty) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  final categories = showAll
                      ? categoryDesapegoStore.allDesapegoCategoryList
                      : categoryDesapegoStore.categoryList;

                  return ListView.separated(
                    itemCount: categories.length,
                    separatorBuilder: (_, __){
                      return Divider(height: 0.1, color: Colors.grey,);
                    },
                    itemBuilder: (_, index) {
                      final category = categories[index];

                      return InkWell(
                        onTap: () {
                          Navigator.of(context).pop(category);
                        },
                        child: Container(
                          height: 50,
                          color: category.id == selected?.id ?
                               Theme.of(context).primaryColor.withAlpha(100) : null,
                          alignment: Alignment.center,
                          child: Text(
                            category.name,
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontWeight: category.id == selected?.id ?
                                  FontWeight.bold : null
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            )
          ),
        ),
      ),
    );
  }
}
