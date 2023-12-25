import 'package:flutter/material.dart';

import '../providers/mainviewmodel.dart';

class Checkins extends StatelessWidget {
  const Checkins({super.key});
  static int idpage = 2;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => MainViewModel().closeMenu(),
      child: Container(
        child: Center(child: Text("Checkins")),
      ),
    );
  }
}
