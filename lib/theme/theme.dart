import 'package:flutter/material.dart';

ThemeData customTheme() {
  return ThemeData(
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFFB8C00),
      foregroundColor: Colors.white,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.black),
      bodyMedium: TextStyle(color: Colors.black),
      titleLarge: TextStyle(color: Colors.black),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: Color(0xFFFB8C00),
      textTheme: ButtonTextTheme.primary,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFFB8C00),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        textStyle: const TextStyle(fontSize: 16),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        textStyle: const TextStyle(fontSize: 16),
        foregroundColor: const Color(0xFFFB8C00),
        side: const BorderSide(color: Color(0xFFFB8C00)),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.black.withOpacity(0.8),
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      labelStyle: TextStyle(color: Colors.black),
      hintStyle: TextStyle(color: Colors.black54),
      border: OutlineInputBorder(),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFFB8C00)),
      ),
    ),
    colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.orange).copyWith(
      background: const Color(0xFFFB8C00),
      brightness: Brightness.light,
    ),
    scaffoldBackgroundColor: Colors.white,
    cardColor: Colors.black.withOpacity(0.8),
  );
}
