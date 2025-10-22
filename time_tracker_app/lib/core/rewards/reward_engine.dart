import 'package:flutter/foundation.dart';
import '../../models/session.dart';
import '../../models/user_stats.dart';
import 'reward_calculator.dart';

class RewardEngine extends ChangeNotifier {
  UserStats _stats = UserStats();

  UserStats get stats => _stats;

  void loadStats(UserStats stats) {
    _stats = stats;
    notifyListeners();
  }

  /// Process a completed session and update user stats
  Map<String, int> processSession(Session session) {
    // Update streak
    _stats.updateStreak(session.startTime);
    
    // Calculate rewards with streak multiplier
    final rewards = RewardCalculator.calculate(
      duration: session.activeDuration,
      mode: session.mode,
      streakMultiplier: _stats.getStreakMultiplier(),
    );

    final xp = rewards['xp']!;
    final credits = rewards['credits']!;

    // Update session with earned rewards
    session.xpEarned = xp;
    session.creditsEarned = credits;

    // Update user stats
    _stats.addXp(xp);
    _stats.addCredits(credits);
    _stats.totalTimeTracked += session.activeDuration;
    _stats.totalSessions++;

    notifyListeners();

    return rewards;
  }

  /// Add bonus rewards from achievements
  void addBonusRewards({int xp = 0, int credits = 0}) {
    if (xp > 0) _stats.addXp(xp);
    if (credits > 0) _stats.addCredits(credits);
    notifyListeners();
  }

  void resetStats() {
    _stats = UserStats();
    notifyListeners();
  }
}
