import 'package:flutter/material.dart';

class ItemFilterWidget extends StatelessWidget {
  final bool _selected;
  final String _brand;

  ItemFilterWidget(this._brand, this._selected);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: Text(
        _brand,
        style: TextStyle(
          color: _selected ? Colors.black : Colors.black26,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }
}
