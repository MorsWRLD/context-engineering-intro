import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/rewards/reward_engine.dart';
import '../../core/achievements/achievement_tracker.dart';
import '../theme/colors.dart';

class RewardsScreen extends StatelessWidget {
  const RewardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final rewardEngine = context.watch<RewardEngine>();
    final achievementTracker = context.watch<AchievementTracker>();
    final stats = rewardEngine.stats;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Rewards & Progress'),
        backgroundColor: CyberpunkColors.darkBackground,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Level Card
              _buildLevelCard(stats.level, stats.totalXp),
              
              const SizedBox(height: 20),
              
              // Stats Grid
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      'XP',
                      stats.totalXp.toString(),
                      CyberpunkColors.neonPink,
                      Icons.stars,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard(
                      'Credits',
                      stats.totalCredits.toString(),
                      CyberpunkColors.lightBlue,
                      Icons.monetization_on,
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 12),
              
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      'Streak',
                      '${stats.currentStreak} days',
                      CyberpunkColors.chillMode,
                      Icons.local_fire_department,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard(
                      'Sessions',
                      stats.totalSessions.toString(),
                      CyberpunkColors.grindMode,
                      Icons.timer,
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 20),
              
              // Time Tracked
              _buildTimeTrackedCard(stats.totalTimeTracked),
              
              const SizedBox(height: 20),
              
              // Achievements Section
              _buildSectionHeader('Achievements'),
              const SizedBox(height: 12),
              _buildAchievementsGrid(achievementTracker),
              
              const SizedBox(height: 20),
              
              // Streak Info
              _buildSectionHeader('Streak Multiplier'),
              const SizedBox(height: 12),
              _buildStreakMultiplierCard(stats),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLevelCard(int level, int totalXp) {
    // Use the stats object directly for consistent calculation
    return Consumer<RewardEngine>(
      builder: (context, rewardEngine, child) {
        final stats = rewardEngine.stats;
        final xpInLevel = stats.xpInCurrentLevel;
        final xpNeeded = stats.xpForNextLevel - stats.xpForCurrentLevel;
        final progress = stats.progressToNextLevel;

        return _buildLevelCardContent(level, xpInLevel, xpNeeded, progress);
      },
    );
  }

  Widget _buildLevelCardContent(int level, int xpInLevel, int xpNeeded, double progress) {

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            CyberpunkColors.neonPink.withOpacity(0.2),
            CyberpunkColors.lightBlue.withOpacity(0.2),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: CyberpunkColors.neonPink, width: 2),
        boxShadow: CyberpunkColors.neonGlow(CyberpunkColors.neonPink),
      ),
      child: Column(
        children: [
          Text(
            'LEVEL $level',
            style: const TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: CyberpunkColors.neonPink,
              letterSpacing: 4,
            ),
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 12,
              backgroundColor: CyberpunkColors.darkBackground.withOpacity(0.3),
              valueColor: AlwaysStoppedAnimation<Color>(CyberpunkColors.neonPink),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '$xpInLevel / $xpNeeded XP',
            style: TextStyle(
              fontSize: 14,
              color: CyberpunkColors.textSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${(progress * 100).toStringAsFixed(1)}% Complete',
            style: TextStyle(
              fontSize: 12,
              color: CyberpunkColors.neonPink.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.5), width: 1.5),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: CyberpunkColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeTrackedCard(Duration totalTime) {
    final hours = totalTime.inHours;
    final minutes = totalTime.inMinutes % 60;
    
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: CyberpunkColors.darkBackground.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: CyberpunkColors.grindMode.withOpacity(0.5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.access_time, color: CyberpunkColors.grindMode, size: 32),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Total Time Tracked',
                    style: TextStyle(
                      fontSize: 14,
                      color: CyberpunkColors.textSecondary,
                    ),
                  ),
                  Text(
                    '${hours}h ${minutes}m',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: CyberpunkColors.grindMode,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title.toUpperCase(),
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: CyberpunkColors.neonPink,
        letterSpacing: 2,
      ),
    );
  }

  Widget _buildAchievementsGrid(AchievementTracker tracker) {
    final achievements = tracker.achievements;
    
    if (achievements.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: CyberpunkColors.darkBackground.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Center(
          child: Text(
            'Complete sessions to unlock achievements!',
            style: TextStyle(
              color: CyberpunkColors.textSecondary,
              fontSize: 14,
            ),
          ),
        ),
      );
    }
    
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.85,
      ),
      itemCount: achievements.length > 6 ? 6 : achievements.length,
      itemBuilder: (context, index) {
        final achievement = achievements[index];
        return _buildAchievementCard(achievement.name, achievement.isUnlocked);
      },
    );
  }

  Widget _buildAchievementCard(String name, bool unlocked) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: unlocked 
            ? CyberpunkColors.neonPink.withOpacity(0.2)
            : CyberpunkColors.darkBackground.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: unlocked 
              ? CyberpunkColors.neonPink 
              : CyberpunkColors.textSecondary.withOpacity(0.3),
          width: unlocked ? 2 : 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            unlocked ? Icons.emoji_events : Icons.lock,
            color: unlocked ? CyberpunkColors.neonPink : CyberpunkColors.textSecondary,
            size: 32,
          ),
          const SizedBox(height: 8),
          Text(
            name,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 10,
              color: unlocked ? CyberpunkColors.textPrimary : CyberpunkColors.textSecondary,
              fontWeight: unlocked ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStreakMultiplierCard(stats) {
    final multiplier = stats.getStreakMultiplier();
    final nextMilestone = _getNextStreakMilestone(stats.currentStreak);
    
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            CyberpunkColors.chillMode.withOpacity(0.2),
            CyberpunkColors.lightBlue.withOpacity(0.2),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: CyberpunkColors.chillMode.withOpacity(0.5)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Current Multiplier',
                style: TextStyle(
                  fontSize: 16,
                  color: CyberpunkColors.textSecondary,
                ),
              ),
              Text(
                '${multiplier.toStringAsFixed(1)}x',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: CyberpunkColors.chillMode,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (nextMilestone > 0)
            Text(
              'Reach ${nextMilestone} days for next bonus!',
              style: const TextStyle(
                fontSize: 12,
                color: CyberpunkColors.textSecondary,
              ),
            ),
        ],
      ),
    );
  }


  int _getNextStreakMilestone(int currentStreak) {
    const milestones = [3, 7, 14, 30, 60, 100];
    for (final milestone in milestones) {
      if (currentStreak < milestone) return milestone;
    }
    return 0;
  }
}
