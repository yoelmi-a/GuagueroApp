import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color.fromARGB(242, 0, 29, 61);
  static const Color secondaryColor = Color.fromARGB(255, 255, 214, 10);
  static const Color scaffoldColor = Colors.white;

  static ThemeData get lightTheme {
    return ThemeData(
      fontFamily: 'Poppins',
      primaryColor: primaryColor,
      secondaryHeaderColor: secondaryColor,
      scaffoldBackgroundColor: scaffoldColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(color: secondaryColor),
        bodyLarge: TextStyle(color: secondaryColor),
      ),
      colorScheme: const ColorScheme.light(
        primary: primaryColor,
        secondary: secondaryColor,
        surface: scaffoldColor,
      ),
    );
  }
}
