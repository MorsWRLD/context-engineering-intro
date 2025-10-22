import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/timer/timer_manager.dart';
import '../../core/rewards/reward_engine.dart';
import '../../core/achievements/achievement_tracker.dart';
import '../../models/user_stats.dart';
import '../../services/storage_service.dart';
import '../widgets/circular_timer.dart';
import '../widgets/mode_selector.dart';

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
          CircularTimer(
            elapsed: timerManager.state.elapsed,
            mode: timerManager.mode,
            isRunning: timerManager.state.status == TimerStatus.running,
          ),
          const SizedBox(height: 40),
          ModeSelector(
            selectedMode: timerManager.mode,
            onModeSelected: (mode) {
              timerManager.setMode(mode);
            },
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: timerManager.state.status == TimerStatus.running
                    ? timerManager.pause
                    : timerManager.resume,
                child: Text(timerManager.state.status == TimerStatus.running
                    ? 'Pause'
                    : 'Resume'),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: timerManager.start,
                child: const Text('Start'),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: timerManager.stop,
                child: const Text('Stop'),
              ),
            ],
          ),
          const SizedBox(height: 40),
          Text('XP: ${rewardEngine.stats.totalXp} | Credits: ${rewardEngine.stats.totalCredits}'),
        ],
      ),
    );
  }
}
