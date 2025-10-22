/// Reward payload representing earned XP and Credits.
class Reward {
  final int xp;
  final int credits;

  const Reward({this.xp = 0, this.credits = 0});

  Reward copyWith({int? xp, int? credits}) =>
      Reward(xp: xp ?? this.xp, credits: credits ?? this.credits);

  Reward operator +(Reward other) =>
      Reward(xp: xp + other.xp, credits: credits + other.credits);

  Reward scaled(double multiplier) => Reward(
        xp: (xp * multiplier).round(),
        credits: (credits * multiplier).round(),
      );

  Map<String, dynamic> toJson() => {
        'xp': xp,
        'credits': credits,
      };

  factory Reward.fromJson(Map<String, dynamic> json) => Reward(
        xp: (json['xp'] ?? 0) as int,
        credits: (json['credits'] ?? 0) as int,
      );

  @override
  String toString() => 'Reward(xp: $xp, credits: $credits)';
}
