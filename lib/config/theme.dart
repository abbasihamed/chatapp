import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final TextStyle basicStyle = GoogleFonts.roboto(
    color: Colors.black,
    fontSize: 20,
    fontWeight: FontWeight.w400,
  );
  static ThemeData get appTheme {
    return ThemeData(
      primaryColor: const Color.fromARGB(255, 29, 101, 160),
      errorColor: Colors.red,
      textTheme: TextTheme(
        bodyText1: basicStyle,
        subtitle1: basicStyle.copyWith(fontSize: 14, color: Colors.grey[700]),
        caption: basicStyle.copyWith(fontSize: 14, color: Colors.grey[700]),
      ),
    );
  }
}
