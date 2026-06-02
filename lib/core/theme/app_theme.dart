import 'package:flutter/material.dart';
import 'app_colors.dart';

/// AppTheme manages the dark and light Material 3 design system config.
/// It provides highly polished UI attributes suitable for modern interfaces.
class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: AppColors.blinkitYellow,
      scaffoldBackgroundColor: AppColors.backgroundLight,
      cardColor: AppColors.surfaceLight,
      colorScheme: const ColorScheme.light(
        primary: AppColors.blinkitYellow,
        secondary: AppColors.walletGreen,
        surface: AppColors.surfaceLight,
        error: AppColors.errorRed,
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold, color: AppColors.textPrimaryLight, letterSpacing: -1.0),
        headlineMedium: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: AppColors.textPrimaryLight, letterSpacing: -0.5),
        titleLarge: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: AppColors.textPrimaryLight),
        titleMedium: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500, color: AppColors.textPrimaryLight),
        bodyLarge: TextStyle(fontSize: 15.0, fontWeight: FontWeight.normal, color: AppColors.textPrimaryLight),
        bodyMedium: TextStyle(fontSize: 13.0, fontWeight: FontWeight.normal, color: AppColors.textSecondaryLight),
        labelLarge: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600, color: AppColors.textPrimaryLight),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.textPrimaryLight),
        titleTextStyle: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: AppColors.textPrimaryLight),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Color(0xFFF2F2F7),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.walletGreen, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.errorRed, width: 1.5),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: AppColors.blinkitYellow,
      scaffoldBackgroundColor: AppColors.backgroundDark,
      cardColor: AppColors.surfaceDark,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.blinkitYellow,
        secondary: AppColors.walletGreen,
        surface: AppColors.surfaceDark,
        error: AppColors.errorRed,
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold, color: AppColors.textPrimaryDark, letterSpacing: -1.0),
        headlineMedium: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: AppColors.textPrimaryDark, letterSpacing: -0.5),
        titleLarge: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: AppColors.textPrimaryDark),
        titleMedium: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500, color: AppColors.textPrimaryDark),
        bodyLarge: TextStyle(fontSize: 15.0, fontWeight: FontWeight.normal, color: AppColors.textPrimaryDark),
        bodyMedium: TextStyle(fontSize: 13.0, fontWeight: FontWeight.normal, color: AppColors.textSecondaryDark),
        labelLarge: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600, color: AppColors.textPrimaryDark),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.textPrimaryDark),
        titleTextStyle: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: AppColors.textPrimaryDark),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceDarkAlt,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.walletGreen, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.errorRed, width: 1.5),
        ),
      ),
    );
  }
}
