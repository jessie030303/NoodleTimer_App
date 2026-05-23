class TimerHistory {
  final String noodleType;
  final int durationInSeconds;
  final DateTime completedAt;
  final String preference;
  TimerHistory({
    required this.noodleType,
    required this.durationInSeconds,
    required this.completedAt,
    required this.preference,
  });
  Map<String, dynamic>toJson() {
    return {
      'noodleType': noodleType,
      'durationInSeconds': durationInSeconds,
      'completedAt': completedAt.toIso8601String(),
      'preference': preference,
    };
  }
  factory TimerHistory.fromJson(Map<String, dynamic> json) {
    return TimerHistory(
      noodleType: json['noodleType'],
      durationInSeconds:
        json['durationInSeconds'],
      completedAt: DateTime.parse(json['completedAt']),
      preference: json['preference'],
    );
  }
}
