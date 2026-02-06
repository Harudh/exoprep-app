import 'package:flutter/material.dart';
import 'package:root/src/core/extensions/context_extension.dart';
import 'package:root/src/features/exam_analytics/widgets/monthly_progress.dart';
import 'package:root/src/features/exam_analytics/widgets/subject_wise_breakdown.dart';
import 'package:root/src/features/exam_analytics/widgets/summary_widget.dart';
import 'package:root/src/models/exam_analytics_model/exam_analytics_model.dart';
import 'package:root/src/features/exam_analytics/widgets/strong_week_subjects_widget.dart';

class AnalyticsView extends StatelessWidget {
  final ExamAnalyticsModel analytics;
  final ScrollController scrollController;

  const AnalyticsView({super.key, required this.analytics, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnalyticsSummaryWidget(analytics: analytics),
          const SizedBox(height: 12),
          if (analytics.monthlyProgress.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.only(left: 8),

              child: Text('Monthly Performance', style: context.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
            ),
            const SizedBox(height: 8),
            MonthlyProgressWidget(monthlyProgress: analytics.monthlyProgress),
          ],

          const SizedBox(height: 12),
          SubjectWiseBreakdownWidget(subjectPerformance: analytics.subjectPerformance),
          StrongWeekSubjectsCard(title: 'Strong topics', topics: analytics.strengths, scrollController: scrollController),
          const SizedBox(height: 8),
          StrongWeekSubjectsCard(title: 'Weak topics', topics: analytics.weaknesses, scrollController: scrollController),

          const SizedBox(height: 120),
        ],
      ),
    );
  }
}
