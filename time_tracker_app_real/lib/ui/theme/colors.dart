import 'package:flutter/material.dart';

class CyberpunkColors {
  // Primary Colors
  static const Color neonPink = Color(0xFFFF006E);
  static const Color lightBlue = Color(0xFF00D9FF);
  static const Color darkBackground = Color(0xFF0A0A0A);

  // Secondary Colors
  static const Color successGreen = Color(0xFF00FF88);
  static const Color warningOrange = Color(0xFFFF9500);
  static const Color errorRed = Color(0xFFFF0040);

  // Text Colors
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFA0A0A0);

  // Mode-specific colors
  static const Color chillMode = neonPink;
  static const Color grindMode = lightBlue;

  // Gradients
  static const LinearGradient pinkGradient = LinearGradient(
    colors: [neonPink, Color(0xFFCC0058)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient blueGradient = LinearGradient(
    colors: [lightBlue, Color(0xFF00A8CC)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Glow effects
  static List<BoxShadow> neonGlow(Color color, {double blur = 20.0}) {
    return [
      BoxShadow(
        color: color.withOpacity(0.6),
        blurRadius: blur,
        spreadRadius: blur / 4,
      ),
      BoxShadow(
        color: color.withOpacity(0.3),
        blurRadius: blur * 2,
        spreadRadius: blur / 2,
      ),
    ];
  }
}
