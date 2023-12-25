import 'package:flutter/material.dart';
import 'package:flutter_application_2/repositories/register_repository.dart';

class RegisterViewModel with ChangeNotifier {
  int status = 0;
  String errormessage = "";
  bool agree = false;
  final registerRepo = RegisterRepository();
  String terms = "You must agree with our terms and conditions: \n" +
      "1.Love the Motherland, love the fellow countrymen.\n" +
      "2.Study well, work well.\n" +
      "3.Unity is good, discipline is good.\n" +
      "4.Maintain very good hygiene.\n" +
      "5.Be modest, honest, and courageous.";
  void setAgree(bool value) {
    agree = value;
    notifyListeners();
  }

  Future<void> register(
    String email,
    String username,
    String pass1,
    String pass2,
  ) async {
    status = 1;
    notifyListeners();
    errormessage = "";
    if (agree == false) {
      status == 2;
      errormessage +=
          "You must agree with our terms and conditions before register !";
    }
    if (email.isEmpty || username.isEmpty || pass1.isEmpty) {
      status == 2;
      errormessage += "Email, username, and password are required";
    }
    final bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    if (emailValid == false) {
      status = 2;
      errormessage += "Your email is not valid. Try again.\n";
    }
    if (pass1.length < 8) {
      status = 2;
      errormessage += "The password must be at least 8 characters long.\n";
    }
    if (pass1 != pass2) {
      status = 2;
      errormessage += "The entered passwords do not match. Try again.\n";
    }
    if (status != 2)
      status = await registerRepo.register(email, username, pass1);
    notifyListeners();
  }
}
