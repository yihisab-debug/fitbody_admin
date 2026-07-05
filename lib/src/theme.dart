import 'package:flutter/material.dart';

class AppColors {
  static const background = Color(0xFF0E0E10);
  static const surface = Color(0xFF1A1A1F);
  static const card = Color(0xFF23232B);
  static const purple = Color(0xFF8B7CF6);
  static const purpleDark = Color(0xFF6C5CE0);
  static const lime = Color(0xFFCDEB45);
  static const textSecondary = Color(0xFFB5B5C0);
}

ThemeData buildAppTheme() {
  final base = ThemeData.dark(useMaterial3: true);
  return base.copyWith(
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: base.colorScheme.copyWith(
      primary: AppColors.purple,
      secondary: AppColors.lime,
      surface: AppColors.surface,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.background,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: AppColors.purple, fontSize: 18, fontWeight: FontWeight.bold),
      iconTheme: IconThemeData(color: AppColors.purple),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.lime,
        foregroundColor: Colors.black,
        minimumSize: const Size.fromHeight(52),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.card,
      hintStyle: const TextStyle(color: AppColors.textSecondary),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
    ),
  );
}
