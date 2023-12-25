import 'package:flutter/material.dart';

import '../providers/mainviewmodel.dart';

class Search extends StatelessWidget {
  const Search({super.key});
  static int idpage = 3;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => MainViewModel().closeMenu(),
      child: Container(
        child: Center(child: Text("Search")),
      ),
    );
  }
}
