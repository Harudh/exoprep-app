import 'package:isar_community/isar.dart';

part 'flashcard_schema_model.g.dart';

enum FlashcardType {
  shortNotes,
  quiz,
  summary,
}

enum FlashcardSource {
  pdf,
  image,
  text,
  manual,
}

@collection
class FlashcardSchemaModel {
  Id id = Isar.autoIncrement;

  // Basic Info
  late String title;
  String? subtitle;

  // Content
  late String content; // Main content or question
  String? answer; // For quiz type
  List<String>? options; // For multiple choice quiz
  int? correctOptionIndex; // Index of correct answer

  // Metadata
  @Enumerated(EnumType.name)
  late FlashcardType type;

  @Enumerated(EnumType.name)
  late FlashcardSource source;

  String? sourceFileName; // Original file name if from file
  String? tags; // Comma-separated tags

  // Learning Progress
  int reviewCount = 0;
  bool isBookmarked = false;
  bool isCompleted = false;
  double? confidenceScore; // 0-100 for learning progress

  // Color/Visual
  int? tagColor; // Color code for visual grouping

  // Timestamps
  late DateTime createdAt;
  late DateTime updatedAt;
  DateTime? lastReviewedAt;

  FlashcardSchemaModel();
}

@collection
class FlashcardSetSchemaModel {
  Id id = Isar.autoIncrement;

  // Set Info
  late String setName;
  String? description;

  // Metadata
  List<int> flashcardIds = []; // References to flashcard IDs
  int totalCards = 0;
  int completedCards = 0;

  @Enumerated(EnumType.name)
  late FlashcardSource source;

  String? sourceFileName;
  int? tagColor;

  // Timestamps
  late DateTime createdAt;
  late DateTime updatedAt;

  FlashcardSetSchemaModel();
}
