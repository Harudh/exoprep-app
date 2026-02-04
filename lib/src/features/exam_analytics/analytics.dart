import 'package:flutter/material.dart';
import 'package:root/src/features/exam_analytics/widgets/strong_week_subjects_widget.dart';
import 'package:root/src/models/exam_analytics_model/exam_analytics_model.dart';

class AnalyticsView extends StatelessWidget {
  final ExamAnalyticsModel analytics;

  const AnalyticsView({super.key, required this.analytics});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 12),
          SubjectsFlowCard(title: 'Strong topics', topics: analytics.strengths),
          const SizedBox(height: 12),
          SubjectsFlowCard(title: 'Weak topics', topics: analytics.weaknesses),

          const SizedBox(height: 120),
        ],
      ),
    );
  }
}
