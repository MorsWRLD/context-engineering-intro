import 'dart:async';
import 'package:flutter/foundation.dart';
import 'timer_state.dart';
import '../../models/session.dart';
import '../context_broker.dart';
import '../../agents/base_agent.dart';
import '../rewards/reward_engine.dart';

class TimerManager extends ChangeNotifier {
  TimerState _state = TimerState.initial();
  Timer? _timer;
  Session? _currentSession;
  TimerMode _mode = TimerMode.chill;
  Duration _todayChillTime = Duration.zero;
  Duration _todayGrindTime = Duration.zero;
  RewardEngine? _rewardEngine;

  TimerState get state => _state;
  Session? get currentSession => _currentSession;
  TimerMode get mode => _mode;
  Duration get todayChillTime => _todayChillTime + (_mode == TimerMode.chill ? _state.elapsed : Duration.zero);
  Duration get todayGrindTime => _todayGrindTime + (_mode == TimerMode.grind ? _state.elapsed : Duration.zero);

  void setRewardEngine(RewardEngine engine) {
    _rewardEngine = engine;
  }

  void setMode(TimerMode mode) {
    if (_state.status == TimerStatus.idle) {
      _mode = mode;
      notifyListeners();
    }
  }

  void start() {
    if (_state.status == TimerStatus.running) return;

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
    
    // Emit agent event
    ContextBroker.instance.emit(AgentEvent(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      type: EventType.userAction,
      source: 'timer',
      data: {'action': 'session_start', 'mode': _mode.name},
    ));
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

    // Update daily totals before reset
    if (_mode == TimerMode.chill) {
      _todayChillTime += _state.elapsed;
    } else {
      _todayGrindTime += _state.elapsed;
    }
    
    notifyListeners();
    
    // Emit session complete event
    ContextBroker.instance.emit(AgentEvent(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      type: EventType.userAction,
      source: 'timer',
      data: {'action': 'session_complete', 'duration': _state.elapsed.inSeconds},
    ));
    
    // Reset to idle for next session
    _state = TimerState.initial();
    _currentSession = null;
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
          
          // Update rewards live every second
          if (_rewardEngine != null && _state.elapsed.inSeconds % 1 == 0) {
            _rewardEngine!.updateLiveRewards(_currentSession!, _mode);
          }
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
