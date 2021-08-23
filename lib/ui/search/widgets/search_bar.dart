import 'package:flutter/material.dart';
import 'search_field.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(),
      child: Padding(
        padding: const EdgeInsets.only(left: 5),
        child: SearchField(),
      ),
    );
  }
}
