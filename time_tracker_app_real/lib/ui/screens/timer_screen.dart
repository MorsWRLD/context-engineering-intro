import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/timer/timer_manager.dart';
import '../../core/timer/timer_state.dart';
import '../../core/rewards/reward_engine.dart';
import '../../models/session.dart';
import '../../core/achievements/achievement_tracker.dart';
import '../../models/user_stats.dart';
import '../../services/storage_service.dart';
import '../widgets/watch_timer.dart';
import '../widgets/agent_message.dart';
import 'rewards_screen.dart';

class TimerScreen extends StatelessWidget {
  const TimerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final timerManager = context.watch<TimerManager>();
    final rewardEngine = context.watch<RewardEngine>();
    final achievementTracker = context.watch<AchievementTracker>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Timer'),
        actions: [
          IconButton(
            icon: const Icon(Icons.emoji_events),
            tooltip: 'Rewards',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RewardsScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to settings or use another function
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Column(
            children: [
              // Mode indicator
              if (timerManager.state.status == TimerStatus.idle)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    'Tap to switch: ${timerManager.mode == TimerMode.chill ? "CHILL" : "GRIND"} Mode',
                    style: TextStyle(
                      fontSize: 16,
                      color: timerManager.mode == TimerMode.chill
                          ? const Color(0xFFFF6EC7)
                          : const Color(0xFF00F0FF),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              GestureDetector(
                onTap: () {
                  if (timerManager.state.status == TimerStatus.idle) {
                    // Tap to toggle mode when idle
                    timerManager.setMode(
                      timerManager.mode == TimerMode.chill 
                        ? TimerMode.grind 
                        : TimerMode.chill
                    );
                  } else {
                    // Tap to pause/resume when running
                    if (timerManager.state.status == TimerStatus.running) {
                      timerManager.pause();
                    } else if (timerManager.state.status == TimerStatus.paused) {
                      timerManager.resume();
                    }
                  }
                },
                child: WatchTimer(
                  chillTime: timerManager.todayChillTime,
                  grindTime: timerManager.todayGrindTime,
                  currentMode: timerManager.mode,
                  timerStatus: timerManager.state.status,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: timerManager.state.status == TimerStatus.running
                    ? timerManager.pause
                    : (timerManager.state.status == TimerStatus.paused
                        ? timerManager.resume
                        : null),
                child: Text(timerManager.state.status == TimerStatus.running
                    ? 'Pause'
                    : 'Resume'),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: timerManager.state.status == TimerStatus.idle
                    ? timerManager.start
                    : null,
                child: const Text('Start'),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: (timerManager.state.status == TimerStatus.running ||
                        timerManager.state.status == TimerStatus.paused)
                    ? () {
                        if (timerManager.currentSession != null) {
                          final session = timerManager.currentSession!;
                          timerManager.stop();
                          rewardEngine.processSession(session);
                        }
                      }
                    : null,
                child: const Text('Stop'),
              ),
            ],
          ),
          const SizedBox(height: 40),
          // Live stats display
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            margin: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF00F0FF).withOpacity(0.15),
                  const Color(0xFFFF6EC7).withOpacity(0.15),
                ],
              ),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xFF00F0FF).withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        const Icon(Icons.stars, color: Color(0xFF00F0FF), size: 20),
                        const SizedBox(height: 4),
                        Text(
                          '${rewardEngine.stats.totalXp}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF00F0FF),
                          ),
                        ),
                        const Text(
                          'XP',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF8B9DC3),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 1,
                      height: 40,
                      color: const Color(0xFF8B9DC3).withOpacity(0.3),
                    ),
                    Column(
                      children: [
                        const Icon(Icons.monetization_on, color: Color(0xFFFF6EC7), size: 20),
                        const SizedBox(height: 4),
                        Text(
                          '${rewardEngine.stats.totalCredits}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFFF6EC7),
                          ),
                        ),
                        const Text(
                          'Credits',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF8B9DC3),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 1,
                      height: 40,
                      color: const Color(0xFF8B9DC3).withOpacity(0.3),
                    ),
                    Column(
                      children: [
                        const Icon(Icons.trending_up, color: Color(0xFF00F0FF), size: 20),
                        const SizedBox(height: 4),
                        Text(
                          'Lv ${rewardEngine.stats.level}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF00F0FF),
                          ),
                        ),
                        const Text(
                          'Level',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF8B9DC3),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // XP Progress Bar
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Level ${rewardEngine.stats.level} Progress',
                          style: const TextStyle(
                            fontSize: 11,
                            color: Color(0xFF8B9DC3),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '${rewardEngine.stats.xpInCurrentLevel} / ${rewardEngine.stats.xpForNextLevel - rewardEngine.stats.xpForCurrentLevel} XP',
                          style: const TextStyle(
                            fontSize: 11,
                            color: Color(0xFF8B9DC3),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        height: 8,
                        decoration: BoxDecoration(
                          color: const Color(0xFF1A1A1A),
                          border: Border.all(
                            color: const Color(0xFF00F0FF).withOpacity(0.3),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: rewardEngine.stats.progressToNextLevel,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xFF00F0FF),
                                  Color(0xFF00A8CC),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF00F0FF).withOpacity(0.5),
                                  blurRadius: 8,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Credit Progress Bar (next credit in 300 seconds)
                Builder(
                  builder: (context) {
                    final sessionDuration = timerManager.currentSession?.duration.inSeconds ?? 0;
                    final secondsToNextCredit = 300 - (sessionDuration % 300);
                    final creditProgress = (sessionDuration % 300) / 300.0;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Next Credit',
                              style: TextStyle(
                                fontSize: 11,
                                color: Color(0xFF8B9DC3),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '${secondsToNextCredit}s',
                              style: const TextStyle(
                                fontSize: 11,
                                color: Color(0xFF8B9DC3),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            height: 8,
                            decoration: BoxDecoration(
                              color: const Color(0xFF1A1A1A),
                              border: Border.all(
                                color: const Color(0xFFFF6EC7).withOpacity(0.3),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: creditProgress,
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFFFF6EC7),
                                      Color(0xFFCC0058),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFFFF6EC7).withOpacity(0.5),
                                      blurRadius: 8,
                                      spreadRadius: 1,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: AgentMessage(),
          ),
        ],
      ),
    );
  }
}
