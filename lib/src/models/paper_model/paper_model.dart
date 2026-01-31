class Paper {
  final int year;
  final String id;
  final String name;
  final bool isActive;
  final String paperType;
  final ExamInPaper exam;
  final String accessType;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int durationInMinutes;

  Paper({
    required this.id,
    required this.name,
    required this.exam,
    required this.year,
    required this.isActive,
    required this.paperType,
    required this.createdAt,
    required this.updatedAt,
    required this.accessType,
    required this.description,
    required this.durationInMinutes,
  });

  factory Paper.fromJson(Map<String, dynamic> json) {
    return Paper(
      year: json['year'] ?? 0,
      id: json['id']?.toString() ?? '',
      isActive: json['isActive'] ?? false,
      name: json['name']?.toString() ?? '',
      durationInMinutes: json['duration'] ?? 0,
      accessType: json['accessType'].toString(),
      paperType: json['paperType']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      exam: ExamInPaper.fromJson(json['exam'] as Map<String, dynamic>? ?? {}),
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
      'accessType': accessType,
      'description': description,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'Paper(id: $id, name: $name, description: $description, exam: $exam, createdAt: $createdAt, updatedAt: $updatedAt), accessType: $accessType';
  }
}

class ExamInPaper {
  final String id;
  final String name;

  ExamInPaper({required this.id, required this.name});

  factory ExamInPaper.fromJson(Map<String, dynamic> json) {
    return ExamInPaper(id: json['id']?.toString() ?? '', name: json['name']?.toString() ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }

  @override
  String toString() {
    return 'Exam(id: $id, name: $name)';
  }
}
