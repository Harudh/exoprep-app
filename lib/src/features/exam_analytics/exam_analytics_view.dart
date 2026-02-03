import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:root/src/core/common/state/viewmodel_state.dart';
import 'package:root/src/core/extensions/context_extension.dart';
import 'package:root/src/features/exam_analytics/analytics.dart';
import 'package:root/src/core/common/ui/widgets/circle_button.dart';
import 'package:root/src/features/leaderboard/views/widgets/loader.dart';
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
      appBar: AppBar(
        title: Text('Exam Analytics', style: context.headlineSmall!.copyWith(fontWeight: FontWeight.w800, letterSpacing: -0.5)),

        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: CircleButton(icon: Icons.arrow_back, ontap: () => context.pop()),
        ),
      ),
      body: ValueListenableBuilder<ViewModelState>(
        valueListenable: _examAnalyticsViewmodel.examAnalyticsState,
        builder: (context, state, child) {
          log('State is : ${state.status}');
          if (state.status == ViewModelStatus.loading) {
            return LeaderboardLoadingWidget(showbg: false);
          } else if (state.status == ViewModelStatus.error) {
            return Center(child: Text('Error: ${state.error}'));
          } else if (state.status == ViewModelStatus.success) {
            return AnalyticsView(model: _examAnalyticsViewmodel.examAnalyticsModel);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
