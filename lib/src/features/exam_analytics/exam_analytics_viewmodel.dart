import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:root/src/core/common/state/viewmodel_state.dart';
import 'package:root/src/models/exam_analytics_model/exam_analytics_model.dart';
import 'package:root/src/repositories/exam_analytics_repository.dart';

class ExamAnalyticsViewmodel {
  // Individual state notifiers for each section
  final ValueNotifier<ViewModelState> examAnalyticsState = ValueNotifier(ViewModelState.idle());

  final ExamAnalyticsRepository _examAnalyticsRepository = ExamAnalyticsRepository();
  late ExamAnalyticsModel examAnalyticsModel;

  Future<void> fetchAnalyticsData({required String examID}) async {
    examAnalyticsState.value = ViewModelState.loading();

    try {
      await Future.delayed(const Duration(seconds: 2));
      examAnalyticsModel = await _examAnalyticsRepository.getExamAnalytics(examID);
      log('Exam Name is');
      log(examAnalyticsModel.examName);
      examAnalyticsState.value = ViewModelState.success();
    } catch (e) {
      log('Error is:${e.toString()}');
      examAnalyticsState.value = ViewModelState.error(error: e.toString());
    }
  }
}
