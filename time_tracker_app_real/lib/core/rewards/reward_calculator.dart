import '../../models/session.dart';

class RewardCalculator {
  // Base rates: 10 XP per minute (every 6 seconds), 1 credit per 5 minutes
  static const int xpPerMinute = 10;
  static const double creditsPerMinute = 0.2; // 1 credit every 5 minutes

  /// Calculate XP and Credits for a completed session
  static Map<String, int> calculate({
    required Duration duration,
    required TimerMode mode,
    double streakMultiplier = 1.0,
  }) {
    final totalSeconds = duration.inSeconds;
    final minutes = duration.inMinutes;

    // Calculate base rewards (XP per second for real-time feel)
    // 10 XP per minute = ~0.167 XP per second, we'll use 1 XP per 6 seconds
    int xp = (totalSeconds / 6).floor();
    // Credits: 1 per 5 minutes = 1 per 300 seconds
    int credits = (totalSeconds / 300).floor();

    // Apply mode multipliers
    if (mode == TimerMode.grind) {
      xp = (xp * 2).toInt(); // 2x XP for grind mode
      credits = (credits * 1.5).toInt(); // 1.5x credits for grind mode
    }

    // Apply streak multiplier
    xp = (xp * streakMultiplier).toInt();
    credits = (credits * streakMultiplier).toInt();

    return {
      'xp': xp,
      'credits': credits,
    };
  }

  /// Calculate bonus for achievements
  static int calculateAchievementBonus(int baseReward, double multiplier) {
    return (baseReward * multiplier).toInt();
  }
}
