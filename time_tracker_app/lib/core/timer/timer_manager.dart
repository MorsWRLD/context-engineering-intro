import 'dart:async';
import 'package:flutter/foundation.dart';
import 'timer_state.dart';
import '../../models/session.dart';

class TimerManager extends ChangeNotifier {
  TimerState _state = TimerState.initial();
  Timer? _timer;
  Session? _currentSession;
  TimerMode _mode = TimerMode.chill;

  TimerState get state => _state;
  Session? get currentSession => _currentSession;
  TimerMode get mode => _mode;

  void setMode(TimerMode mode) {
    if (_state.status == TimerStatus.idle) {
      _mode = mode;
      notifyListeners();
    }
  }

  void start() {
    if (_state.status != TimerStatus.idle) return;

    final now = DateTime.now();
    _currentSession = Session(
      id: now.millisecondsSinceEpoch.toString(),
      startTime: now,
      duration: Duration.zero,
      mode: _mode,
    );

    _state = _state.copyWith(
      status: TimerStatus.running,
      startTime: now,
      elapsed: Duration.zero,
    );

    _startTicking();
    notifyListeners();
  }

  void pause() {
    if (_state.status != TimerStatus.running) return;

    _timer?.cancel();
    final now = DateTime.now();
    
    if (_currentSession != null) {
      _currentSession!.pauses.add(PauseEvent(startTime: now));
    }

    _state = _state.copyWith(
      status: TimerStatus.paused,
      pauseTime: now,
    );

    notifyListeners();
  }

  void resume() {
    if (_state.status != TimerStatus.paused) return;

    final now = DateTime.now();
    
    if (_currentSession != null && _currentSession!.pauses.isNotEmpty) {
      final lastPause = _currentSession!.pauses.last;
      if (lastPause.endTime == null) {
        _currentSession!.pauses[_currentSession!.pauses.length - 1] =
            PauseEvent(startTime: lastPause.startTime, endTime: now);
      }
    }

    _state = _state.copyWith(
      status: TimerStatus.running,
      pauseTime: null,
    );

    _startTicking();
    notifyListeners();
  }

  void stop() {
    if (_state.status == TimerStatus.idle) return;

    _timer?.cancel();
    final now = DateTime.now();

    if (_currentSession != null) {
      _currentSession!.endTime = now;
      _currentSession!.duration = _state.elapsed;
      
      // Close any open pause event
      if (_currentSession!.pauses.isNotEmpty) {
        final lastPause = _currentSession!.pauses.last;
        if (lastPause.endTime == null) {
          _currentSession!.pauses[_currentSession!.pauses.length - 1] =
              PauseEvent(startTime: lastPause.startTime, endTime: now);
        }
      }
    }

    _state = _state.copyWith(
      status: TimerStatus.stopped,
    );

    notifyListeners();
  }

  void reset() {
    _timer?.cancel();
    _state = TimerState.initial();
    _currentSession = null;
    _mode = TimerMode.chill;
    notifyListeners();
  }

  void _startTicking() {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (_state.status == TimerStatus.running) {
        final newElapsed = DateTime.now().difference(_state.startTime!);
        
        // Subtract pause durations
        Duration totalPauseDuration = Duration.zero;
        if (_currentSession != null) {
          totalPauseDuration = _currentSession!.totalPauseDuration;
        }
        
        _state = _state.copyWith(
          elapsed: newElapsed - totalPauseDuration,
        );
        
        if (_currentSession != null) {
          _currentSession!.duration = _state.elapsed;
        }
        
        notifyListeners();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
