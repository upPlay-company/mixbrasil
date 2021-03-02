import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mix_brasil/model/cep/uf.dart';
import 'package:mix_brasil/repositories/ibge_repository.dart';

class FilterCep extends StatefulWidget {
  @override
  _FilterCepState createState() => _FilterCepState();
}

class _FilterCepState extends State<FilterCep> {

  Future<List<UF>> listState;

  @override
  void initState() {
    super.initState();
    listState = IBGERepository().getUFList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Estados'),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          margin: EdgeInsets.all(20),
          elevation: 8,
          child: FutureBuilder<List<UF>>(
            future: listState,
            builder: (context, snapshot){
              if(snapshot.hasData){
                return ListView.separated(
                  itemCount: snapshot.data.length,
                  itemBuilder: (_, index){

                    final category = snapshot.data[index].name;

                    return GestureDetector(
                      onTap: (){
                        print(category);
                        Navigator.of(context).pop(category);
                      },
                      child: Container(
                        height: 50,
                        alignment: Alignment.center,
                        child: Text(
                          snapshot.data[index].name,
                          style: TextStyle(
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (_, __){
                    return Divider(height: 0.1, color: Colors.grey,);
                  },
                );
              } else if(snapshot.hasError){
                return Text('${snapshot.error}');
              }
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
