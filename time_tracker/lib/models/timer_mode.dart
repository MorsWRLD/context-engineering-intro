/// Timer modes supported by the app.
/// Chill = baseline rewards; Grind = boosted rewards at higher energy cost (future mechanic).

enum TimerMode { chill, grind }

extension TimerModeX on TimerMode {
  /// XP multiplier applied to base XP rate.
  double get xpMultiplier => switch (this) {
        TimerMode.chill => 1.0,
        TimerMode.grind => 2.0,
      };

  /// Credit multiplier applied to base Credit rate.
  double get creditMultiplier => switch (this) {
        TimerMode.chill => 1.0,
        TimerMode.grind => 1.5,
      };

  /// Accent color key hint for theming layer.
  String get accentKey => switch (this) {
        TimerMode.chill => 'primary', // pink
        TimerMode.grind => 'secondary', // blue
      };

  static TimerMode fromString(String value) {
    final v = value.toLowerCase();
    if (v == 'grind') return TimerMode.grind;
    return TimerMode.chill;
  }

  String get name => switch (this) {
        TimerMode.chill => 'chill',
        TimerMode.grind => 'grind',
      };
}
