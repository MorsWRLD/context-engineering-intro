import 'dart:async';
import 'package:flutter/foundation.dart';

/// Event types for agent communication
enum EventType {
  userAction,
  agentResponse,
  systemUpdate,
  contextChange,
  error
}

/// Priority levels for events
enum Priority { low, medium, high, critical }

/// Base event class for agent communication
class AgentEvent {
  final String id;
  final EventType type;
  final String source;
  final DateTime timestamp;
  final dynamic data;
  final Priority priority;

  AgentEvent({
    required this.id,
    required this.type,
    required this.source,
    required this.data,
    Priority? priority,
  })  : timestamp = DateTime.now(),
        priority = priority ?? Priority.medium;

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type.toString(),
        'source': source,
        'timestamp': timestamp.toIso8601String(),
        'data': data,
        'priority': priority.toString(),
      };
}

/// Base request class for agent processing
class AgentRequest {
  final String id;
  final String type;
  final Map<String, dynamic> params;
  final String? correlationId;

  AgentRequest({
    required this.id,
    required this.type,
    required this.params,
    this.correlationId,
  });
}

/// Base response class from agents
class AgentResponse {
  final String id;
  final bool success;
  final dynamic data;
  final String? error;
  final String? correlationId;

  AgentResponse({
    required this.id,
    required this.success,
    this.data,
    this.error,
    this.correlationId,
  });
}

/// Context interface for agent access
abstract class AgentContext {
  Future<T?> get<T>(String path);
  Future<void> set(String path, dynamic value);
  Future<void> update(String path, dynamic value);
  Stream<AgentEvent> subscribe(String eventType);
  void emit(AgentEvent event);
}

/// Base class for all agents in the system
abstract class BaseAgent extends ChangeNotifier {
  /// Unique identifier for this agent instance
  String get id;

  /// Type of agent (companion, scheduler, os_agent, commerce)
  String get type;

  /// List of capabilities this agent provides
  List<String> get capabilities;

  /// Current state of the agent
  AgentState _state = AgentState.idle;
  AgentState get state => _state;

  /// Context reference for accessing shared data
  AgentContext? _context;
  AgentContext? get context => _context;

  /// Event subscriptions
  final List<StreamSubscription> _subscriptions = [];

  /// Initialize the agent with context
  Future<void> initialize(AgentContext context) async {
    _context = context;
    _state = AgentState.initializing;
    notifyListeners();

    try {
      await onInitialize();
      _state = AgentState.ready;
    } catch (e) {
      _state = AgentState.error;
      debugPrint('Agent $id initialization failed: $e');
    }
    notifyListeners();
  }

  /// Process a request
  Future<AgentResponse> process(AgentRequest request) async {
    if (_state != AgentState.ready) {
      return AgentResponse(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        success: false,
        error: 'Agent not ready',
        correlationId: request.correlationId,
      );
    }

    _state = AgentState.processing;
    notifyListeners();

    try {
      final response = await onProcess(request);
      _state = AgentState.ready;
      notifyListeners();
      return response;
    } catch (e) {
      _state = AgentState.ready;
      notifyListeners();
      return AgentResponse(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        success: false,
        error: e.toString(),
        correlationId: request.correlationId,
      );
    }
  }

  /// Handle an event
  void handleEvent(AgentEvent event) {
    if (_state == AgentState.ready) {
      onEvent(event);
    }
  }

  /// Subscribe to an event type
  void subscribeToEvent(String eventType) {
    if (_context != null) {
      final subscription = _context!.subscribe(eventType).listen(handleEvent);
      _subscriptions.add(subscription);
    }
  }

  /// Emit an event
  void emitEvent(AgentEvent event) {
    _context?.emit(event);
  }

  /// Shutdown the agent
  Future<void> shutdown() async {
    _state = AgentState.shuttingDown;
    notifyListeners();

    // Cancel all subscriptions
    for (var sub in _subscriptions) {
      await sub.cancel();
    }
    _subscriptions.clear();

    await onShutdown();
    _state = AgentState.shutdown;
    notifyListeners();
  }

  /// Query context data
  Future<T?> queryContext<T>(String path) async {
    return await _context?.get<T>(path);
  }

  /// Update context data
  Future<void> updateContext(String path, dynamic value) async {
    await _context?.update(path, value);
  }

  // Abstract methods to be implemented by concrete agents
  
  /// Called during initialization
  Future<void> onInitialize();

  /// Process a request
  Future<AgentResponse> onProcess(AgentRequest request);

  /// Handle an event
  void onEvent(AgentEvent event);

  /// Called during shutdown
  Future<void> onShutdown();

  @override
  void dispose() {
    shutdown();
    super.dispose();
  }
}

/// Agent states
enum AgentState {
  idle,
  initializing,
  ready,
  processing,
  shuttingDown,
  shutdown,
  error
}