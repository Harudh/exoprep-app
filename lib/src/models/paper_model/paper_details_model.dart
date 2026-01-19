class PaperDetail {
  final String id;
  final String name;
  final String description;
  final int year;
  final String paperType;
  final int duration;
  final int totalQuestions;
  final int positiveMarks;
  final int negativeMarks;
  final ExamDetail exam;
  final DateTime createdAt;
  final DateTime updatedAt;

  PaperDetail({
    required this.id,
    required this.name,
    required this.description,
    required this.year,
    required this.paperType,
    required this.duration,
    required this.totalQuestions,
    required this.positiveMarks,
    required this.negativeMarks,
    required this.exam,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PaperDetail.fromJson(Map<String, dynamic> json) {
    return PaperDetail(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      year: json['year'] ?? 0,
      paperType: json['paperType'] ?? '',
      duration: json['duration'] ?? 0,
      totalQuestions: json['totalQuestions'] ?? 0,
      positiveMarks: json['positiveMarks'] ?? 0,
      negativeMarks: json['negativeMarks'] ?? 0,
      exam: ExamDetail.fromJson(json['exam'] ?? {}),
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updated_at'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'year': year,
      'paperType': paperType,
      'duration': duration,
      'totalQuestions': totalQuestions,
      'positiveMarks': positiveMarks,
      'negativeMarks': negativeMarks,
      'exam': exam.toJson(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

class ExamDetail {
  final String id;
  final String name;
  final String? parentId;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  ExamDetail({
    required this.id,
    required this.name,
    this.parentId,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ExamDetail.fromJson(Map<String, dynamic> json) {
    return ExamDetail(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      parentId: json['parent_id'],
      isActive: json['is_active'] ?? false,
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updated_at'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'parent_id': parentId,
      'is_active': isActive,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
