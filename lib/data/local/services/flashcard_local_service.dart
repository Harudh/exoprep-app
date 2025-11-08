import 'package:isar_community/isar.dart';
import 'package:root/data/local/database/isar_database.dart';
import 'package:root/data/models/flashcard_model/flashcard_schema_model.dart';

class FlashcardLocalService {
  late final Isar _isar;
  bool _isInitialized = false;

  // Initialize service
  Future<void> initialize() async {
    if (_isInitialized) {
      return;
    }

    _isar = await IsarDatabase.getInstance();
    _isInitialized = true;
  }

  // ========== FLASHCARD OPERATIONS ==========

  // CREATE - Add new flashcard
  Future<int> createFlashcard(FlashcardSchemaModel flashcard) async {
    return await _isar.writeTxn(() async {
      flashcard.createdAt = DateTime.now();
      flashcard.updatedAt = DateTime.now();
      return await _isar.flashcardSchemaModels.put(flashcard);
    });
  }

  // CREATE - Batch create flashcards
  Future<List<int>> createMultipleFlashcards(
      List<FlashcardSchemaModel> flashcards,
      ) async {
    return await _isar.writeTxn(() async {
      final now = DateTime.now();
      for (var flashcard in flashcards) {
        flashcard.createdAt = now;
        flashcard.updatedAt = now;
      }
      return await _isar.flashcardSchemaModels.putAll(flashcards);
    });
  }

  // READ - Get flashcard by ID
  Future<FlashcardSchemaModel?> getFlashcardById(int id) async {
    return await _isar.flashcardSchemaModels.get(id);
  }

  // READ - Get all flashcards
  Future<List<FlashcardSchemaModel>> getAllFlashcards() async {
    return await _isar.flashcardSchemaModels
        .where()
        .sortByCreatedAtDesc()
        .findAll();
  }

  // READ - Get flashcards by type
  Future<List<FlashcardSchemaModel>> getFlashcardsByType(
      FlashcardType type,
      ) async {
    return await _isar.flashcardSchemaModels
        .filter()
        .typeEqualTo(type)
        .sortByCreatedAtDesc()
        .findAll();
  }

  // READ - Get flashcards by source
  Future<List<FlashcardSchemaModel>> getFlashcardsBySource(
      FlashcardSource source,
      ) async {
    return await _isar.flashcardSchemaModels
        .filter()
        .sourceEqualTo(source)
        .sortByCreatedAtDesc()
        .findAll();
  }

  // READ - Get bookmarked flashcards
  Future<List<FlashcardSchemaModel>> getBookmarkedFlashcards() async {
    return await _isar.flashcardSchemaModels
        .filter()
        .isBookmarkedEqualTo(true)
        .sortByCreatedAtDesc()
        .findAll();
  }

  // READ - Search flashcards
  Future<List<FlashcardSchemaModel>> searchFlashcards(String query) async {
    return await _isar.flashcardSchemaModels
        .filter()
        .titleContains(query, caseSensitive: false)
        .or()
        .contentContains(query, caseSensitive: false)
        .sortByCreatedAtDesc()
        .findAll();
  }

  // UPDATE - Update flashcard
  Future<int> updateFlashcard(FlashcardSchemaModel flashcard) async {
    return await _isar.writeTxn(() async {
      flashcard.updatedAt = DateTime.now();
      return await _isar.flashcardSchemaModels.put(flashcard);
    });
  }

  // UPDATE - Mark as reviewed
  Future<void> markAsReviewed(int id) async {
    await _isar.writeTxn(() async {
      final flashcard = await _isar.flashcardSchemaModels.get(id);
      if (flashcard != null) {
        flashcard.reviewCount++;
        flashcard.lastReviewedAt = DateTime.now();
        flashcard.updatedAt = DateTime.now();
        await _isar.flashcardSchemaModels.put(flashcard);
      }
    });
  }

  // UPDATE - Toggle bookmark
  Future<void> toggleBookmark(int id) async {
    await _isar.writeTxn(() async {
      final flashcard = await _isar.flashcardSchemaModels.get(id);
      if (flashcard != null) {
        flashcard.isBookmarked = !flashcard.isBookmarked;
        flashcard.updatedAt = DateTime.now();
        await _isar.flashcardSchemaModels.put(flashcard);
      }
    });
  }

  // DELETE - Delete flashcard
  Future<bool> deleteFlashcard(int id) async {
    return await _isar.writeTxn(() async {
      return await _isar.flashcardSchemaModels.delete(id);
    });
  }

  // DELETE - Delete multiple flashcards
  Future<int> deleteMultipleFlashcards(List<int> ids) async {
    return await _isar.writeTxn(() async {
      return await _isar.flashcardSchemaModels.deleteAll(ids);
    });
  }

  // WATCH - Stream all flashcards
  Stream<List<FlashcardSchemaModel>> watchAllFlashcards() {
    return _isar.flashcardSchemaModels
        .where()
        .sortByCreatedAtDesc()
        .watch(fireImmediately: true);
  }

  // WATCH - Stream flashcard by ID
  Stream<FlashcardSchemaModel?> watchFlashcard(int id) {
    return _isar.flashcardSchemaModels.watchObject(id, fireImmediately: true);
  }

  // COUNT - Get total count
  Future<int> getFlashcardCount() async {
    return await _isar.flashcardSchemaModels.count();
  }

  // ========== FLASHCARD SET OPERATIONS ==========

  // CREATE - Create flashcard set
  Future<int> createFlashcardSet(FlashcardSetSchemaModel set) async {
    return await _isar.writeTxn(() async {
      set.createdAt = DateTime.now();
      set.updatedAt = DateTime.now();
      return await _isar.flashcardSetSchemaModels.put(set);
    });
  }

  // READ - Get all flashcard sets
  Future<List<FlashcardSetSchemaModel>> getAllFlashcardSets() async {
    return await _isar.flashcardSetSchemaModels
        .where()
        .sortByCreatedAtDesc()
        .findAll();
  }

  // READ - Get flashcard set by ID
  Future<FlashcardSetSchemaModel?> getFlashcardSetById(int id) async {
    return await _isar.flashcardSetSchemaModels.get(id);
  }

  // READ - Get flashcards by set ID
  Future<List<FlashcardSchemaModel>> getFlashcardsBySetId(int setId) async {
    final set = await getFlashcardSetById(setId);
    if (set == null) return [];

    final flashcards = await _isar.flashcardSchemaModels.getAll(
      set.flashcardIds.cast<int>(),
    );

    // Remove null entries before returning
    return flashcards.whereType<FlashcardSchemaModel>().toList();
  }


  // UPDATE - Update flashcard set
  Future<int> updateFlashcardSet(FlashcardSetSchemaModel set) async {
    return await _isar.writeTxn(() async {
      set.updatedAt = DateTime.now();
      return await _isar.flashcardSetSchemaModels.put(set);
    });
  }

  // DELETE - Delete flashcard set
  Future<bool> deleteFlashcardSet(int id) async {
    return await _isar.writeTxn(() async {
      return await _isar.flashcardSetSchemaModels.delete(id);
    });
  }

  // WATCH - Stream all flashcard sets
  Stream<List<FlashcardSetSchemaModel>> watchAllFlashcardSets() {
    return _isar.flashcardSetSchemaModels
        .where()
        .sortByCreatedAtDesc()
        .watch(fireImmediately: true);
  }
}
