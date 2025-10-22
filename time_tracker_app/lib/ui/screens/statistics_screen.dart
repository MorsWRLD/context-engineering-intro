import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/user_stats.dart';
import '../../core/rewards/reward_engine.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userStats = context.watch<RewardEngine>().stats;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistics'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Total XP: ${userStats.totalXp}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Total Credits: ${userStats.totalCredits}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Level: ${userStats.level}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Current Streak: ${userStats.currentStreak}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Longest Streak: ${userStats.longestStreak}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Total Time Tracked: ${userStats.totalTimeTracked.inHours} hours', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Total Sessions: ${userStats.totalSessions}', style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
