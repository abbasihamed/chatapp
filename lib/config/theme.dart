import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final TextStyle basicStyle = GoogleFonts.roboto(
    color: Colors.black,
    fontSize: 20,
    fontWeight: FontWeight.w400,
  );
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      colorScheme: const ColorScheme.light(secondary: Color(0xFFD6755B)),
      textTheme: GoogleFonts.mulishTextTheme()
          .apply(bodyColor: const Color(0xFF53585A)),
      backgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 17,
          color: Color(0xFF53585A),
        ),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      scaffoldBackgroundColor: Colors.white,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style:
            ElevatedButton.styleFrom(backgroundColor: const Color(0xFF3B76F6)),
      ),
      cardColor: const Color(0xFFF9FAFE),
      primaryTextTheme: const TextTheme(
        headline6: TextStyle(color: Color(0xFF53585A)),
      ),
      iconTheme: const IconThemeData(color: Color(0xFFB1B3C1)),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(secondary: Color(0xFFD6755B)),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      textTheme: GoogleFonts.mulishTextTheme()
          .apply(bodyColor: const Color(0xFFF5F5F5)),
      backgroundColor: const Color(0xFF1B1E1F),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 17,
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      scaffoldBackgroundColor: const Color(0xFF303334),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style:
            ElevatedButton.styleFrom(backgroundColor: const Color(0xFF3B76F6)),
      ),
      cardColor: const Color(0xFF303334),
      primaryTextTheme: const TextTheme(
        headline6: TextStyle(color: Color(0xFFF5F5F5)),
      ),
      iconTheme: const IconThemeData(color: Color(0xFFB1B4C0)),
    );
  }
}
