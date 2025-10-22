# Companion Agent

Provides emotional support and encouragement during work sessions.

## Features
- Multiple personalities (Rose, Xeni, WatchFACE)
- Session start/complete messages
- Real-time encouragement
- Context-aware responses

## Usage

```dart
final agent = CompanionAgent();
await broker.registerAgent(agent);

// Change personality
agent.setPersonality('xeni');

// Request encouragement
final response = await agent.process(
  AgentRequest(
    id: '1',
    type: 'encourage',
    params: {},
  ),
);
```

## Personalities

- **Rose**: Warm, supportive, encouraging
- **Xeni**: Energetic, intense, motivating  
- **WatchFACE**: Analytical, precise, data-focused

## Events

Listens to:
- `session.start`
- `session.complete`
- `achievement.unlock`
- `mood.change`
