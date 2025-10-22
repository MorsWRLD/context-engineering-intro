import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/session.dart';
import '../models/achievement.dart';
import '../models/user_stats.dart';

class StorageService {
  static const String _statsKey = 'user_stats';
  static const String _sessionsKey = 'sessions';
  static const String _achievementsKey = 'achievements';

  // Save user stats
  Future<void> saveStats(UserStats stats) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_statsKey, jsonEncode(stats.toJson()));
  }

  // Load user stats
  Future<UserStats?> loadStats() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_statsKey);
    if (data == null) return null;
    return UserStats.fromJson(jsonDecode(data));
  }

  // Save sessions
  Future<void> saveSessions(List<Session> sessions) async {
    final prefs = await SharedPreferences.getInstance();
    final data = sessions.map((s) => s.toJson()).toList();
    await prefs.setString(_sessionsKey, jsonEncode(data));
  }

  // Load sessions
  Future<List<Session>> loadSessions() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_sessionsKey);
    if (data == null) return [];
    final List<dynamic> decoded = jsonDecode(data);
    return decoded.map((s) => Session.fromJson(s)).toList();
  }

  // Add a single session
  Future<void> addSession(Session session) async {
    final sessions = await loadSessions();
    sessions.add(session);
    await saveSessions(sessions);
  }

  // Save achievements
  Future<void> saveAchievements(List<Achievement> achievements) async {
    final prefs = await SharedPreferences.getInstance();
    final data = achievements.map((a) => a.toJson()).toList();
    await prefs.setString(_achievementsKey, jsonEncode(data));
  }

  // Load achievements
  Future<List<Achievement>?> loadAchievements() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_achievementsKey);
    if (data == null) return null;
    final List<dynamic> decoded = jsonDecode(data);
    return decoded.map((a) => Achievement.fromJson(a)).toList();
  }

  // Clear all data
  Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
