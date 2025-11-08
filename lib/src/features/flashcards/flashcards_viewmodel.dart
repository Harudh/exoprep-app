// lib/presentation/viewmodels/flashcard_viewmodel.dart

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:root/data/models/flashcard_model/flashcard_schema_model.dart';
import 'package:root/src/repositories/flashcards_repository.dart';

class FlashcardViewModel {
  final FlashcardRepository _repository;

  FlashcardViewModel(this._repository);

  // ValueNotifiers for reactive state
  final ValueNotifier<List<FlashcardSchemaModel>> flashcardsNotifier =
  ValueNotifier([]);
  final ValueNotifier<List<FlashcardSetSchemaModel>> flashcardSetsNotifier =
  ValueNotifier([]);
  final ValueNotifier<bool> isLoadingNotifier = ValueNotifier(false);
  final ValueNotifier<bool> isGeneratingNotifier = ValueNotifier(false);
  final ValueNotifier<String?> errorMessageNotifier = ValueNotifier(null);
  final ValueNotifier<FlashcardType> selectedTypeNotifier =
  ValueNotifier(FlashcardType.shortNotes);
  final ValueNotifier<FlashcardSource> selectedSourceNotifier =
  ValueNotifier(FlashcardSource.text);

  // Getters for convenience
  List<FlashcardSchemaModel> get flashcards => flashcardsNotifier.value;
  List<FlashcardSetSchemaModel> get flashcardSets => flashcardSetsNotifier.value;
  bool get isLoading => isLoadingNotifier.value;
  bool get isGenerating => isGeneratingNotifier.value;
  String? get errorMessage => errorMessageNotifier.value;
  FlashcardType get selectedType => selectedTypeNotifier.value;
  FlashcardSource get selectedSource => selectedSourceNotifier.value;

  // Initialize
  Future<void> initialize() async {
    await _repository.initialize();
    await loadFlashcards();
    await loadFlashcardSets();
  }

  // Set selected type
  void setSelectedType(FlashcardType type) {
    selectedTypeNotifier.value = type;
  }

  // Set selected source
  void setSelectedSource(FlashcardSource source) {
    selectedSourceNotifier.value = source;
  }

  // Load all flashcards
  Future<void> loadFlashcards() async {
    try {
      isLoadingNotifier.value = true;
      errorMessageNotifier.value = null;

      final result = await _repository.getAllFlashcards();
      flashcardsNotifier.value = result;

      isLoadingNotifier.value = false;
    } catch (e) {
      isLoadingNotifier.value = false;
      errorMessageNotifier.value = 'Failed to load flashcards: $e';
      log('❌ Error loading flashcards: $e');
    }
  }

  // Load all flashcard sets
  Future<void> loadFlashcardSets() async {
    try {
      final result = await _repository.getAllFlashcardSets();
      flashcardSetsNotifier.value = result;
    } catch (e) {
      log('❌ Error loading flashcard sets: $e');
    }
  }

  // Create flashcard from text
  Future<bool> createFlashcardFromText({
    required String content,
    required String title,
    String? subtitle,
  }) async {
    try {
      isGeneratingNotifier.value = true;
      errorMessageNotifier.value = null;

      final flashcard = FlashcardSchemaModel()
        ..title = title
        ..subtitle = subtitle
        ..content = content
        ..type = selectedTypeNotifier.value
        ..source = FlashcardSource.text
        ..tagColor = _getRandomColor();

      await _repository.createFlashcard(flashcard);
      await loadFlashcards();

      isGeneratingNotifier.value = false;
      return true;
    } catch (e) {
      isGeneratingNotifier.value = false;
      errorMessageNotifier.value = 'Failed to create flashcard: $e';
      log('❌ Error creating flashcard: $e');
      return false;
    }
  }

  // Generate flashcards using AI (placeholder for Gemini integration)
  Future<bool> generateFlashcardsFromSource({
    required String sourceContent,
    required FlashcardSource source,
    String? fileName,
  }) async {
    try {
      isGeneratingNotifier.value = true;
      errorMessageNotifier.value = null;

      // TODO: Integrate with Gemini API to generate flashcards
      // For now, create a sample flashcard

      final flashcards = <FlashcardSchemaModel>[];

      // Generate based on type
      switch (selectedTypeNotifier.value) {
        case FlashcardType.shortNotes:
          flashcards.add(_createShortNoteFlashcard(sourceContent, source, fileName));
          break;
        case FlashcardType.quiz:
          flashcards.addAll(_createQuizFlashcards(sourceContent, source, fileName));
          break;
        case FlashcardType.summary:
          flashcards.add(_createSummaryFlashcard(sourceContent, source, fileName));
          break;
      }

      await _repository.createMultipleFlashcards(flashcards);
      await loadFlashcards();

      isGeneratingNotifier.value = false;
      return true;
    } catch (e) {
      isGeneratingNotifier.value = false;
      errorMessageNotifier.value = 'Failed to generate flashcards: $e';
      log('❌ Error generating flashcards: $e');
      return false;
    }
  }

  // Helper: Create short note flashcard
  FlashcardSchemaModel _createShortNoteFlashcard(
      String content,
      FlashcardSource source,
      String? fileName,
      ) {
    return FlashcardSchemaModel()
      ..title = fileName ?? 'Short Note'
      ..subtitle = 'Quick reference note'
      ..content = content
      ..type = FlashcardType.shortNotes
      ..source = source
      ..sourceFileName = fileName
      ..tagColor = _getRandomColor();
  }

  // Helper: Create quiz flashcards
  List<FlashcardSchemaModel> _createQuizFlashcards(
      String content,
      FlashcardSource source,
      String? fileName,
      ) {
    // TODO: Use Gemini to generate relevant quiz questions
    return [
      FlashcardSchemaModel()
        ..title = 'Quiz Question 1'
        ..content = 'Sample question from content'
        ..answer = 'Sample answer'
        ..options = ['Option A', 'Option B', 'Option C', 'Option D']
        ..correctOptionIndex = 0
        ..type = FlashcardType.quiz
        ..source = source
        ..sourceFileName = fileName
        ..tagColor = _getRandomColor(),
    ];
  }

  // Helper: Create summary flashcard
  FlashcardSchemaModel _createSummaryFlashcard(
      String content,
      FlashcardSource source,
      String? fileName,
      ) {
    return FlashcardSchemaModel()
      ..title = fileName ?? 'Summary'
      ..subtitle = 'Content summary'
      ..content = 'AI-generated summary of the content'
      ..type = FlashcardType.summary
      ..source = source
      ..sourceFileName = fileName
      ..tagColor = _getRandomColor();
  }

  // Toggle bookmark
  Future<void> toggleBookmark(int id) async {
    try {
      await _repository.toggleBookmark(id);
      await loadFlashcards();
    } catch (e) {
      log('❌ Error toggling bookmark: $e');
    }
  }

  // Mark as reviewed
  Future<void> markAsReviewed(int id) async {
    try {
      await _repository.markAsReviewed(id);
      await loadFlashcards();
    } catch (e) {
      log('❌ Error marking as reviewed: $e');
    }
  }

  // Delete flashcard
  Future<bool> deleteFlashcard(int id) async {
    try {
      final result = await _repository.deleteFlashcard(id);
      await loadFlashcards();
      return result;
    } catch (e) {
      log('❌ Error deleting flashcard: $e');
      return false;
    }
  }

  // Search flashcards
  Future<void> searchFlashcards(String query) async {
    try {
      if (query.isEmpty) {
        await loadFlashcards();
        return;
      }

      final result = await _repository.searchFlashcards(query);
      flashcardsNotifier.value = result;
    } catch (e) {
      log('❌ Error searching flashcards: $e');
    }
  }

  // Get random color for tag
  int _getRandomColor() {
    final colors = [
      0xFF3B82F6, // Blue
      0xFF10B981, // Green
      0xFFF59E0B, // Amber
      0xFFEF4444, // Red
      0xFF8B5CF6, // Purple
      0xFFEC4899, // Pink
      0xFF06B6D4, // Cyan
      0xFFF97316, // Orange
    ];
    return colors[DateTime.now().millisecond % colors.length];
  }

  // Dispose all notifiers
  void dispose() {
    flashcardsNotifier.dispose();
    flashcardSetsNotifier.dispose();
    isLoadingNotifier.dispose();
    isGeneratingNotifier.dispose();
    errorMessageNotifier.dispose();
    selectedTypeNotifier.dispose();
    selectedSourceNotifier.dispose();
  }
}
