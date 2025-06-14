import 'package:flutter/material.dart';

class PortfolioTheme {
  // Colors
  static const Color primaryColor = Color(0xFF0062FF); // Vibrant blue
  static const Color accentColor = Color(0xFF00D9F5); // Cyan
  static const Color darkBackground = Color(0xFF121212); // Dark background
  static const Color lightTextColor = Color(0xFFF5F5F5);
  static const Color darkTextColor = Color(0xFF121212);

  // Light Theme
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.light(
      primary: primaryColor,
      secondary: accentColor,
      surface: Colors.white,
    ),
    scaffoldBackgroundColor: Colors.white,
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 72.0,
        fontWeight: FontWeight.bold,
        color: darkTextColor,
      ),
      displayMedium: TextStyle(
        fontSize: 48.0,
        fontWeight: FontWeight.bold,
        color: darkTextColor,
      ),
      displaySmall: TextStyle(
        fontSize: 36.0,
        fontWeight: FontWeight.w600,
        color: darkTextColor,
      ),
      headlineMedium: TextStyle(
        fontSize: 28.0,
        fontWeight: FontWeight.w600,
        color: darkTextColor,
      ),
      bodyLarge: TextStyle(
        fontSize: 18.0,
        color: darkTextColor,
      ),
      bodyMedium: TextStyle(
        fontSize: 16.0,
        color: darkTextColor,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: lightTextColor,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
    ),
  );

  // Dark Theme
  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.dark(
      primary: primaryColor,
      secondary: accentColor,
      surface: Color(0xFF1E1E1E),
    ),
    scaffoldBackgroundColor: darkBackground,
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 72.0,
        fontWeight: FontWeight.bold,
        color: lightTextColor,
      ),
      displayMedium: TextStyle(
        fontSize: 48.0,
        fontWeight: FontWeight.bold,
        color: lightTextColor,
      ),
      displaySmall: TextStyle(
        fontSize: 36.0,
        fontWeight: FontWeight.w600,
        color: lightTextColor,
      ),
      headlineMedium: TextStyle(
        fontSize: 28.0,
        fontWeight: FontWeight.w600,
        color: lightTextColor,
      ),
      bodyLarge: TextStyle(
        fontSize: 18.0,
        color: lightTextColor,
      ),
      bodyMedium: TextStyle(
        fontSize: 16.0,
        color: lightTextColor,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: lightTextColor,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
    ),
  );
}
