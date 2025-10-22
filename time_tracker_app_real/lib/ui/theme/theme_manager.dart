import 'package:flutter/material.dart';
import 'cyberpunk_theme.dart';

enum AppTheme {
  cyberpunk,
  minimal,
  neon,
  matrix,
  vaporwave,
}

class ThemeManager {
  static AppTheme _currentTheme = AppTheme.cyberpunk;
  static final Set<AppTheme> _unlockedThemes = {AppTheme.cyberpunk};

  static AppTheme get currentTheme => _currentTheme;
  static Set<AppTheme> get unlockedThemes => Set.from(_unlockedThemes);

  static void setTheme(AppTheme theme) {
    if (_unlockedThemes.contains(theme)) {
      _currentTheme = theme;
    }
  }

  static void unlockTheme(AppTheme theme) {
    _unlockedThemes.add(theme);
  }

  static bool isThemeUnlocked(AppTheme theme) {
    return _unlockedThemes.contains(theme);
  }

  static ThemeData getThemeData() {
    switch (_currentTheme) {
      case AppTheme.cyberpunk:
        return CyberpunkTheme.darkTheme;
      case AppTheme.minimal:
        return CyberpunkTheme.darkTheme; // TODO: Create minimal theme
      case AppTheme.neon:
        return CyberpunkTheme.darkTheme; // TODO: Create neon theme
      case AppTheme.matrix:
        return CyberpunkTheme.darkTheme; // TODO: Create matrix theme
      case AppTheme.vaporwave:
        return CyberpunkTheme.darkTheme; // TODO: Create vaporwave theme
    }
  }

  static Map<String, dynamic> toJson() => {
        'currentTheme': _currentTheme.name,
        'unlockedThemes': _unlockedThemes.map((t) => t.name).toList(),
      };

  static void fromJson(Map<String, dynamic> json) {
    final themeName = json['currentTheme'] as String?;
    if (themeName != null) {
      _currentTheme = AppTheme.values.firstWhere(
        (t) => t.name == themeName,
        orElse: () => AppTheme.cyberpunk,
      );
    }

    final unlocked = json['unlockedThemes'] as List<dynamic>?;
    if (unlocked != null) {
      _unlockedThemes.clear();
      for (var name in unlocked) {
        final theme = AppTheme.values.firstWhere(
          (t) => t.name == name,
          orElse: () => AppTheme.cyberpunk,
        );
        _unlockedThemes.add(theme);
      }
    }
  }
}
