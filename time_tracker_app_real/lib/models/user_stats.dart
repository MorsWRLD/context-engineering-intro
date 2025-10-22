class UserStats {
  int totalXp;
  int totalCredits;
  int level;
  int currentStreak;
  int longestStreak;
  DateTime? lastSessionDate;
  Duration totalTimeTracked;
  int totalSessions;

  UserStats({
    this.totalXp = 0,
    this.totalCredits = 0,
    this.level = 1,
    this.currentStreak = 0,
    this.longestStreak = 0,
    this.lastSessionDate,
    Duration? totalTimeTracked,
    this.totalSessions = 0,
  }) : totalTimeTracked = totalTimeTracked ?? Duration.zero;

  // WoW-style progression: each level requires more XP
  int get xpForNextLevel => _getXpForLevel(level + 1);
  int get xpForCurrentLevel => _getXpForLevel(level);
  int get xpInCurrentLevel => totalXp - xpForCurrentLevel;
  double get progressToNextLevel {
    final xpNeeded = xpForNextLevel - xpForCurrentLevel;
    if (xpNeeded <= 0) return 0.0;
    return (xpInCurrentLevel / xpNeeded).clamp(0.0, 1.0);
  }
  
  int _getXpForLevel(int targetLevel) {
    if (targetLevel <= 1) return 0;
    // Formula: each level requires progressively more XP
    // Level 2: 100, Level 3: 250, Level 4: 450, etc.
    int totalXp = 0;
    for (int i = 2; i <= targetLevel; i++) {
      totalXp += 50 + (i * 50); // Starts at 100 for level 2, increases by 50 each level
    }
    return totalXp;
  }

  void addXp(int xp) {
    totalXp += xp;
    // Check for level ups
    while (totalXp >= xpForNextLevel && xpForNextLevel > 0) {
      level++;
    }
  }

  void addCredits(int credits) {
    totalCredits += credits;
  }

  void updateStreak(DateTime sessionDate) {
    if (lastSessionDate == null) {
      currentStreak = 1;
    } else {
      final daysDifference = sessionDate.difference(lastSessionDate!).inDays;
      if (daysDifference == 1) {
        currentStreak++;
      } else if (daysDifference > 1) {
        currentStreak = 1;
      }
      // If same day, streak doesn't change
    }
    
    if (currentStreak > longestStreak) {
      longestStreak = currentStreak;
    }
    
    lastSessionDate = sessionDate;
  }

  double getStreakMultiplier() {
    if (currentStreak >= 30) return 2.0;
    if (currentStreak >= 14) return 1.5;
    if (currentStreak >= 7) return 1.25;
    if (currentStreak >= 3) return 1.1;
    return 1.0;
  }

  Map<String, dynamic> toJson() => {
        'totalXp': totalXp,
        'totalCredits': totalCredits,
        'level': level,
        'currentStreak': currentStreak,
        'longestStreak': longestStreak,
        'lastSessionDate': lastSessionDate?.toIso8601String(),
        'totalTimeTracked': totalTimeTracked.inSeconds,
        'totalSessions': totalSessions,
      };

  factory UserStats.fromJson(Map<String, dynamic> json) => UserStats(
        totalXp: json['totalXp'] ?? 0,
        totalCredits: json['totalCredits'] ?? 0,
        level: json['level'] ?? 1,
        currentStreak: json['currentStreak'] ?? 0,
        longestStreak: json['longestStreak'] ?? 0,
        lastSessionDate: json['lastSessionDate'] != null
            ? DateTime.parse(json['lastSessionDate'])
            : null,
        totalTimeTracked: Duration(seconds: json['totalTimeTracked'] ?? 0),
        totalSessions: json['totalSessions'] ?? 0,
      );
}
