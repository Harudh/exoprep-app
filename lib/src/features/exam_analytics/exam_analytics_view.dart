import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:root/src/core/common/state/viewmodel_state.dart';
import 'package:root/src/features/exam_analytics/exam_analytics_viewmodel.dart';

part 'exam_analytics_mixin.dart';

class ExamAnalyticsView extends StatefulWidget {
  const ExamAnalyticsView({super.key, required this.examId});
  final String examId;

  @override
  State<ExamAnalyticsView> createState() => _ExamAnalyticsViewState();
}

class _ExamAnalyticsViewState extends State<ExamAnalyticsView> with ExamAnalyticsMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Exam Analytics')),
      body: ValueListenableBuilder<ViewModelState>(
        valueListenable: _examAnalyticsViewmodel.examAnalyticsState,
        builder: (context, state, child) {
          log('State is : ${state.status}');
          if (state.status == ViewModelStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.status == ViewModelStatus.error) {
            return Center(child: Text('Error: ${state.error}'));
          } else if (state.status == ViewModelStatus.success) {
            return Center(child: Text('Data Loaded Successfuly'));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
