import '../base_agent.dart';

class CompanionAgent extends BaseAgent {
  @override
  String get id => 'companion_001';

  @override
  String get type => 'companion';

  @override
  List<String> get capabilities => [
        'emotional_support',
        'encouragement',
        'session_feedback'
      ];

  String _personality = 'rose';
  String get personality => _personality;

  void setPersonality(String personality) {
    _personality = personality;
    notifyListeners();
  }

  @override
  Future<void> onInitialize() async {
    // Subscribe to timer events
    subscribeToEvent('EventType.userAction');
    subscribeToEvent('EventType.contextChange');
  }

  @override
  Future<AgentResponse> onProcess(AgentRequest request) async {
    if (request.type == 'encourage') {
      return AgentResponse(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        success: true,
        data: _getEncouragement(),
      );
    }

    return AgentResponse(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      success: false,
      error: 'Unknown request type',
    );
  }

  @override
  void onEvent(AgentEvent event) {
    // React to events from timer system
  }

  @override
  Future<void> onShutdown() async {}

  String _getEncouragement() {
    return 'Keep going! You\'re doing great!';
  }
}
