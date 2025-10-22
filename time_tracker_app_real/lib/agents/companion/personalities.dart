class Personality {
  final String id;
  final String name;
  final String description;
  final Map<String, List<String>> responses;

  const Personality({
    required this.id,
    required this.name,
    required this.description,
    required this.responses,
  });
}

class Personalities {
  static const rose = Personality(
    id: 'rose',
    name: 'Rose',
    description: 'Supportive and warm companion',
    responses: {
      'session_start': ['Let\'s make this session count!', 'Ready when you are!'],
      'session_complete': ['Great work!', 'You did amazing!'],
      'encouragement': ['Keep going!', 'You\'ve got this!'],
    },
  );

  static const xeni = Personality(
    id: 'xeni',
    name: 'Xeni',
    description: 'Energetic and motivating',
    responses: {
      'session_start': ['Let\'s crush it!', 'Time to dominate!'],
      'session_complete': ['Legendary!', 'Absolutely destroyed it!'],
      'encouragement': ['Push harder!', 'No limits!'],
    },
  );

  static const watchface = Personality(
    id: 'watchface',
    name: 'WatchFACE',
    description: 'Analytical and precise',
    responses: {
      'session_start': ['Initiating focus mode', 'Timer synchronized'],
      'session_complete': ['Session logged', 'Data recorded'],
      'encouragement': ['Maintain pace', 'Optimize output'],
    },
  );

  static List<Personality> get all => [rose, xeni, watchface];
}
