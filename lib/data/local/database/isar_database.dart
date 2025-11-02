import 'dart:developer';

import 'package:isar_community/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:root/data/models/project_model/project_schema_model.dart';

class IsarDatabase {
  static Isar? _instance;

  // Singleton pattern for database instance
  static Future<Isar> getInstance() async {
    if (_instance != null && _instance!.isOpen) {
      return _instance!;
    }

    try {
      final dir = await getApplicationDocumentsDirectory();

      _instance = await Isar.open(
        [ProjectSchemaModelSchema],
        directory: dir.path,
        name: 'app_database',
      );

      log('✅ Isar Database initialized successfully');
      return _instance!;
    } catch (e) {
      log('❌ Isar Database initialization error: $e');
      rethrow;
    }
  }

  // Close database (call when app closes)
  static Future<void> close() async {
    if (_instance?.isOpen ?? false) {
      await _instance?.close();
      _instance = null;
      log('🔒 Isar Database closed');
    }
  }

  // Check if database is open
  static bool get isOpen => _instance?.isOpen ?? false;
}
