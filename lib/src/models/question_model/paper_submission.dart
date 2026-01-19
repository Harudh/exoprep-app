class PaperSubmission {
  final String paperId;
  final DateTime startedAt;
  final DateTime completedAt;
  final List<QuestionResponse> responses;

  PaperSubmission({required this.paperId, required this.startedAt, required this.completedAt, required this.responses});

  Map<String, dynamic> toJson() {
    return {
      'paper_id': paperId,
      'started_at': startedAt.toUtc().toIso8601String(),
      'completed_at': completedAt.toUtc().toIso8601String(),
      'responses': responses.map((r) => r.toJson()).toList(),
    };
  }
}

class QuestionResponse {
  final String questionId;
  final String? attemptedAnswer;
  final List<int>? attemptedOptionIndexes;

  QuestionResponse({required this.questionId, this.attemptedAnswer, this.attemptedOptionIndexes});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {'question_id': questionId};

    if (attemptedAnswer != null) {
      json['attempted_answer'] = attemptedAnswer;
    }

    if (attemptedOptionIndexes != null && attemptedOptionIndexes!.isNotEmpty) {
      json['attempted_option_indexes'] = attemptedOptionIndexes;
    }

    return json;
  }
}
