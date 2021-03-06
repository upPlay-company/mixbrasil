import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mix_brasil/common/error_box.dart';
import 'package:mix_brasil/model/cep/uf.dart';
import 'package:mix_brasil/stores/filter_state_store.dart';

class FilterState extends StatelessWidget {

  FilterState({this.selected, this.showAll});

  final UF selected;
  final bool showAll;

  final FilterStateStore filterStateStore = GetIt.I<FilterStateStore>();

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
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Estados'),
          centerTitle: true,
          elevation: 0,
        ),
        body: Observer(builder: (_) {
          if(filterStateStore.error != null) {
            return ErrorBox(
              message: filterStateStore.error,
            );
          } else if(filterStateStore.listState.isEmpty) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            final states = showAll
                ? filterStateStore.allStateList
                : filterStateStore.listState;

            return ListView.separated(
              itemCount: states.length,
              separatorBuilder: (_, __){
                return Divider(height: 0.1, color: Colors.grey,);
              },
              itemBuilder: (_, index) {
                final state = states[index];

                return InkWell(
                  onTap: () {
                    Navigator.of(context).pop(state);
                  },
                  child: Container(
                    height: 50,
                    color: state.id == selected?.id ?
                    Theme.of(context).primaryColor.withAlpha(100) : null,
                    alignment: Alignment.center,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            state.name,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: state.id == selected?.id ?
                                FontWeight.bold : null
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
        ),
      ),
    );
  }
}
