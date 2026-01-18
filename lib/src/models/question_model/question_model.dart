class Question {
  final String id;
  final String title;
  final String? image;
  final String? answer;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<String> options;
  final PaperInQuestion paper;
  final TopicInQuestion topic;
  final List<int> correctOptionIndexes;

  Question({
    this.answer,
    this.image,
    required this.id,
    required this.title,
    required this.paper,
    required this.topic,
    required this.options,
    required this.createdAt,
    required this.updatedAt,
    required this.correctOptionIndexes,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'] as String,
      title: json['title'] as String,
      image: json['image'] as String?,
      answer: json['answer'] as String?,
      options: List<String>.from(json['options'] as List),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      paper: PaperInQuestion.fromJson(json['paper'] as Map<String, dynamic>),
      topic: TopicInQuestion.fromJson(json['topic'] as Map<String, dynamic>),
      correctOptionIndexes: List<int>.from(json['correctOptionIndexes'] as List),
    );
  }

  @override
  String toString() {
    return 'Question(id: $id, title: $title, options: $options, correctOptionIndexes: $correctOptionIndexes, answer: $answer, image: $image, paper: $paper, topic: $topic, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

class ExamInQuestion {
  final String id;
  final String name;

  ExamInQuestion({required this.id, required this.name});

  factory ExamInQuestion.fromJson(Map<String, dynamic> json) {
    return ExamInQuestion(id: json['id'] as String, name: json['name'] as String);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }

  @override
  String toString() {
    return 'ExamInQuestion(id: $id, name: $name)';
  }
}

class SubjectInQuestion {
  final String id;
  final String name;
  final ExamInQuestion exam;

  SubjectInQuestion({required this.id, required this.name, required this.exam});

  factory SubjectInQuestion.fromJson(Map<String, dynamic> json) {
    return SubjectInQuestion(
      id: json['id'] as String,
      name: json['name'] as String,
      exam: ExamInQuestion.fromJson(json['exam'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'exam': exam.toJson()};
  }

  @override
  String toString() {
    return 'SubjectInQuestion(id: $id, name: $name, exam: $exam)';
  }
}

class TopicInQuestion {
  final String id;
  final String name;
  final String description;
  final SubjectInQuestion subject;
  final DateTime createdAt;
  final DateTime updatedAt;

  TopicInQuestion({
    required this.id,
    required this.name,
    required this.description,
    required this.subject,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TopicInQuestion.fromJson(Map<String, dynamic> json) {
    return TopicInQuestion(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      subject: SubjectInQuestion.fromJson(json['subject'] as Map<String, dynamic>),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'subject': subject.toJson(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'TopicInQuestion(id: $id, name: $name, description: $description, subject: $subject, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

class PaperInQuestion {
  final String id;
  final String name;

  PaperInQuestion({required this.id, required this.name});

  factory PaperInQuestion.fromJson(Map<String, dynamic> json) {
    return PaperInQuestion(id: json['id'] as String, name: json['name'] as String);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }

  @override
  String toString() {
    return 'PaperInQuestion(id: $id, name: $name)';
  }
}
