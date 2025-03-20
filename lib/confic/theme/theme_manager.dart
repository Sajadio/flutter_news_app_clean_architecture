import 'package:flutter/material.dart';

abstract class ThemeManager {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.red,
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
