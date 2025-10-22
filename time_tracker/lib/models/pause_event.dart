/// A single pause/resume interval within a session.
class PauseEvent {
  final DateTime start;
  final DateTime? end;

  const PauseEvent({required this.start, this.end});

  Duration get duration => (end ?? DateTime.now()).difference(start);

  PauseEvent copyWith({DateTime? start, DateTime? end}) =>
      PauseEvent(start: start ?? this.start, end: end ?? this.end);

  Map<String, dynamic> toJson() => {
        'start': start.toIso8601String(),
        'end': end?.toIso8601String(),
      };

  factory PauseEvent.fromJson(Map<String, dynamic> json) => PauseEvent(
        start: DateTime.parse(json['start'] as String),
        end: json['end'] == null ? null : DateTime.parse(json['end'] as String),
      );
}
