import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/achievements/achievement_tracker.dart';
import '../../models/achievement.dart';

class AchievementsScreen extends StatelessWidget {
  const AchievementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final achievementTracker = context.watch<AchievementTracker>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Achievements'),
      ),
      body: ListView.builder(
        itemCount: achievementTracker.achievements.length,
        itemBuilder: (context, index) {
          final achievement = achievementTracker.achievements[index];
          return ListTile(
            title: Text(achievement.name),
            subtitle: Text(achievement.description),
            trailing: achievement.isUnlocked
                ? const Icon(Icons.check_circle, color: Colors.green)
                : const Icon(Icons.lock, color: Colors.grey),
          );
        },
      ),
    );
  }
}
