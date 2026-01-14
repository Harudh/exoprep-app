class Subject {
  final String id;
  final String name;
  final ExamSubject exam;
  final DateTime createdAt;
  final DateTime updatedAt;

  Subject({required this.id, required this.name, required this.exam, required this.createdAt, required this.updatedAt});

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      exam: ExamSubject.fromJson(json['exam'] as Map<String, dynamic>? ?? {}),
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : DateTime.now(),
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'exam': exam.toJson(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'Paper(id: $id, name: $name, exam: $exam, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

class ExamSubject {
  final String id;
  final String name;

  ExamSubject({required this.id, required this.name});

  factory ExamSubject.fromJson(Map<String, dynamic> json) {
    return ExamSubject(id: json['id']?.toString() ?? '', name: json['name']?.toString() ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }

  @override
  String toString() {
    return 'Exam(id: $id, name: $name)';
  }
}
