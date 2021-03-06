import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mix_brasil/screens/cep_user/components/filter_cep.dart';
import 'package:mix_brasil/stores/filter_state_city_store.dart';

class StateList extends StatelessWidget {

  StateList(this.filterStateCityStore);

  final FilterStateCityStore filterStateCityStore;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return Column(
          children: [
            ListTile(
              title: filterStateCityStore.uf == null
                  ? Text(
                'Estado *',
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Colors.grey,
                    fontSize: 18),
              )
                  : Text('Estado *',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.grey,
                      fontSize: 14)),
              subtitle: filterStateCityStore.uf == null
                  ? null
                  : Text(
                '${filterStateCityStore.uf.name}',
                style: TextStyle(color: Colors.black, fontSize: 17),
              ),
              trailing: Icon(Icons.keyboard_arrow_down),
              onTap: () async {
                final state = await showDialog(
                    context: context,
                    builder: (_) => FilterState(
                      showAll: true,
                      selected: filterStateCityStore.uf,
                    ));
                if (state != null) {
                  filterStateCityStore.setState(state);
                }
              },
            ),
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
