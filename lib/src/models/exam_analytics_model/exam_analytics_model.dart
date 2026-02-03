class ExamAnalyticsModel {
  final String examId;
  final String examName;
  final num totalPapersAttempted;
  final num totalAttempts;
  final num totalQuestionsAttempted;
  final num overallAccuracy;
  final num avgScorePercentage;
  final num totalTimeSpent;

  final List<SubjectPerformance> subjectPerformance;
  final List<String> strengths;
  final List<String> weaknesses;
  final List<MonthlyProgress> monthlyProgress;

  const ExamAnalyticsModel({
    this.examId = '',
    this.examName = '',
    this.totalPapersAttempted = 0,
    this.totalAttempts = 0,
    this.totalQuestionsAttempted = 0,
    this.overallAccuracy = 0,
    this.avgScorePercentage = 0,
    this.totalTimeSpent = 0,
    this.subjectPerformance = const [],
    this.strengths = const [],
    this.weaknesses = const [],
    this.monthlyProgress = const [],
  });

  factory ExamAnalyticsModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const ExamAnalyticsModel();

    return ExamAnalyticsModel(
      examId: json['exam_id'] ?? '',
      examName: json['exam_name'] ?? '',
      totalPapersAttempted: json['total_papers_attempted'] ?? 0,
      totalAttempts: json['total_attempts'] ?? 0,
      totalQuestionsAttempted: json['total_questions_attempted'] ?? 0,
      overallAccuracy: json['overall_accuracy'] ?? 0,
      avgScorePercentage: json['avg_score_percentage'] ?? 0,
      totalTimeSpent: json['total_time_spent'] ?? 0,

      subjectPerformance: (json['subject_performance'] as List?)?.map((e) => SubjectPerformance.fromJson(e)).toList() ?? const [],

      strengths: (json['strengths'] as List?)?.map((e) => e.toString()).toList() ?? const [],

      weaknesses: (json['weaknesses'] as List?)?.map((e) => e.toString()).toList() ?? const [],

      monthlyProgress: (json['monthly_progress'] as List?)?.map((e) => MonthlyProgress.fromJson(e)).toList() ?? const [],
    );
  }
}

class SubjectPerformance {
  final String subjectId;
  final String subjectName;
  final num totalQuestionsAttempted;
  final num correctAnswers;
  final num partiallyCorrectAnswers;
  final num incorrectAnswers;
  final num accuracy;

  const SubjectPerformance({
    this.subjectId = '',
    this.subjectName = '',
    this.totalQuestionsAttempted = 0,
    this.correctAnswers = 0,
    this.partiallyCorrectAnswers = 0,
    this.incorrectAnswers = 0,
    this.accuracy = 0,
  });

  factory SubjectPerformance.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const SubjectPerformance();

    return SubjectPerformance(
      subjectId: json['subject_id'] ?? '',
      subjectName: json['subject_name'] ?? '',
      totalQuestionsAttempted: json['total_questions_attempted'] ?? 0,
      correctAnswers: json['correct_answers'] ?? 0,
      partiallyCorrectAnswers: json['partially_correct_answers'] ?? 0,
      incorrectAnswers: json['incorrect_answers'] ?? 0,
      accuracy: json['accuracy'] ?? 0,
    );
  }
}

class MonthlyProgress {
  final String month;
  final num attempts;
  final num avgPercentage;

  const MonthlyProgress({this.month = '', this.attempts = 0, this.avgPercentage = 0});

  factory MonthlyProgress.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const MonthlyProgress();

    return MonthlyProgress(
      month: json['month'] ?? '',
      attempts: json['attempts'] ?? 0,
      avgPercentage: json['avg_percentage'] ?? 0,
    );
  }
}
