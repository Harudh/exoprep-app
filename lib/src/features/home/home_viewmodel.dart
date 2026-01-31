import 'package:flutter/material.dart';
import 'package:root/src/core/common/state/viewmodel_state.dart';
import 'package:root/src/core/logger/logger.dart';
import 'package:root/src/models/exam_model/exam_model.dart';
import 'package:root/src/repositories/home_repository.dart';

class HomeViewmodel {
  final HomeRepository _homeRepository = HomeRepository();
  final ValueNotifier<ViewModelState> homeViewState = ValueNotifier(ViewModelState.idle());

  final ValueNotifier<List<Exam>> popularExams = ValueNotifier([]);
  final ValueNotifier<List<Exam>> userExams = ValueNotifier([]);

  Future<void> fetchDashboardData() async {
    homeViewState.value = ViewModelState.loading();
    popularExams.value = [];
    userExams.value = [];
    try {
      // Execute all API calls in parallel using Future.wait
      await Future.wait([_fetchUserExams(), _fetchLeafExams()], eagerError: false);
      AppLogs.info('All dashboard data fetched successfully');
      homeViewState.value = ViewModelState.success();
    } catch (e) {
      AppLogs.warning("Error fetching dashboard data: $e");
      homeViewState.value = ViewModelState.error(error: e.toString());
    }
  }

  Future<void> _fetchLeafExams() async {
    try {
      final result = await _homeRepository.getLeafExams();
      popularExams.value = result;
      AppLogs.info('All Leaf Exams fetched: ${result.length}');
    } catch (e) {
      AppLogs.warning("Error in fetching All Leaf Exams : $e");
      popularExams.value = [];
    }
  }

  Future<void> _fetchUserExams() async {
    try {
      final result = await _homeRepository.getUserExams();
      userExams.value = result;
      AppLogs.info('All User Exams fetched: ${result.length}');
    } catch (e) {
      AppLogs.warning("Error in fetching user Leaf Exams : $e");
      userExams.value = [];
    }
  }
}
