class Exam {
  final String id;
  final String name;
  final String? parentId;
  final bool? isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final ExamAnalytics? analytics;
  final List<Exam> children;

  Exam({
    required this.id,
    required this.name,
    this.parentId,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.analytics,
    required this.children,
  });

  factory Exam.fromJson(Map<String, dynamic> json) {
    final childrenJson = json['children'] as List?;

    return Exam(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      children: childrenJson == null ? [] : childrenJson.map((child) => Exam.fromJson(child as Map<String, dynamic>)).toList(),
      parentId: json['parent_id']?.toString(),
      isActive: json['is_active'] as bool?,
      createdAt: json['created_at'] == null ? null : DateTime.tryParse(json['created_at']),
      updatedAt: json['updated_at'] == null ? null : DateTime.tryParse(json['updated_at']),
      analytics: ExamAnalytics.fromJson(json['analytics'] as Map<String, dynamic>?),
    );
  }

  @override
  String toString() {
    return 'Exam(id: $id, name: $name, children: ${children.map((e) => e.toString()).toList()})';
  }
}

class ExamAnalytics {
  final int? currentStreak;
  final int? longestStreak;
  final int? totalPoints;
  final int? totalAttempts;
  final double? avgScore;
  final int? totalPapersInExam;
  final int? papersAttemptedByUser;
  final double? overallAccuracy;
  final DateTime? lastAttemptDate;

  ExamAnalytics({
    this.currentStreak,
    this.longestStreak,
    this.totalPoints,
    this.totalAttempts,
    this.avgScore,
    this.totalPapersInExam,
    this.papersAttemptedByUser,
    this.overallAccuracy,
    this.lastAttemptDate,
  });

  factory ExamAnalytics.fromJson(Map<String, dynamic>? json) {
    if (json == null) return ExamAnalytics();

    return ExamAnalytics(
      // Cast as num? first, then convert to int
      currentStreak: (json['current_streak'] as num?)?.toInt(),
      longestStreak: (json['longest_streak'] as num?)?.toInt(),
      totalPoints: (json['total_points'] as num?)?.toInt(),
      totalAttempts: (json['total_attempts'] as num?)?.toInt(),
      totalPapersInExam: (json['total_papers_in_exam'] as num?)?.toInt(),
      papersAttemptedByUser: (json['papers_attempted_by_user'] as num?)?.toInt(),

      // Cast as num? first, then convert to double
      avgScore: (json['avg_score'] as num?)?.toDouble(),
      overallAccuracy: (json['overall_accuracy'] as num?)?.toDouble(),

      lastAttemptDate: json['last_attempt_date'] == null ? null : DateTime.tryParse(json['last_attempt_date']),
    );
  }
}
