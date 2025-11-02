import 'package:isar_community/isar.dart';
import 'package:root/data/local/database/isar_database.dart';
import 'package:root/data/models/project_model/project_schema_model.dart';
import 'package:root/src/core/constants/enums.dart';

class ProjectLocalService {
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

  // CREATE - Add new project
  Future<int> createProject(ProjectSchemaModel project) async {
    return await _isar.writeTxn(() async {
      project.createdAt = DateTime.now();
      project.updatedAt = DateTime.now();
      return await _isar.projectSchemaModels.put(project);
    });
  }

  // READ - Get project by ID
  Future<ProjectSchemaModel?> getProjectById(int id) async {
    return await _isar.projectSchemaModels.get(id);
  }

  // READ - Get all projects
  Future<List<ProjectSchemaModel>> getAllProjects() async {
    return await _isar.projectSchemaModels.where().findAll();
  }

  // READ - Get projects sorted by name
  Future<List<ProjectSchemaModel>> getProjectsSortedByName() async {
    return await _isar.projectSchemaModels
        .where()
        .sortByProjectName()
        .findAll();
  }

  // READ - Get projects by color tag
  Future<List<ProjectSchemaModel>> getProjectsByColor(int color) async {
    return await _isar.projectSchemaModels
        .filter()
        .tagColorEqualTo(color)
        .findAll();
  }

  // READ - Search projects by name (case-insensitive)
  Future<List<ProjectSchemaModel>> searchProjectsByName(String query) async {
    return await _isar.projectSchemaModels
        .filter()
        .projectNameContains(query, caseSensitive: false)
        .findAll();
  }

  // READ - Get projects with time goals
  Future<List<ProjectSchemaModel>> getProjectsWithTimeGoals() async {
    return await _isar.projectSchemaModels
        .filter()
        .hasTimeGoalEqualTo(true)
        .findAll();
  }

  // READ - Get projects by frequency type
  Future<List<ProjectSchemaModel>> getProjectsByFrequency(
    TimeGoalFrequency frequency,
  ) async {
    return await _isar.projectSchemaModels
        .filter()
        .timeGoalFrequencyEqualTo(frequency)
        .findAll();
  }

  // READ - Get recent projects (last 30 days)
  Future<List<ProjectSchemaModel>> getRecentProjects() async {
    final thirtyDaysAgo = DateTime.now().subtract(const Duration(days: 30));
    return await _isar.projectSchemaModels
        .filter()
        .createdAtGreaterThan(thirtyDaysAgo)
        .sortByCreatedAtDesc()
        .findAll();
  }

  // UPDATE - Update existing project
  Future<int> updateProject(ProjectSchemaModel project) async {
    return await _isar.writeTxn(() async {
      project.updatedAt = DateTime.now();
      return await _isar.projectSchemaModels.put(project);
    });
  }

  // DELETE - Delete project by ID
  Future<bool> deleteProject(int id) async {
    return await _isar.writeTxn(() async {
      return await _isar.projectSchemaModels.delete(id);
    });
  }

  // DELETE - Delete multiple projects
  Future<int> deleteProjects(List<int> ids) async {
    return await _isar.writeTxn(() async {
      return await _isar.projectSchemaModels.deleteAll(ids);
    });
  }

  // DELETE - Delete all projects
  Future<void> deleteAllProjects() async {
    await _isar.writeTxn(() async {
      await _isar.projectSchemaModels.clear();
    });
  }

  // COUNT - Get total project count
  Future<int> getProjectCount() async {
    return await _isar.projectSchemaModels.count();
  }

  // WATCH - Stream of all projects (reactive)
  Stream<List<ProjectSchemaModel>> watchAllProjects() {
    return _isar.projectSchemaModels.where().watch(fireImmediately: true);
  }

  // WATCH - Stream of specific project (reactive)
  Stream<ProjectSchemaModel?> watchProject(int id) {
    return _isar.projectSchemaModels.watchObject(id, fireImmediately: true);
  }

  // BATCH - Create multiple projects
  Future<List<int>> createMultipleProjects(
    List<ProjectSchemaModel> projects,
  ) async {
    return await _isar.writeTxn(() async {
      final now = DateTime.now();
      for (var project in projects) {
        project.createdAt = now;
        project.updatedAt = now;
      }
      return await _isar.projectSchemaModels.putAll(projects);
    });
  }
}
