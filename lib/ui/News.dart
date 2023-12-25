import 'package:flutter/material.dart';

import '../providers/mainviewmodel.dart';

class News extends StatelessWidget {
  const News({super.key});
  static int idpage = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => MainViewModel().closeMenu(),
      child: Container(
        child: Center(child: Text("News")),
      ),
    );
  }
}