import 'package:flutter/material.dart';

/// AppColors encapsulates the curated color palette for the Blinkit Money Wallet app.
/// It uses professional HSL-tailored colors, deep dark surfaces, vibrant yellows, and rich emerald greens.
class AppColors {
  AppColors._();

  // Branding Colors
  static const Color blinkitYellow = Color(0xFFF8E042);
  static const Color walletGreen = Color(0xFF0C8346);
  static const Color successGreen = Color(0xFF19B262);
  
  // Backgrounds
  static const Color backgroundLight = Color(0xFFF7F8FA);
  static const Color backgroundDark = Color(0xFF0E0F12);
  
  // Surface / Cards
  static const Color surfaceLight = Colors.white;
  static const Color surfaceDark = Color(0xFF181A20);
  static const Color surfaceDarkAlt = Color(0xFF222630);
  
  // Text Colors
  static const Color textPrimaryLight = Color(0xFF1C1C1E);
  static const Color textPrimaryDark = Color(0xFFF5F5F7);
  static const Color textSecondaryLight = Color(0xFF8E8E93);
  static const Color textSecondaryDark = Color(0xFFA0A5B5);

  // Status & Accents
  static const Color accentBlue = Color(0xFF007AFF);
  static const Color errorRed = Color(0xFFFF3B30);
  static const Color borderLight = Color(0xFFE5E5EA);
  static const Color borderDark = Color(0xFF2C2F3A);

  // Gradient definitions for a premium look
  static const Gradient goldGradient = LinearGradient(
    colors: [Color(0xFFFFF099), blinkitYellow],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Gradient greenGradient = LinearGradient(
    colors: [Color(0xFF129D55), walletGreen],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const Gradient darkGlassGradient = LinearGradient(
    colors: [Color(0x1AFFFFFF), Color(0x0AFFFFFF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
