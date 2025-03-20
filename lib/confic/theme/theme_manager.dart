import 'package:flutter/material.dart';
import 'package:flutter_news_app_clean_architecture/utils/colors_app.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class ThemeManager {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: kPrimaryColor,
      fontFamily: GoogleFonts.lora().fontFamily,
      textTheme:  TextTheme(
        titleLarge: TextStyle(
          color: kPrimaryTextColor,
        ),
        bodyLarge: TextStyle(
          color: kPrimaryTextColor,
        ),
        labelLarge: TextStyle(
          color: kPrimaryColor,
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
    );
  }
}
