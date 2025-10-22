import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/timer/timer_manager.dart';
import 'core/rewards/reward_engine.dart';
import 'core/achievements/achievement_tracker.dart';
import 'services/storage_service.dart';
import 'ui/theme/cyberpunk_theme.dart';
import 'ui/screens/timer_screen.dart';
import 'models/user_stats.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load user stats
  final storage = StorageService();
  final stats = await storage.loadStats() ?? UserStats();

  runApp(MyApp(stats: stats));
}

class MyApp extends StatelessWidget {
  final UserStats stats;

  const MyApp({Key? key, required this.stats}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TimerManager()),
        ChangeNotifierProvider(create: (_) => RewardEngine()..loadStats(stats)),
        ChangeNotifierProvider(create: (_) => AchievementTracker()..initialize()),
        Provider(create: (_) => StorageService()),
      ],
      child: MaterialApp(
        title: 'Time Tracker Gamification',
        theme: CyberpunkTheme.darkTheme,
        home: const TimerScreen(),
      ),
    );
  }
}