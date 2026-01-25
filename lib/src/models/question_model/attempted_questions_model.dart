class AttemptedPaper {
  final String id;
  final DateTime attemptedAt;
  final DateTime completedAt;
  final int timeTaken;
  final int totalQuestions;
  final int attemptedCount;
  final int correctCount;
  final int partiallyCorrectCount;
  final int incorrectCount;
  final int skippedCount;
  final double score;
  final double percentage;
  final Paper paper;
  final List<QuestionResponse> responses;
  final PaperInsights insights;

  AttemptedPaper({
    required this.id,
    required this.attemptedAt,
    required this.completedAt,
    required this.timeTaken,
    required this.totalQuestions,
    required this.attemptedCount,
    required this.correctCount,
    required this.partiallyCorrectCount,
    required this.incorrectCount,
    required this.skippedCount,
    required this.score,
    required this.percentage,
    required this.paper,
    required this.responses,
    required this.insights,
  });

  factory AttemptedPaper.fromJson(Map<String, dynamic> json) {
    return AttemptedPaper(
      id: json['id'],
      attemptedAt: DateTime.parse(json['attempted_at']),
      completedAt: DateTime.parse(json['completed_at']),
      timeTaken: json['time_taken'],
      totalQuestions: json['total_questions'],
      attemptedCount: json['attempted_count'],
      correctCount: json['correct_count'],
      partiallyCorrectCount: json['partially_correct_count'],
      incorrectCount: json['incorrect_count'],
      skippedCount: json['skipped_count'],
      score: json['score'].toDouble(),
      percentage: json['percentage'].toDouble(),
      paper: Paper.fromJson(json['paper']),
      responses: (json['responses'] as List).map((i) => QuestionResponse.fromJson(i)).toList(),
      insights: PaperInsights.fromJson(json['insights']),
    );
  }
}

class Paper {
  final String id;
  final String name;
  final String description;
  final int year;
  final String paperType;

  Paper({required this.id, required this.name, required this.description, required this.year, required this.paperType});

  factory Paper.fromJson(Map<String, dynamic> json) {
    return Paper(
      id: json['id'],
      name: json['name'],
      description: json['description'] ?? '',
      year: json['year'] ?? 0,
      paperType: json['paperType'] ?? '',
    );
  }
}

class QuestionResponse {
  final String id;
  final String questionId;
  final String? attemptedAnswer;
  final List<int> attemptedOptionIndexes;
  final String isCorrect;
  final int marksAwarded;
  final Question question;

  QuestionResponse({
    required this.id,
    required this.questionId,
    this.attemptedAnswer,
    required this.attemptedOptionIndexes,
    required this.isCorrect,
    required this.marksAwarded,
    required this.question,
  });

  factory QuestionResponse.fromJson(Map<String, dynamic> json) {
    return QuestionResponse(
      id: json['id'],
      questionId: json['question_id'],
      attemptedAnswer: json['attempted_answer'],
      attemptedOptionIndexes: List<int>.from(json['attempted_option_indexes']),
      isCorrect: json['is_correct'],
      marksAwarded: json['marks_awarded'],
      question: Question.fromJson(json['question']),
    );
  }
}

class Question {
  final String id;
  final String title;
  final List<dynamic> options;
  final String? answer;
  final String? image;
  final Topic topic;

  Question({required this.id, required this.title, required this.options, this.answer, this.image, required this.topic});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      title: json['title'],
      options: json['options'] ?? [],
      answer: json['answer'],
      image: json['image'],
      topic: Topic.fromJson(json['topic']),
    );
  }
}

class Topic {
  final String id;
  final String name;
  final String subjectName;

  Topic({required this.id, required this.name, required this.subjectName});

  factory Topic.fromJson(Map<String, dynamic> json) {
    return Topic(id: json['id'], name: json['name'], subjectName: json['subject']['name']);
  }
}

class PaperInsights {
  final double timePerQuestionAvg;
  final List<TopicAccuracy> accuracyByTopic;

  PaperInsights({required this.timePerQuestionAvg, required this.accuracyByTopic});

  factory PaperInsights.fromJson(Map<String, dynamic> json) {
    return PaperInsights(
      timePerQuestionAvg: json['time_per_question_avg'].toDouble(),
      accuracyByTopic: (json['accuracy_by_topic'] as List).map((i) => TopicAccuracy.fromJson(i)).toList(),
    );
  }
}

class TopicAccuracy {
  final String topicName;
  final int totalQuestions;
  final int attempted;
  final int correct;
  final double accuracy;

  TopicAccuracy({
    required this.topicName,
    required this.totalQuestions,
    required this.attempted,
    required this.correct,
    required this.accuracy,
  });

  factory TopicAccuracy.fromJson(Map<String, dynamic> json) {
    return TopicAccuracy(
      topicName: json['topic_name'],
      totalQuestions: json['total_questions'],
      attempted: json['attempted'],
      correct: json['correct'],
      accuracy: json['accuracy'].toDouble(),
    );
  }
}
