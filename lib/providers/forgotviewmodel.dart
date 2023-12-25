import 'package:flutter/material.dart';
import 'package:flutter_application_2/repositories/forgot_repository.dart';
import 'dart:math';

class ForgotViewModel with ChangeNotifier {
  final forgotRepo = ForgotRepository();
  String errormessage = "";
  int status = 0;
  Future<void> forgotPassword(String email) async {
    status = 1;
    notifyListeners();
    errormessage = "";
    final bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    if (emailValid == false) {
      status = 2;
      errormessage += "Your email is not valid. Try again.\n";
    }
    if (status != 2) {
      if (await forgotRepo.forgotPassword(email) == true) {
        status = 3;
      } else {
        status = 2;
      }
    }
    notifyListeners();
  }
}
