import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AppConstant {
  static TextStyle textfancyheader =
      GoogleFonts.mochiyPopOne(fontSize: 40, color: Color(0xFFC8132B));

  static TextStyle texterror = TextStyle(
      color: Color(0xFFC8132B), fontSize: 16, fontStyle: FontStyle.italic);

  static TextStyle textlink = TextStyle(color: Color(0xFFC8132B), fontSize: 18);
  static TextStyle textbody = TextStyle(color: Colors.white, fontSize: 16);
  static TextStyle textbodybold =
      TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold);
  static TextStyle textfocuswhite =
      TextStyle(color: Colors.white, fontSize: 20);
  static bool isDate(String str) {
    try {
      var inputFormat = DateFormat('dd/MM/yyyy');
      var date1 = inputFormat.parseStrict(str);
      return true;
    } catch (e) {
      return false;
    }
  }
}
