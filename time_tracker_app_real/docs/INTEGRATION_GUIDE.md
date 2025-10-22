# Agent Integration Guide

## Quick Start

### Step 1: Initialize Context Broker

```dart
// In main.dart
final broker = ContextBroker.instance;
```

### Step 2: Register Companion Agent

```dart
final companionAgent = CompanionAgent();
await broker.registerAgent(companionAgent);
```

### Step 3: Wire Timer Events

```dart
// In TimerManager.start()
broker.emit(AgentEvent(
  id: DateTime.now().toString(),
  type: EventType.userAction,
  source: 'timer',
  data: {'action': 'session_start'},
));
```

### Step 4: Add to Provider

```dart
MultiProvider(
  providers: [
    ChangeNotifierProvider(create: (_) => TimerManager()),
    ChangeNotifierProvider(create: (_) => companionAgent),
    Provider(create: (_) => broker),
  ],
)
```

## Minimal Working Example

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final broker = ContextBroker.instance;
  final agent = CompanionAgent();
  await broker.registerAgent(agent);
  
  runApp(MyApp());
}
```

## Testing Agent

```dart
test('Companion agent responds', () async {
  final agent = CompanionAgent();
  final context = ContextBroker.instance;
  
  await agent.initialize(context);
  
  final response = await agent.process(
    AgentRequest(id: '1', type: 'encourage', params: {}),
  );
  
  expect(response.success, true);
});
```
