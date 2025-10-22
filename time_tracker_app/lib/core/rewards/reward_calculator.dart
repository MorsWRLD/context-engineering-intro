import '../../models/session.dart';

class RewardCalculator {
  // Base rates from PRP: 10 XP per 5 minutes, 5 credits per 10 minutes
  static const int baseXpRate = 10; // per 5 minutes
  static const int baseCreditRate = 5; // per 10 minutes

  /// Calculate XP and Credits for a completed session
  static Map<String, int> calculate({
    required Duration duration,
    required TimerMode mode,
    double streakMultiplier = 1.0,
  }) {
    final minutes = duration.inMinutes;

    // Calculate base rewards
    int xp = (minutes ~/ 5) * baseXpRate;
    int credits = (minutes ~/ 10) * baseCreditRate;

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
