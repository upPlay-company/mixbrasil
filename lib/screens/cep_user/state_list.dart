import 'package:flutter/material.dart';
import 'package:mix_brasil/screens/cep_user/components/filter_cep.dart';

class StateList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title:
            Text('Estado *',
            style: TextStyle(
                fontWeight: FontWeight.w800,
                color: Colors.grey,
                fontSize: 18),
          ),
          trailing: Icon(Icons.keyboard_arrow_down),
          onTap: () async {
              showDialog(
                context: context,
                builder: (_) => FilterCep());
          },
        ),
      ],
    );
  }
}
