import 'package:root/data/local/services/flashcard_local_service.dart';
import 'package:root/data/models/flashcard_model/flashcard_schema_model.dart';

class FlashcardRepository {
  final FlashcardLocalService _localService;

  FlashcardRepository(this._localService);

  // Initialize
  Future<void> initialize() async {
    await _localService.initialize();
  }

  // ========== FLASHCARD OPERATIONS ==========

  Future<int> createFlashcard(FlashcardSchemaModel flashcard) async {
    return await _localService.createFlashcard(flashcard);
  }

  Future<List<int>> createMultipleFlashcards(
      List<FlashcardSchemaModel> flashcards,
      ) async {
    return await _localService.createMultipleFlashcards(flashcards);
  }

  Future<FlashcardSchemaModel?> getFlashcardById(int id) async {
    return await _localService.getFlashcardById(id);
  }

  Future<List<FlashcardSchemaModel>> getAllFlashcards() async {
    return await _localService.getAllFlashcards();
  }

  Future<List<FlashcardSchemaModel>> getFlashcardsByType(
      FlashcardType type,
      ) async {
    return await _localService.getFlashcardsByType(type);
  }

  Future<List<FlashcardSchemaModel>> getFlashcardsBySource(
      FlashcardSource source,
      ) async {
    return await _localService.getFlashcardsBySource(source);
  }

  Future<List<FlashcardSchemaModel>> getBookmarkedFlashcards() async {
    return await _localService.getBookmarkedFlashcards();
  }

  Future<List<FlashcardSchemaModel>> searchFlashcards(String query) async {
    return await _localService.searchFlashcards(query);
  }

  Future<int> updateFlashcard(FlashcardSchemaModel flashcard) async {
    return await _localService.updateFlashcard(flashcard);
  }

  Future<void> markAsReviewed(int id) async {
    await _localService.markAsReviewed(id);
  }

  Future<void> toggleBookmark(int id) async {
    await _localService.toggleBookmark(id);
  }

  Future<bool> deleteFlashcard(int id) async {
    return await _localService.deleteFlashcard(id);
  }

  Future<int> deleteMultipleFlashcards(List<int> ids) async {
    return await _localService.deleteMultipleFlashcards(ids);
  }

  Stream<List<FlashcardSchemaModel>> watchAllFlashcards() {
    return _localService.watchAllFlashcards();
  }

  Stream<FlashcardSchemaModel?> watchFlashcard(int id) {
    return _localService.watchFlashcard(id);
  }

  Future<int> getFlashcardCount() async {
    return await _localService.getFlashcardCount();
  }

  // ========== FLASHCARD SET OPERATIONS ==========

  Future<int> createFlashcardSet(FlashcardSetSchemaModel set) async {
    return await _localService.createFlashcardSet(set);
  }

  Future<List<FlashcardSetSchemaModel>> getAllFlashcardSets() async {
    return await _localService.getAllFlashcardSets();
  }

  Future<FlashcardSetSchemaModel?> getFlashcardSetById(int id) async {
    return await _localService.getFlashcardSetById(id);
  }

  Future<List<FlashcardSchemaModel>> getFlashcardsBySetId(int setId) async {
    return await _localService.getFlashcardsBySetId(setId);
  }

  Future<int> updateFlashcardSet(FlashcardSetSchemaModel set) async {
    return await _localService.updateFlashcardSet(set);
  }

  Future<bool> deleteFlashcardSet(int id) async {
    return await _localService.deleteFlashcardSet(id);
  }

  Stream<List<FlashcardSetSchemaModel>> watchAllFlashcardSets() {
    return _localService.watchAllFlashcardSets();
  }
}
