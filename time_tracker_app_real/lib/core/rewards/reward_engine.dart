import 'package:flutter/foundation.dart';
import '../../models/session.dart';
import '../../models/user_stats.dart';
import 'reward_calculator.dart';

class RewardEngine extends ChangeNotifier {
  UserStats _stats = UserStats();
  Duration _lastRewardUpdate = Duration.zero;

  UserStats get stats => _stats;

  void loadStats(UserStats stats) {
    _stats = stats;
    _lastRewardUpdate = Duration.zero;
    notifyListeners();
  }

  /// Update rewards live during an active session
  void updateLiveRewards(Session session, TimerMode mode) {
    final currentDuration = session.duration;
    
    // Only update rewards for each completed second
    if (currentDuration.inSeconds > _lastRewardUpdate.inSeconds) {
      final incrementalDuration = currentDuration - _lastRewardUpdate;
      
      // Calculate incremental rewards
      final rewards = RewardCalculator.calculate(
        duration: incrementalDuration,
        mode: mode,
        streakMultiplier: _stats.getStreakMultiplier(),
      );

      final xp = rewards['xp']!;
      final credits = rewards['credits']!;

      // Update user stats incrementally
      _stats.addXp(xp);
      _stats.addCredits(credits);
      
      _lastRewardUpdate = currentDuration;
      notifyListeners();
    }
  }

  /// Process a completed session and update user stats
  Map<String, int> processSession(Session session) {
    // Update streak
    _stats.updateStreak(session.startTime);
    
    // Calculate total rewards (not incremental since we already did that live)
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

    // Update totals and reset for next session
    _stats.totalTimeTracked += session.activeDuration;
    _stats.totalSessions++;
    _lastRewardUpdate = Duration.zero;

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
