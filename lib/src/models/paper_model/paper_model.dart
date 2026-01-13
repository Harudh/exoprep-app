class Paper {
  final String id;
  final String name;
  final String description;
  final ExamPaper exam;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String paperType;
  final int year;

  Paper({
    required this.id,
    required this.name,
    required this.description,
    required this.exam,
    required this.createdAt,
    required this.updatedAt,
    required this.paperType,
    required this.year,
  });

  factory Paper.fromJson(Map<String, dynamic> json) {
    return Paper(
      year: json['year'] ?? 0,
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      paperType: json['paperType']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      exam: ExamPaper.fromJson(json['exam'] as Map<String, dynamic>? ?? {}),
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : DateTime.now(),
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'year': year,
      'exam': exam.toJson(),
      'paperType': paperType,
      'description': description,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'Paper(id: $id, name: $name, description: $description, exam: $exam, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

class ExamPaper {
  final String id;
  final String name;
  final List<ExamPaper> children;

  ExamPaper({required this.id, required this.name, this.children = const []});

  factory ExamPaper.fromJson(Map<String, dynamic> json) {
    final childrenJson = json['children'] as List?;
    return ExamPaper(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      children: childrenJson == null
          ? []
          : childrenJson.map((child) => ExamPaper.fromJson(child as Map<String, dynamic>)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, if (children.isNotEmpty) 'children': children.map((e) => e.toJson()).toList()};
  }

  @override
  String toString() {
    if (children.isEmpty) {
      return 'Exam(id: $id, name: $name)';
    }
    return 'Exam(id: $id, name: $name, children: ${children.map((e) => e.toString()).toList()})';
  }
}
