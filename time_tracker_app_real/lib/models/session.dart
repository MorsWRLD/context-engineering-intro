import 'package:flutter/foundation.dart';

enum TimerMode { chill, grind }

class PauseEvent {
  final DateTime startTime;
  final DateTime? endTime;

  PauseEvent({required this.startTime, this.endTime});

  Duration get duration {
    if (endTime == null) return Duration.zero;
    return endTime!.difference(startTime);
  }

  Map<String, dynamic> toJson() => {
        'startTime': startTime.toIso8601String(),
        'endTime': endTime?.toIso8601String(),
      };

  factory PauseEvent.fromJson(Map<String, dynamic> json) => PauseEvent(
        startTime: DateTime.parse(json['startTime']),
        endTime: json['endTime'] != null ? DateTime.parse(json['endTime']) : null,
      );
}

class Session {
  final String id;
  final DateTime startTime;
  DateTime? endTime;
  Duration duration;
  final TimerMode mode;
  int xpEarned;
  int creditsEarned;
  List<PauseEvent> pauses;

  Session({
    required this.id,
    required this.startTime,
    this.endTime,
    required this.duration,
    required this.mode,
    this.xpEarned = 0,
    this.creditsEarned = 0,
    List<PauseEvent>? pauses,
  }) : pauses = pauses ?? [];

  Duration get totalPauseDuration {
    return pauses.fold(
      Duration.zero,
      (sum, pause) => sum + pause.duration,
    );
  }

  Duration get activeDuration => duration - totalPauseDuration;

  Map<String, dynamic> toJson() => {
        'id': id,
        'startTime': startTime.toIso8601String(),
        'endTime': endTime?.toIso8601String(),
        'duration': duration.inSeconds,
        'mode': mode.name,
        'xpEarned': xpEarned,
        'creditsEarned': creditsEarned,
        'pauses': pauses.map((p) => p.toJson()).toList(),
      };

  factory Session.fromJson(Map<String, dynamic> json) => Session(
        id: json['id'],
        startTime: DateTime.parse(json['startTime']),
        endTime: json['endTime'] != null ? DateTime.parse(json['endTime']) : null,
        duration: Duration(seconds: json['duration']),
        mode: TimerMode.values.firstWhere((m) => m.name == json['mode']),
        xpEarned: json['xpEarned'] ?? 0,
        creditsEarned: json['creditsEarned'] ?? 0,
        pauses: (json['pauses'] as List?)
                ?.map((p) => PauseEvent.fromJson(p))
                .toList() ??
            [],
      );
}
