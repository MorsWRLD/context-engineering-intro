import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/timer/timer_manager.dart';
import 'core/rewards/reward_engine.dart';
import 'core/achievements/achievement_tracker.dart';
import 'core/context_broker.dart';
import 'services/storage_service.dart';
import 'ui/theme/cyberpunk_theme.dart';
import 'ui/screens/timer_screen.dart';
import 'models/user_stats.dart';
import 'agents/companion/companion_agent.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load user stats
  final storage = StorageService();
  final stats = await storage.loadStats() ?? UserStats();
  
  // Initialize agent system
  final broker = ContextBroker.instance;
  final companionAgent = CompanionAgent();
  await broker.registerAgent(companionAgent);

  runApp(MyApp(stats: stats, companionAgent: companionAgent));
}

class MyApp extends StatefulWidget {
  final UserStats stats;
  final CompanionAgent companionAgent;

  const MyApp({Key? key, required this.stats, required this.companionAgent}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final TimerManager _timerManager;
  late final RewardEngine _rewardEngine;

  @override
  void initState() {
    super.initState();
    _timerManager = TimerManager();
    _rewardEngine = RewardEngine()..loadStats(widget.stats);
    _timerManager.setRewardEngine(_rewardEngine);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: _timerManager),
        ChangeNotifierProvider.value(value: _rewardEngine),
        ChangeNotifierProvider(create: (_) => AchievementTracker()..initialize()),
        ChangeNotifierProvider.value(value: widget.companionAgent),
        Provider(create: (_) => StorageService()),
        ChangeNotifierProvider.value(value: ContextBroker.instance),
      ],
      child: MaterialApp(
        title: 'Time Tracker Gamification',
        theme: CyberpunkTheme.darkTheme,
        home: const TimerScreen(),
      ),
    );
  }
}
