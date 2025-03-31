import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0x001D3D);
  static const Color secondaryColor = Color(0xFFD60A);
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
