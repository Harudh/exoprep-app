class StreakHeatmapModel {
  final String examId;
  final String examName;
  final int currentStreak;
  final int longestStreak;
  final DateTime lastAttemptDate;
  final DateTime streakStartDate;
  final int totalAttempts;
  final Map<String, CalendarDayData> calendar;

  StreakHeatmapModel({
    required this.examId,
    required this.examName,
    required this.currentStreak,
    required this.longestStreak,
    required this.lastAttemptDate,
    required this.streakStartDate,
    required this.totalAttempts,
    required this.calendar,
  });

  factory StreakHeatmapModel.fromJson(Map<String, dynamic> json) {
    final calendarData = json['calendar'] as Map<String, dynamic>;
    final Map<String, CalendarDayData> calendar = {};

    calendarData.forEach((key, value) {
      calendar[key] = CalendarDayData.fromJson(value);
    });

    return StreakHeatmapModel(
      examId: json['exam']['id'],
      examName: json['exam']['name'],
      currentStreak: json['current_streak'],
      longestStreak: json['longest_streak'],
      lastAttemptDate: DateTime.parse(json['last_attempt_date']),
      streakStartDate: DateTime.parse(json['streak_start_date']),
      totalAttempts: json['total_attempts'],
      calendar: calendar,
    );
  }
}

class CalendarDayData {
  final int attempts;
  final double avgScore;

  CalendarDayData({
    required this.attempts,
    required this.avgScore,
  });

  factory CalendarDayData.fromJson(Map<String, dynamic> json) {
    return CalendarDayData(
      attempts: json['attempts'],
      avgScore: (json['avg_score'] as num).toDouble(),
    );
  }
}
