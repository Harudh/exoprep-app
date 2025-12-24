//
// ignore_for_file: prefer_constructors_over_static_methods

import 'package:isar_community/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:root/src/features/flash_cards/models/isar_model.dart/decks_isar_model.dart';
import 'package:root/src/features/flash_cards/models/isar_model.dart/flash_cards_collection_isar_model.dart';
import 'package:root/src/features/flash_cards/models/isar_model.dart/flash_cards_isar_model.dart';

/// Singleton service to manage Isar database instance
class IsarService {
  static IsarService? _instance;
  static Isar? _isar;

  IsarService._();

  /// Get singleton instance
  static IsarService get instance {
    _instance ??= IsarService._();
    return _instance!;
  }

  /// Get Isar database instance
  Isar get isar {
    if (_isar == null) {
      throw Exception('Isar not initialized. Call IsarService.instance.initialize() first.');
    }
    return _isar!;
  }

  bool get isInitialized => _isar != null;

  Future<void> initialize() async {
    if (_isar != null) return; // Already initialized

    final dir = await getApplicationDocumentsDirectory();

    _isar = await Isar.open(
      [
        FlashCardsCollectionIsarModelSchema,
        DecksIsarModelSchema,
        FlashCardsIsarModelSchema,

        // Add more schemas here as you create them (e.g., TasksSchema)
      ],
      directory: dir.path,
      name: 'db',
    );
  }

  /// Close the database (call this when app is terminated, if needed)
  Future<void> close() async {
    await _isar?.close();
    _isar = null;
  }

  /// Clear all data (useful for testing or logout)
  Future<void> clearAllData() async {
    await _isar?.writeTxn(() async {
      await _isar?.clear();
    });
  }

  List<IsarCollection<dynamic>> get allCollections => [
    // Add your collections here:
    _isar!.flashCardsCollectionIsarModels,
    _isar!.decksIsarModels,
    _isar!.flashCardsCollectionIsarModels,

    // _isar!.yourNewTableModels, <-- Just add new ones here
  ];
}
