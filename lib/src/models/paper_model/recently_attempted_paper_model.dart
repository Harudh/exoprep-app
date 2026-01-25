class RecentlyAttemptedPaper {
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
  final PaperModel paper;
  final List<QuestionResponse> responses;
  final PaperInsights insights;

  RecentlyAttemptedPaper({
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

  factory RecentlyAttemptedPaper.fromJson(Map<String, dynamic> json) {
    return RecentlyAttemptedPaper(
      id: json['id'] ?? '',
      attemptedAt: DateTime.parse(json['attempted_at'] ?? DateTime.now().toIso8601String()),
      completedAt: DateTime.parse(json['completed_at'] ?? DateTime.now().toIso8601String()),
      timeTaken: json['time_taken'] ?? 0,
      totalQuestions: json['total_questions'] ?? 0,
      attemptedCount: json['attempted_count'] ?? 0,
      correctCount: json['correct_count'] ?? 0,
      partiallyCorrectCount: json['partially_correct_count'] ?? 0,
      incorrectCount: json['incorrect_count'] ?? 0,
      skippedCount: json['skipped_count'] ?? 0,
      score: (json['score'] ?? 0).toDouble(),
      percentage: (json['percentage'] ?? 0).toDouble(),
      paper: PaperModel.fromJson(json['paper'] ?? {}),
      responses: json['responses'] != null
          ? (json['responses'] as List).map((i) => QuestionResponse.fromJson(i as Map<String, dynamic>)).toList()
          : [],
      insights: PaperInsights.fromJson(json['insights'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'attempted_at': attemptedAt.toIso8601String(),
      'completed_at': completedAt.toIso8601String(),
      'time_taken': timeTaken,
      'total_questions': totalQuestions,
      'attempted_count': attemptedCount,
      'correct_count': correctCount,
      'partially_correct_count': partiallyCorrectCount,
      'incorrect_count': incorrectCount,
      'skipped_count': skippedCount,
      'score': score,
      'percentage': percentage,
      'paper': paper.toJson(),
      'responses': responses.map((r) => r.toJson()).toList(),
      'insights': insights.toJson(),
    };
  }
}

class PaperModel {
  final String id;
  final String name;
  final String description;
  final int year;
  final String paperType;
  final int? duration;
  final int? totalQuestions;
  final int? positiveMarks;
  final int? negativeMarks;
  final ExamModel? exam;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  PaperModel({
    required this.id,
    required this.name,
    required this.description,
    required this.year,
    required this.paperType,
    this.duration,
    this.totalQuestions,
    this.positiveMarks,
    this.negativeMarks,
    this.exam,
    this.createdAt,
    this.updatedAt,
  });

  factory PaperModel.fromJson(Map<String, dynamic> json) {
    return PaperModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      year: json['year'] ?? 0,
      paperType: json['paperType'] ?? '',
      description: json['description'] ?? '',
      duration: json['duration'],
      totalQuestions: json['totalQuestions'],
      positiveMarks: json['positiveMarks'],
      negativeMarks: json['negativeMarks'],
      exam: json['exam'] != null ? ExamModel.fromJson(json['exam'] as Map<String, dynamic>) : null,
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'year': year,
      'paperType': paperType,
      if (duration != null) 'duration': duration,
      if (totalQuestions != null) 'totalQuestions': totalQuestions,
      if (positiveMarks != null) 'positiveMarks': positiveMarks,
      if (negativeMarks != null) 'negativeMarks': negativeMarks,
      if (exam != null) 'exam': exam!.toJson(),
      if (createdAt != null) 'created_at': createdAt!.toIso8601String(),
      if (updatedAt != null) 'updated_at': updatedAt!.toIso8601String(),
    };
  }
}

class ExamModel {
  final String id;
  final String name;

  ExamModel({required this.id, required this.name});

  factory ExamModel.fromJson(Map<String, dynamic> json) {
    return ExamModel(id: json['id'] ?? '', name: json['name'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}

class QuestionResponse {
  final String id;
  final String questionId;
  final String? attemptedAnswer;
  final List<int> attemptedOptionIndexes;
  final QuestionModel question;
  final String isCorrect;
  final int marksAwarded;

  QuestionResponse({
    required this.id,
    this.attemptedAnswer,
    required this.questionId,
    required this.attemptedOptionIndexes,
    required this.marksAwarded,
    required this.isCorrect,
    required this.question,
  });

  factory QuestionResponse.fromJson(Map<String, dynamic> json) {
    return QuestionResponse(
      id: json['id'] ?? '',
      questionId: json['question_id'] ?? '',
      attemptedAnswer: json['attempted_answer'],
      attemptedOptionIndexes: json['attempted_option_indexes'] != null ? List<int>.from(json['attempted_option_indexes']) : [],
      isCorrect: json['is_correct'] ?? 'NO',
      marksAwarded: json['marks_awarded'] ?? 0,
      question: QuestionModel.fromJson(json['question'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question_id': questionId,
      'attempted_answer': attemptedAnswer,
      'attempted_option_indexes': attemptedOptionIndexes,
      'is_correct': isCorrect,
      'marks_awarded': marksAwarded,
      'question': question.toJson(),
    };
  }
}

class QuestionModel {
  final String id;
  final String title;
  final List<dynamic> options;
  final String? answer;
  final String? image;
  final TopicModel topic;

  QuestionModel({required this.id, required this.title, required this.options, this.answer, this.image, required this.topic});

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      options: json['options'] ?? [],
      answer: json['answer'],
      image: json['image'],
      topic: json['topic'] != null
          ? TopicModel.fromJson(json['topic'] as Map<String, dynamic>)
          : TopicModel(id: '', name: '', subjectName: ''),
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'options': options, 'answer': answer, 'image': image, 'topic': topic.toJson()};
  }
}

class TopicModel {
  final String id;
  final String name;
  final String subjectName;

  TopicModel({required this.id, required this.name, required this.subjectName});

  factory TopicModel.fromJson(Map<String, dynamic> json) {
    return TopicModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      subjectName: json['subject'] != null ? (json['subject'] is Map ? json['subject']['name'] ?? '' : '') : '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'subject': {'name': subjectName},
    };
  }
}

class PaperInsights {
  final double timePerQuestionAvg;
  final List<TopicAccuracy> accuracyByTopic;
  final QuestionsReview? questionsReview;

  PaperInsights({required this.timePerQuestionAvg, required this.accuracyByTopic, this.questionsReview});

  factory PaperInsights.fromJson(Map<String, dynamic> json) {
    return PaperInsights(
      timePerQuestionAvg: (json['time_per_question_avg'] ?? 0).toDouble(),
      accuracyByTopic: json['accuracy_by_topic'] != null
          ? (json['accuracy_by_topic'] as List).map((i) => TopicAccuracy.fromJson(i as Map<String, dynamic>)).toList()
          : [],
      questionsReview: json['questions_review'] != null
          ? QuestionsReview.fromJson(json['questions_review'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'time_per_question_avg': timePerQuestionAvg,
      'accuracy_by_topic': accuracyByTopic.map((t) => t.toJson()).toList(),
      if (questionsReview != null) 'questions_review': questionsReview!.toJson(),
    };
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
      topicName: json['topic_name'] ?? '',
      totalQuestions: json['total_questions'] ?? 0,
      attempted: json['attempted'] ?? 0,
      correct: json['correct'] ?? 0,
      accuracy: (json['accuracy'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'topic_name': topicName,
      'total_questions': totalQuestions,
      'attempted': attempted,
      'correct': correct,
      'accuracy': accuracy,
    };
  }
}

class QuestionsReview {
  final List<ReviewQuestion> correct;
  final List<ReviewQuestion> partiallyCorrect;
  final List<ReviewQuestion> incorrect;
  final List<ReviewQuestion> skipped;

  QuestionsReview({required this.correct, required this.partiallyCorrect, required this.incorrect, required this.skipped});

  factory QuestionsReview.fromJson(Map<String, dynamic> json) {
    return QuestionsReview(
      correct: json['correct'] != null
          ? (json['correct'] as List).map((i) => ReviewQuestion.fromJson(i as Map<String, dynamic>)).toList()
          : [],
      partiallyCorrect: json['partially_correct'] != null
          ? (json['partially_correct'] as List).map((i) => ReviewQuestion.fromJson(i as Map<String, dynamic>)).toList()
          : [],
      incorrect: json['incorrect'] != null
          ? (json['incorrect'] as List).map((i) => ReviewQuestion.fromJson(i as Map<String, dynamic>)).toList()
          : [],
      skipped: json['skipped'] != null
          ? (json['skipped'] as List).map((i) => ReviewQuestion.fromJson(i as Map<String, dynamic>)).toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'correct': correct.map((q) => q.toJson()).toList(),
      'partially_correct': partiallyCorrect.map((q) => q.toJson()).toList(),
      'incorrect': incorrect.map((q) => q.toJson()).toList(),
      'skipped': skipped.map((q) => q.toJson()).toList(),
    };
  }
}

class ReviewQuestion {
  final String questionId;
  final String questionTitle;
  final String topicName;

  ReviewQuestion({required this.questionId, required this.questionTitle, required this.topicName});

  factory ReviewQuestion.fromJson(Map<String, dynamic> json) {
    return ReviewQuestion(
      questionId: json['question_id'] ?? '',
      questionTitle: json['question_title'] ?? '',
      topicName: json['topic_name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'question_id': questionId, 'question_title': questionTitle, 'topic_name': topicName};
  }
}
