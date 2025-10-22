import 'package:flutter/foundation.dart';
import '../../models/achievement.dart';
import '../../models/session.dart';
import '../../models/user_stats.dart';
import 'achievement_definitions.dart';

class AchievementTracker extends ChangeNotifier {
  List<Achievement> _achievements = [];
  final List<Achievement> _recentlyUnlocked = [];

  List<Achievement> get achievements => _achievements;
  List<Achievement> get recentlyUnlocked => _recentlyUnlocked;
  List<Achievement> get unlockedAchievements =>
      _achievements.where((a) => a.isUnlocked).toList();
  List<Achievement> get lockedAchievements =>
      _achievements.where((a) => !a.isUnlocked).toList();

  void initialize() {
    _achievements = AchievementDefinitions.getDefaultAchievements();
    notifyListeners();
  }

  void loadAchievements(List<Achievement> achievements) {
    _achievements = achievements;
    notifyListeners();
  }

  /// Check achievements after a session is completed
  List<Achievement> checkSessionAchievements(
    Session session,
    UserStats stats,
    List<Session> allSessions,
  ) {
    _recentlyUnlocked.clear();

    for (var achievement in _achievements) {
      if (achievement.isUnlocked) continue;

      bool unlocked = false;

      switch (achievement.type) {
        case AchievementType.duration:
          unlocked = _checkDurationAchievement(achievement, session);
          break;
        case AchievementType.streak:
          unlocked = _checkStreakAchievement(achievement, stats);
          break;
        case AchievementType.timeOfDay:
          unlocked = _checkTimeOfDayAchievement(achievement, session);
          break;
        case AchievementType.mode:
          unlocked = _checkModeAchievement(achievement, session, allSessions);
          break;
      }

      if (unlocked) {
        achievement.isUnlocked = true;
        achievement.progress = 1.0;
        _recentlyUnlocked.add(achievement);
      }
    }

    if (_recentlyUnlocked.isNotEmpty) {
      notifyListeners();
    }

    return _recentlyUnlocked;
  }

  bool _checkDurationAchievement(Achievement achievement, Session session) {
    final requiredMinutes = achievement.criteria['minutes'] as int;
    return session.duration.inMinutes >= requiredMinutes;
  }

  bool _checkStreakAchievement(Achievement achievement, UserStats stats) {
    final requiredDays = achievement.criteria['days'] as int;
    return stats.currentStreak >= requiredDays;
  }

  bool _checkTimeOfDayAchievement(Achievement achievement, Session session) {
    final hour = achievement.criteria['hour'] as int;
    final type = achievement.criteria['type'] as String;
    final sessionHour = session.startTime.hour;

    if (type == 'before') {
      return sessionHour < hour;
    } else if (type == 'after') {
      return sessionHour >= hour;
    }

    return false;
  }

  bool _checkModeAchievement(
    Achievement achievement,
    Session session,
    List<Session> allSessions,
  ) {
    // Check for "both modes in one day"
    if (achievement.criteria['both_modes'] == true) {
      final today = DateTime.now();
      final todaySessions = allSessions.where((s) {
        return s.startTime.year == today.year &&
            s.startTime.month == today.month &&
            s.startTime.day == today.day;
      }).toList();

      final hasGrind = todaySessions.any((s) => s.mode == TimerMode.grind);
      final hasChill = todaySessions.any((s) => s.mode == TimerMode.chill);

      return hasGrind && hasChill;
    }

    // Check for mode-specific count
    if (achievement.criteria.containsKey('mode') &&
        achievement.criteria.containsKey('count')) {
      final requiredMode = achievement.criteria['mode'] as String;
      final requiredCount = achievement.criteria['count'] as int;

      final mode = requiredMode == 'grind' ? TimerMode.grind : TimerMode.chill;
      final count = allSessions.where((s) => s.mode == mode).length;

      return count >= requiredCount;
    }

    return false;
  }

  void clearRecentlyUnlocked() {
    _recentlyUnlocked.clear();
    notifyListeners();
  }

  void resetAchievements() {
    initialize();
  }
}
