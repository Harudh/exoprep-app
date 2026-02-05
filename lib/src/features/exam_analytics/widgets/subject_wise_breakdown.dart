import 'package:flutter/material.dart';
import 'package:root/src/core/extensions/context_extension.dart';
import 'package:root/src/models/exam_analytics_model/exam_analytics_model.dart';

class SubjectWiseBreakdownWidget extends StatelessWidget {
  final List<SubjectPerformance> subjectPerformance;

  const SubjectWiseBreakdownWidget({super.key, required this.subjectPerformance});

  @override
  Widget build(BuildContext context) {
    if (subjectPerformance.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Text("Subject-wise Breakdown", style: context.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
        ),
        const SizedBox(height: 12),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(0),
          shrinkWrap: true,
          itemCount: subjectPerformance.length,
          separatorBuilder: (c, i) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final subject = subjectPerformance[index];
            return _SubjectCard(subject: subject);
          },
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}

class _SubjectCard extends StatelessWidget {
  final SubjectPerformance subject;

  const _SubjectCard({required this.subject});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final cardBg = isDark ? Colors.grey.shade900 : Colors.white;
    final borderColor = isDark ? Colors.grey.shade800 : Colors.grey.shade200;

    const correctColor = Colors.green;
    const wrongColor = Colors.redAccent;
    const partialColor = Colors.orangeAccent;
    final emptyColor = isDark ? Colors.grey.shade700 : Colors.grey.shade200;

    final int correct = subject.correctAnswers.toInt();
    final int partial = subject.partiallyCorrectAnswers.toInt();
    final int wrong = subject.incorrectAnswers.toInt();
    final int total = subject.totalQuestionsAttempted.toInt();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Header: Name + Accuracy Badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(subject.subjectName, style: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getAccuracyColor(subject.accuracy).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "${subject.accuracy.toStringAsFixed(1)}% Acc.",
                  style: context.textTheme.labelSmall?.copyWith(
                    color: _getAccuracyColor(subject.accuracy),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // 2. Stacked Progress Bar
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: SizedBox(
              height: 8,
              child: Row(
                children: [
                  if (correct > 0)
                    Expanded(
                      flex: correct,
                      child: Container(color: correctColor),
                    ),
                  if (partial > 0)
                    Expanded(
                      flex: partial,
                      child: Container(color: partialColor),
                    ),
                  if (wrong > 0)
                    Expanded(
                      flex: wrong,
                      child: Container(color: wrongColor),
                    ),
                  // Fallback: if total is 0, show empty grey bar
                  if (total == 0) Expanded(flex: 1, child: Container(color: emptyColor)),
                ],
              ),
            ),
          ),

          const SizedBox(height: 12),

          // 3. Stat Metrics Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _StatItem(label: 'Total', value: '$total', color: isDark ? Colors.white70 : Colors.black87),
              _StatItem(label: 'Correct', value: '$correct', color: correctColor),
              _StatItem(label: 'Wrong', value: '$wrong', color: wrongColor),
              if (partial > 0) _StatItem(label: 'Partial', value: '$partial', color: partialColor),
            ],
          ),
        ],
      ),
    );
  }

  Color _getAccuracyColor(num accuracy) {
    if (accuracy >= 80) return Colors.green;
    if (accuracy >= 50) return Colors.orange;
    return Colors.red;
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _StatItem({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold, color: color),
        ),
        Text(label, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey, fontSize: 11)),
      ],
    );
  }
}
