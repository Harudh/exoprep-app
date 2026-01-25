class AttemptedQuestionsResponse {
  final String paperId;
  final List<AttemptedQuestion> questions;

  AttemptedQuestionsResponse({required this.paperId, required this.questions});

  Map<String, dynamic> toJson() {
    return {'paper_id': paperId, 'questions': questions.map((q) => q.toJson()).toList()};
  }

  @override
  String toString() {
    return 'AttemptedQuestionsModel(paperId: $paperId, questions: ${questions.length})';
  }
}

class AttemptedQuestion {
  final String questionId;
  final String? correctAnswer;
  final String? attemptedAnswer;
  final List<int>? correctOptionIndexes;
  final List<int>? attemptedOptionIndexes;

  AttemptedQuestion({
    required this.questionId,
    this.correctAnswer,
    this.attemptedAnswer,
    this.correctOptionIndexes,
    this.attemptedOptionIndexes,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {'question_id': questionId};

    if (correctAnswer != null) json['correct_answer'] = correctAnswer;
    if (attemptedAnswer != null) json['attempted_answer'] = attemptedAnswer;
    if (correctOptionIndexes != null) json['correct_option_indexes'] = correctOptionIndexes;
    if (attemptedOptionIndexes != null) json['attempted_option_indexes'] = attemptedOptionIndexes;

    return json;
  }

  @override
  String toString() {
    return 'AttemptedQuestion(questionId: $questionId, correctAnswer: $correctAnswer, attemptedAnswer: $attemptedAnswer, correctOptionIndexes: $correctOptionIndexes, attemptedOptionIndexes: $attemptedOptionIndexes)';
  }
}
