enum AchievementType {
  streak,
  duration,
  timeOfDay,
  mode,
}

class Reward {
  final int xp;
  final int credits;

  Reward({required this.xp, required this.credits});

  Map<String, dynamic> toJson() => {
        'xp': xp,
        'credits': credits,
      };

  factory Reward.fromJson(Map<String, dynamic> json) => Reward(
        xp: json['xp'] ?? 0,
        credits: json['credits'] ?? 0,
      );
}

class Achievement {
  final String id;
  final String name;
  final String description;
  final AchievementType type;
  final Map<String, dynamic> criteria;
  final Reward reward;
  double progress;
  bool isUnlocked;

  Achievement({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    required this.criteria,
    required this.reward,
    this.progress = 0.0,
    this.isUnlocked = false,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'type': type.name,
        'criteria': criteria,
        'reward': reward.toJson(),
        'progress': progress,
        'isUnlocked': isUnlocked,
      };

  factory Achievement.fromJson(Map<String, dynamic> json) => Achievement(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        type: AchievementType.values.firstWhere((t) => t.name == json['type']),
        criteria: json['criteria'],
        reward: Reward.fromJson(json['reward']),
        progress: json['progress']?.toDouble() ?? 0.0,
        isUnlocked: json['isUnlocked'] ?? false,
      );

  Achievement copyWith({
    double? progress,
    bool? isUnlocked,
  }) {
    return Achievement(
      id: id,
      name: name,
      description: description,
      type: type,
      criteria: criteria,
      reward: reward,
      progress: progress ?? this.progress,
      isUnlocked: isUnlocked ?? this.isUnlocked,
    );
  }
}
