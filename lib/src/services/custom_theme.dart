import 'package:flutter/material.dart';
import 'package:quitanda_virtual/src/config/custom_colors.dart';

class CustomTheme {
  static ThemeData themeData() {
    return ThemeData(
      primarySwatch: Colors.green,
      primaryColor: Colors.white,
      scaffoldBackgroundColor: Colors.white.withAlpha(190),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          primary: CustomColors.customSwatchColor,
          // side: const BorderSide(color: Colors.grey),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          textStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ElevatedButton.styleFrom(
          // primary: CustomColors.customSwatchColor,
          //TODO Cor do texto do botão do tema
          onPrimary: CustomColors.customSwatchColor,
          side: BorderSide(color: CustomColors.customSwatchColor, width: 2),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          textStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        labelStyle: const TextStyle(fontSize: 18),
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
      ),
    );
  }
}
