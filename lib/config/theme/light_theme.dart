import 'package:bookihub/shared/constant/colors.dart';
import 'package:flutter/material.dart';

class LightTheme {
  static themeData(){
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: blue),
      useMaterial3: true,
      appBarTheme: const AppBarTheme(
        color: white,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
          backgroundColor: MaterialStateProperty.all(blue),
          foregroundColor: MaterialStateProperty.all(white),
        ),
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
            color: white, fontFamily: 'Inter', fontWeight: FontWeight.w600),
        headlineMedium: TextStyle(fontSize: 22),
        headlineSmall:
            TextStyle(color: white, fontFamily: 'Inter', fontSize: 18),
        bodyLarge: TextStyle(fontFamily: 'Inter'),
        bodyMedium: TextStyle(fontFamily: 'Inter'),
      ),
    );

  }
}