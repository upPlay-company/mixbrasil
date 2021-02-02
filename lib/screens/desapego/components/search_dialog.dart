import 'package:flutter/material.dart';

class SearchDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 45,
          left: 2,
          right: 2,
          child: Card(
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                  ),
                  onPressed: Navigator.of(context).pop,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.close,
                  ),
                  onPressed: (){},
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
