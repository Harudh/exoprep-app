class AttemptedPaper {
  final String id;
  final DateTime attemptedAt;
  final DateTime completedAt;
  final int timeTaken;
  final int score;
  final double percentage;
  final int correctCount;
  final int partiallyCorrectCount;
  final int incorrectCount;
  final int skippedCount;
  final int attemptedCount;
  final PaperInAttempted paper;

  AttemptedPaper({
    required this.id,
    required this.attemptedAt,
    required this.completedAt,
    required this.timeTaken,
    required this.score,
    required this.percentage,
    required this.correctCount,
    required this.partiallyCorrectCount,
    required this.incorrectCount,
    required this.skippedCount,
    required this.attemptedCount,
    required this.paper,
  });

  factory AttemptedPaper.fromJson(Map<String, dynamic> json) {
    return AttemptedPaper(
      id: json['id'] as String,
      attemptedAt: DateTime.parse(json['attempted_at'] as String),
      completedAt: DateTime.parse(json['completed_at'] as String),
      timeTaken: json['time_taken'] as int,
      score: json['score'] as int,
      percentage: (json['percentage'] as num).toDouble(),
      correctCount: json['correct_count'] as int,
      partiallyCorrectCount: json['partially_correct_count'] as int,
      incorrectCount: json['incorrect_count'] as int,
      skippedCount: json['skipped_count'] as int,
      attemptedCount: json['attempted_count'] as int,
      paper: PaperInAttempted.fromJson(json['paper'] as Map<String, dynamic>),
    );
  }

  @override
  String toString() {
    return 'AttemptedPaper(id: $id, score: $score, paper: ${paper.name})';
  }
}

class PaperInAttempted {
  final String id;
  final String name;
  final int year;
  final String paperType;

  PaperInAttempted({required this.id, required this.name, required this.year, required this.paperType});

  factory PaperInAttempted.fromJson(Map<String, dynamic> json) {
    return PaperInAttempted(
      id: json['id'] as String,
      name: json['name'] as String,
      year: json['year'] as int,
      paperType: json['paper_type'] as String,
    );
  }

  @override
  String toString() {
    return 'PaperInAttempted(id: $id, name: $name, year: $year)';
  }
}
