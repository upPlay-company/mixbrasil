import 'package:flutter/material.dart';
import 'package:mix_brasil/main.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mix_brasil/stores/filter_state_city_store.dart';

import 'components/state_list.dart';

class FilterLocal extends StatefulWidget {
  @override
  _FilterLocalState createState() => _FilterLocalState();
}

class _FilterLocalState extends State<FilterLocal> {
  final FilterStateCityStore filterStateCityStore = FilterStateCityStore();

  @override
  void initState() {
    super.initState();

    when((_) => filterStateCityStore.saveState, () {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => MyApp(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Escolha uma localidade'),
          centerTitle: true,
        ),
        body: Card(
          margin: EdgeInsets.all(20),
          elevation: 8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              StateList(filterStateCityStore),
              Observer(
                builder: (_) {
                  return SizedBox(
                    height: 50,
                    child: GestureDetector(
                      onTap: filterStateCityStore.invalidSendPressed,
                      child: RaisedButton(
                        onPressed: filterStateCityStore.sendPressed,
                        child: Text(
                          'FILTRAR',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                              fontFamily: 'Principal'),
                        ),
                        textColor: Colors.white,
                        color: Theme.of(context).primaryColor,
                        disabledColor:
                            Theme.of(context).primaryColor.withAlpha(100),
                        elevation: 0,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ));
  }
}
