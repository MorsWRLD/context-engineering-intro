import '../../models/achievement.dart';

class AchievementDefinitions {
  static List<Achievement> getDefaultAchievements() {
    return [
      Achievement(
        id: 'first_hour',
        name: 'First Hour Logged',
        description: 'Complete your first 60-minute session',
        type: AchievementType.duration,
        criteria: {'minutes': 60},
        reward: Reward(xp: 100, credits: 50),
      ),
      Achievement(
        id: 'streak_bronze',
        name: 'Daily Streak - Bronze',
        description: 'Maintain a 3-day streak',
        type: AchievementType.streak,
        criteria: {'days': 3},
        reward: Reward(xp: 150, credits: 200),
      ),
      Achievement(
        id: 'streak_silver',
        name: 'Daily Streak - Silver',
        description: 'Maintain a 7-day streak',
        type: AchievementType.streak,
        criteria: {'days': 7},
        reward: Reward(xp: 350, credits: 500),
      ),
      Achievement(
        id: 'streak_gold',
        name: 'Daily Streak - Gold',
        description: 'Maintain a 14-day streak',
        type: AchievementType.streak,
        criteria: {'days': 14},
        reward: Reward(xp: 750, credits: 1000),
      ),
      Achievement(
        id: 'streak_platinum',
        name: 'Daily Streak - Platinum',
        description: 'Maintain a 30-day streak',
        type: AchievementType.streak,
        criteria: {'days': 30},
        reward: Reward(xp: 1500, credits: 2500),
      ),
      Achievement(
        id: 'early_bird',
        name: 'Early Bird',
        description: 'Start a session before 7 AM',
        type: AchievementType.timeOfDay,
        criteria: {'hour': 7, 'type': 'before'},
        reward: Reward(xp: 50, credits: 25),
      ),
      Achievement(
        id: 'night_owl',
        name: 'Night Owl',
        description: 'Complete a session after 10 PM',
        type: AchievementType.timeOfDay,
        criteria: {'hour': 22, 'type': 'after'},
        reward: Reward(xp: 50, credits: 25),
      ),
      Achievement(
        id: 'marathon_runner',
        name: 'Marathon Runner',
        description: 'Complete a 4-hour session',
        type: AchievementType.duration,
        criteria: {'minutes': 240},
        reward: Reward(xp: 300, credits: 200),
      ),
      Achievement(
        id: 'mode_master',
        name: 'Mode Master',
        description: 'Use both Chill and Grind modes in one day',
        type: AchievementType.mode,
        criteria: {'both_modes': true},
        reward: Reward(xp: 100, credits: 100),
      ),
      Achievement(
        id: 'grind_specialist',
        name: 'Grind Specialist',
        description: 'Complete 10 Grind mode sessions',
        type: AchievementType.mode,
        criteria: {'mode': 'grind', 'count': 10},
        reward: Reward(xp: 200, credits: 150),
      ),
      Achievement(
        id: 'chill_master',
        name: 'Chill Master',
        description: 'Complete 10 Chill mode sessions',
        type: AchievementType.mode,
        criteria: {'mode': 'chill', 'count': 10},
        reward: Reward(xp: 200, credits: 150),
      ),
    ];
  }
}
