import 'dart:developer';

import 'package:root/data/local/services/project_local_service.dart';
import 'package:root/data/models/project_model/project_schema_model.dart';

class ProductivityService {
  static final ProjectLocalService _projectLocalService = ProjectLocalService();

  Future<void> saveProjectFromViewModel(ProjectSchemaModel schemaModel) async {
    try {
      await _projectLocalService.initialize();

      await _projectLocalService.createProject(schemaModel);

      log('✅ Project saved successfully');
    } catch (e) {
      log('❌ Error saving project: $e');
      rethrow;
    }
  }
}
