import 'package:root/src/models/streak_heatmap_model/streak_heatmap.dart';
import 'package:root/src/models/paper_model/attempted_paper_model.dart';
import 'package:root/src/core/common/state/viewmodel_state.dart';
import 'package:root/src/models/paper_model/paper_model.dart';
import 'package:root/src/repositories/papers_repository.dart';
import 'package:root/src/core/constants/enums.dart';
import 'package:root/src/core/logger/logger.dart';
import 'package:flutter/material.dart';

class ExamDashboardViewModel {
  final PapersRepository _papersRepository;

  ExamDashboardViewModel({PapersRepository? papersRepository}) : _papersRepository = papersRepository ?? PapersRepository();

  String examID = '';

  // Individual state notifiers for each section
  final ValueNotifier<ViewModelState> streakState = ValueNotifier(ViewModelState.idle());
  final ValueNotifier<ViewModelState> continueState = ValueNotifier(ViewModelState.idle());
  final ValueNotifier<ViewModelState> recentsState = ValueNotifier(ViewModelState.idle());
  final ValueNotifier<ViewModelState> pyqState = ValueNotifier(ViewModelState.idle(data: []));
  final ValueNotifier<ViewModelState> mockTestState = ValueNotifier(ViewModelState.idle(data: []));

  // Data notifiers
  final ValueNotifier<List<Paper>> pyqPapers = ValueNotifier([]);
  final ValueNotifier<List<Paper>> mockTestPapers = ValueNotifier([]);
  final ValueNotifier<StreakHeatmapModel?> streakData = ValueNotifier(null); // Add this
  final ValueNotifier<List<AttemptedPaper>> recentlyAttemptedPapers = ValueNotifier([]);

  /// Fetch all dashboard data concurrently
  Future<void> fetchDashboardData({required String examID}) async {
    try {
      await Future.wait([
        _fetchPYQPapers(examID),
        _fetchMockTestPapers(examID),
        _fetchStreakData(examID), // Add this
        _fetchRecentlyCompleted(examID),
      ], eagerError: false);

      AppLogs.info('All dashboard data fetched successfully');
    } catch (e) {
      AppLogs.warning("Error fetching dashboard data: $e");
    }
  }

  /// Fetch PYQ papers with individual state management
  Future<void> _fetchPYQPapers(String examID) async {
    pyqState.value = ViewModelState.loading(mode: ExamDashboardStates.practice.toString());

    try {
      final query = 'page=1&pageSize=5&exam_id=$examID&paperType=PYQ';
      final result = await _papersRepository.getPapers(query: query);

      pyqPapers.value = result;
      pyqState.value = ViewModelState.success(data: result, type: ExamDashboardStates.practice.toString());

      AppLogs.info('PYQ papers fetched: ${result.length}');
    } catch (e) {
      AppLogs.warning("Error fetching PYQ papers: $e");
      pyqPapers.value = [];
      pyqState.value = ViewModelState.error(error: e.toString(), type: ExamDashboardStates.practice.toString());
    }
  }

  /// Fetch Mock Test papers with individual state management
  Future<void> _fetchMockTestPapers(String examID) async {
    mockTestState.value = ViewModelState.loading(mode: ExamDashboardStates.practice.toString());

    try {
      final query = 'page=1&pageSize=5&exam_id=$examID&paperType=MOCK';
      final result = await _papersRepository.getPapers(query: query);

      mockTestPapers.value = result;
      mockTestState.value = ViewModelState.success(data: result, type: ExamDashboardStates.practice.toString());

      AppLogs.info('Mock test papers fetched: ${result.length}');
    } catch (e) {
      AppLogs.warning("Error fetching mock test papers: $e");
      mockTestPapers.value = [];
      mockTestState.value = ViewModelState.error(error: e.toString(), type: ExamDashboardStates.practice.toString());
    }
  }

  /// Fetch Streak Heatmap Data
  Future<void> _fetchStreakData(String examID) async {
    streakState.value = ViewModelState.loading(mode: ExamDashboardStates.streak.toString());
    final query = '';

    try {
      final result = await _papersRepository.getStreakHeatmap(examId: examID, query: query);
      streakData.value = result;
      streakState.value = ViewModelState.success(data: result, type: ExamDashboardStates.streak.toString());
      AppLogs.info('Streak heatmap data fetched successfully');
    } catch (e) {
      AppLogs.warning("Error fetching streak data: $e");
      streakState.value = ViewModelState.error(error: e.toString(), type: ExamDashboardStates.streak.toString());
    }
  }

  Future<void> _fetchRecentlyCompleted(String examID) async {
    recentsState.value = ViewModelState.loading(mode: ExamDashboardStates.recents.toString());
    final query = 'exam_id=$examID&page=1&pageSize=10';

    try {
      final result = await _papersRepository.recentlyAttemptedPapers(query: query);
      recentlyAttemptedPapers.value = result;
      recentsState.value = ViewModelState.success(data: result, type: ExamDashboardStates.recents.toString());
      AppLogs.info('Recently completed fetched successfully');
    } catch (e) {
      AppLogs.warning("Error fetching recently completed: $e");
      recentsState.value = ViewModelState.error(error: e.toString(), type: ExamDashboardStates.recents.toString());
    }
  }

  /// Refresh specific section independently
  Future<void> refreshPYQPapers(String examID) async {
    await _fetchPYQPapers(examID);
  }

  Future<void> refreshMockTests(String examID) async {
    await _fetchMockTestPapers(examID);
  }

  Future<void> refreshStreakData(String examID) async {
    await _fetchStreakData(examID);
  }

  Future<void> refreshRecentlyCompleted(String examID) async {
    await _fetchRecentlyCompleted(examID);
  }

  void dispose() {
    streakState.dispose();
    continueState.dispose();
    recentsState.dispose();
    pyqState.dispose();
    mockTestState.dispose();
    pyqPapers.dispose();
    mockTestPapers.dispose();
    streakData.dispose();
    recentlyAttemptedPapers.dispose();
  }
}
