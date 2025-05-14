import 'package:flutter/material.dart';

ThemeData customTheme() {
  return ThemeData(
    appBarTheme: AppBarTheme(backgroundColor: Color(0xFFFB8C00)),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white),
      titleLarge: TextStyle(color: Colors.white),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: Color(0xFFFB8C00),
      textTheme: ButtonTextTheme.primary,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFFFB8C00),
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 16),
        textStyle: TextStyle(fontSize: 16),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 16),
        textStyle: TextStyle(fontSize: 16),
        foregroundColor: Color(0xFFFB8C00),
        side: BorderSide(color: Color(0xFFFB8C00)),
      ),
    ),
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.orange,
    ).copyWith(background: Color(0xFFFB8C00)),
    // Adicionando a cor personalizada no tema
    scaffoldBackgroundColor: Colors.white,
    cardColor: Colors.black.withOpacity(0.8), // Cor personalizada para cards
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.black.withOpacity(
          0.8,
        ), // Cor de fundo para TextButton
      ),
    ),
  );
}
