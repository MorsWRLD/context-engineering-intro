import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../agents/base_agent.dart';

/// Central hub for agent communication and context management
class ContextBroker extends ChangeNotifier implements AgentContext {
  static ContextBroker? _instance;
  
  /// Singleton instance
  static ContextBroker get instance {
    _instance ??= ContextBroker._();
    return _instance!;
  }

  ContextBroker._();

  /// Registered agents
  final Map<String, BaseAgent> _agents = {};

  /// Context storage
  final Map<String, dynamic> _contextStore = {};

  /// Event bus
  final StreamController<AgentEvent> _eventBus = 
      StreamController<AgentEvent>.broadcast();

  /// Event subscriptions
  final Map<String, List<StreamController<AgentEvent>>> _subscriptions = {};

  /// Message queue for inter-agent communication
  final List<AgentMessage> _messageQueue = [];

  /// Register an agent with the broker
  Future<void> registerAgent(BaseAgent agent) async {
    if (_agents.containsKey(agent.id)) {
      throw Exception('Agent ${agent.id} already registered');
    }

    _agents[agent.id] = agent;
    
    // Initialize agent with context
    await agent.initialize(this);
    
    // Emit agent ready event
    emit(AgentEvent(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      type: EventType.systemUpdate,
      source: 'broker',
      data: {'agentId': agent.id, 'status': 'ready'},
    ));

    debugPrint('Agent ${agent.id} registered successfully');
    notifyListeners();
  }

  /// Unregister an agent
  Future<void> unregisterAgent(String agentId) async {
    final agent = _agents[agentId];
    if (agent != null) {
      await agent.shutdown();
      _agents.remove(agentId);
      
      emit(AgentEvent(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        type: EventType.systemUpdate,
        source: 'broker',
        data: {'agentId': agentId, 'status': 'shutdown'},
      ));
      
      debugPrint('Agent $agentId unregistered');
      notifyListeners();
    }
  }

  /// Get a registered agent
  BaseAgent? getAgent(String agentId) => _agents[agentId];

  /// Get all registered agents
  List<BaseAgent> get agents => _agents.values.toList();

  // Context Management Implementation

  @override
  Future<T?> get<T>(String path) async {
    final segments = path.split('.');
    dynamic current = _contextStore;

    for (var segment in segments) {
      if (current is Map && current.containsKey(segment)) {
        current = current[segment];
      } else {
        return null;
      }
    }

    return current as T?;
  }

  @override
  Future<void> set(String path, dynamic value) async {
    final segments = path.split('.');
    final lastSegment = segments.removeLast();
    
    Map<String, dynamic> current = _contextStore;
    
    for (var segment in segments) {
      if (!current.containsKey(segment)) {
        current[segment] = <String, dynamic>{};
      }
      current = current[segment] as Map<String, dynamic>;
    }
    
    current[lastSegment] = value;
    
    // Emit context change event
    emit(AgentEvent(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      type: EventType.contextChange,
      source: 'broker',
      data: {'path': path, 'value': value},
    ));
    
    notifyListeners();
  }

  @override
  Future<void> update(String path, dynamic value) async {
    await set(path, value);
  }

  @override
  Stream<AgentEvent> subscribe(String eventType) {
    if (!_subscriptions.containsKey(eventType)) {
      _subscriptions[eventType] = [];
    }
    
    final controller = StreamController<AgentEvent>();
    _subscriptions[eventType]!.add(controller);
    
    return controller.stream;
  }

  @override
  void emit(AgentEvent event) {
    // Send to main event bus
    _eventBus.add(event);
    
    // Send to specific subscribers
    final eventType = event.type.toString();
    if (_subscriptions.containsKey(eventType)) {
      for (var controller in _subscriptions[eventType]!) {
        if (!controller.isClosed) {
          controller.add(event);
        }
      }
    }
    
    // Send to wildcard subscribers
    if (_subscriptions.containsKey('*')) {
      for (var controller in _subscriptions['*']!) {
        if (!controller.isClosed) {
          controller.add(event);
        }
      }
    }
  }

  /// Send a message between agents
  Future<AgentResponse?> sendMessage(AgentMessage message) async {
    _messageQueue.add(message);
    
    if (message.to == 'broadcast') {
      // Broadcast to all agents
      for (var agent in _agents.values) {
        if (agent.id != message.from) {
          agent.handleEvent(AgentEvent(
            id: message.messageId,
            type: EventType.agentResponse,
            source: message.from,
            data: message.payload,
          ));
        }
      }
      return null;
    } else {
      // Send to specific agent
      final targetAgent = _agents[message.to];
      if (targetAgent != null) {
        return await targetAgent.process(AgentRequest(
          id: message.messageId,
          type: message.type,
          params: message.payload,
          correlationId: message.correlationId,
        ));
      }
    }
    
    return null;
  }

  /// Sync context across all agents
  Future<void> syncContext() async {
    final syncEvent = AgentEvent(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      type: EventType.contextChange,
      source: 'broker',
      data: {'action': 'sync', 'context': _contextStore},
      priority: Priority.high,
    );
    
    emit(syncEvent);
    debugPrint('Context synchronized across all agents');
  }

  /// Get context snapshot
  Map<String, dynamic> getContextSnapshot() {
    return Map<String, dynamic>.from(_contextStore);
  }

  /// Load context from JSON
  void loadContext(String jsonString) {
    try {
      final data = jsonDecode(jsonString) as Map<String, dynamic>;
      _contextStore.clear();
      _contextStore.addAll(data);
      syncContext();
      notifyListeners();
    } catch (e) {
      debugPrint('Failed to load context: $e');
    }
  }

  /// Save context to JSON
  String saveContext() {
    return jsonEncode(_contextStore);
  }

  /// Clear all context
  void clearContext() {
    _contextStore.clear();
    emit(AgentEvent(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      type: EventType.contextChange,
      source: 'broker',
      data: {'action': 'clear'},
    ));
    notifyListeners();
  }

  /// Get system status
  Map<String, dynamic> getSystemStatus() {
    return {
      'agents': _agents.map((id, agent) => MapEntry(id, {
        'type': agent.type,
        'state': agent.state.toString(),
        'capabilities': agent.capabilities,
      })),
      'contextSize': _contextStore.length,
      'messageQueueSize': _messageQueue.length,
      'activeSubscriptions': _subscriptions.length,
    };
  }

  /// Shutdown the broker
  Future<void> shutdown() async {
    // Shutdown all agents
    for (var agent in _agents.values) {
      await agent.shutdown();
    }
    
    // Clear resources
    _agents.clear();
    _contextStore.clear();
    _messageQueue.clear();
    
    // Close event streams
    await _eventBus.close();
    for (var controllers in _subscriptions.values) {
      for (var controller in controllers) {
        await controller.close();
      }
    }
    _subscriptions.clear();
    
    debugPrint('Context Broker shutdown complete');
  }

  @override
  void dispose() {
    shutdown();
    super.dispose();
  }
}

/// Message class for inter-agent communication
class AgentMessage {
  final String messageId;
  final String from;
  final String to;
  final String type;
  final Map<String, dynamic> payload;
  final DateTime timestamp;
  final String? correlationId;

  AgentMessage({
    required this.from,
    required this.to,
    required this.type,
    required this.payload,
    this.correlationId,
  })  : messageId = DateTime.now().millisecondsSinceEpoch.toString(),
        timestamp = DateTime.now();

  Map<String, dynamic> toJson() => {
        'messageId': messageId,
        'from': from,
        'to': to,
        'type': type,
        'payload': payload,
        'timestamp': timestamp.toIso8601String(),
        'correlationId': correlationId,
      };
}