import 'package:root/src/core/common/state/viewmodel_state.dart';
import 'package:root/src/core/constants/enums.dart';
import 'package:root/src/models/paper_model/paper_model.dart';
import 'package:root/src/repositories/papers_repository.dart';
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

  // Future-ready notifiers for other sections
  // final ValueNotifier<StreakData?> streakData = ValueNotifier(null);
  // final ValueNotifier<ContinueProgress?> continueProgress = ValueNotifier(null);
  // final ValueNotifier<List<CompletedTest>> recentlyCompleted = ValueNotifier([]);

  /// Fetch all dashboard data concurrently
  Future<void> fetchDashboardData({required String examID}) async {
    try {
      // Execute all API calls in parallel using Future.wait
      await Future.wait([
        _fetchPYQPapers(examID),
        _fetchMockTestPapers(examID),
        // Add future API calls here as you create them
        // _fetchStreakData(examID),
        // _fetchContinueProgress(examID),
        // _fetchRecentlyCompleted(examID),
      ], eagerError: false); // eagerError: false continues even if one fails

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

  // Template methods for future APIs - uncomment when endpoints are ready

  // Future<void> _fetchStreakData(String examID) async {
  //   streakState.value = ViewModelState.loading(
  //     mode: ExamDashboardStates.streak.toString()
  //   );
  //
  //   try {
  //     final result = await _papersRepository.getStreakData(examID: examID);
  //     streakData.value = result;
  //     streakState.value = ViewModelState.success(
  //       data: result,
  //       type: ExamDashboardStates.streak.toString()
  //     );
  //     AppLogs.info('Streak data fetched successfully');
  //   } catch (e) {
  //     AppLogs.warning("Error fetching streak data: $e");
  //     streakState.value = ViewModelState.error(
  //       error: e.toString(),
  //       type: ExamDashboardStates.streak.toString()
  //     );
  //   }
  // }

  // Future<void> _fetchContinueProgress(String examID) async {
  //   continueState.value = ViewModelState.loading(
  //     mode: ExamDashboardStates.left.toString()
  //   );
  //
  //   try {
  //     final result = await _papersRepository.getContinueProgress(examID: examID);
  //     continueProgress.value = result;
  //     continueState.value = ViewModelState.success(
  //       data: result,
  //       type: ExamDashboardStates.left.toString()
  //     );
  //     AppLogs.info('Continue progress fetched successfully');
  //   } catch (e) {
  //     AppLogs.warning("Error fetching continue progress: $e");
  //     continueState.value = ViewModelState.error(
  //       error: e.toString(),
  //       type: ExamDashboardStates.left.toString()
  //     );
  //   }
  // }

  // Future<void> _fetchRecentlyCompleted(String examID) async {
  //   recentsState.value = ViewModelState.loading(
  //     mode: ExamDashboardStates.recents.toString()
  //   );
  //
  //   try {
  //     final result = await _papersRepository.getRecentlyCompleted(examID: examID);
  //     recentlyCompleted.value = result;
  //     recentsState.value = ViewModelState.success(
  //       data: result,
  //       type: ExamDashboardStates.recents.toString()
  //     );
  //     AppLogs.info('Recently completed fetched successfully');
  //   } catch (e) {
  //     AppLogs.warning("Error fetching recently completed: $e");
  //     recentsState.value = ViewModelState.error(
  //       error: e.toString(),
  //       type: ExamDashboardStates.recents.toString()
  //     );
  //   }
  // }

  /// Refresh specific section independently
  Future<void> refreshPYQPapers(String examID) async {
    await _fetchPYQPapers(examID);
  }

  Future<void> refreshMockTests(String examID) async {
    await _fetchMockTestPapers(examID);
  }

  // Future refresh methods for other sections
  // Future<void> refreshStreakData(String examID) async {
  //   await _fetchStreakData(examID);
  // }

  // Future<void> refreshContinueProgress(String examID) async {
  //   await _fetchContinueProgress(examID);
  // }

  // Future<void> refreshRecentlyCompleted(String examID) async {
  //   await _fetchRecentlyCompleted(examID);
  // }

  void dispose() {
    streakState.dispose();
    continueState.dispose();
    recentsState.dispose();
    pyqState.dispose();
    mockTestState.dispose();
    pyqPapers.dispose();
    mockTestPapers.dispose();
  }
}
