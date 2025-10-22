import 'package:flutter/material.dart';
import 'colors.dart';

class CyberpunkTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: CyberpunkColors.darkBackground,
      primaryColor: CyberpunkColors.neonPink,
      colorScheme: const ColorScheme.dark(
        primary: CyberpunkColors.neonPink,
        secondary: CyberpunkColors.lightBlue,
        surface: Color(0xFF1A1A1A),
        error: CyberpunkColors.errorRed,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: CyberpunkColors.textPrimary,
        onError: Colors.white,
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 72,
          fontWeight: FontWeight.bold,
          color: CyberpunkColors.textPrimary,
          fontFamily: 'RobotoMono',
        ),
        displayMedium: TextStyle(
          fontSize: 48,
          fontWeight: FontWeight.bold,
          color: CyberpunkColors.textPrimary,
        ),
        titleLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w600,
          color: CyberpunkColors.textPrimary,
        ),
        titleMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w500,
          color: CyberpunkColors.textPrimary,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          color: CyberpunkColors.textPrimary,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          color: CyberpunkColors.textSecondary,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: CyberpunkColors.neonPink,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      cardTheme: CardTheme(
        color: const Color(0xFF1A1A1A),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: CyberpunkColors.neonPink.withOpacity(0.3),
            width: 1,
          ),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: CyberpunkColors.darkBackground,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: CyberpunkColors.textPrimary,
        ),
      ),
    );
  }
}
