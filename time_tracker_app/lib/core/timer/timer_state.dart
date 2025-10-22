enum TimerStatus { idle, running, paused, stopped }

class TimerState {
  final TimerStatus status;
  final Duration elapsed;
  final DateTime? startTime;
  final DateTime? pauseTime;

  TimerState({
    required this.status,
    required this.elapsed,
    this.startTime,
    this.pauseTime,
  });

  factory TimerState.initial() => TimerState(
        status: TimerStatus.idle,
        elapsed: Duration.zero,
      );

  TimerState copyWith({
    TimerStatus? status,
    Duration? elapsed,
    DateTime? startTime,
    DateTime? pauseTime,
  }) {
    return TimerState(
      status: status ?? this.status,
      elapsed: elapsed ?? this.elapsed,
      startTime: startTime ?? this.startTime,
      pauseTime: pauseTime ?? this.pauseTime,
    );
  }
}
