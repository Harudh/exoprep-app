import 'package:flutter/material.dart';
import 'package:root/src/core/theme/colors.dart';
import 'package:root/src/core/navigation/routes.dart';
import 'package:root/src/models/exam_model/exam_model.dart';
import 'package:root/src/core/extensions/context_extension.dart';

class UserExamContainer extends StatelessWidget {
  const UserExamContainer({super.key, required this.cardWidth, required this.exam});

  final double cardWidth;
  final Exam exam;

  @override
  Widget build(BuildContext context) {
    final analytics = exam.analytics;

    final int papersGiven = analytics?.papersAttemptedByUser ?? 0;

    final int totalPapers = analytics?.totalPapersInExam ?? 0;

    final double progress = totalPapers == 0 ? 0 : papersGiven / totalPapers;

    final int accuracy = analytics?.overallAccuracy?.round() ?? 0;

    final int streak = analytics?.currentStreak ?? 0;

    return GestureDetector(
      onTap: () {
        AppRoute.examDashboard.pushNested(context, AppRoute.home);
      },
      child: Container(
        width: cardWidth,
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: context.isDarkMode ? Colors.grey.shade900 : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: context.isDarkMode ? Colors.grey.shade800 : Colors.grey.shade300),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(exam.name, style: context.headlineSmall!.copyWith(fontWeight: FontWeight.w800, letterSpacing: -0.5)),
                SizedBox(),
              ],
            ),

            const SizedBox(height: 4),

            Text(
              "Competitive Engineering Examination",
              style: context.bodySmall!.copyWith(color: Colors.grey.shade600, fontSize: 12),
            ),

            const SizedBox(height: 16),

            // Progress
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Progress", style: context.bodySmall!.copyWith(fontWeight: FontWeight.w600, fontSize: 12)),
                Text(
                  "$papersGiven/$totalPapers papers",
                  style: context.bodySmall!.copyWith(fontWeight: FontWeight.w700, fontSize: 12),
                ),
              ],
            ),

            const SizedBox(height: 8),

            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: context.isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200,
                color: AppColors.primaryColor,
                minHeight: 6,
              ),
            ),

            const Spacer(),

            // Bottom stats
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: context.isDarkMode ? Colors.grey.shade900 : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: context.isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.check_circle_outline, size: 34, color: Colors.green),
                      const SizedBox(width: 6),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("$accuracy%", style: context.bodyLarge!.copyWith(fontWeight: FontWeight.w800)),
                          Text("Accuracy", style: context.bodySmall!.copyWith(color: Colors.grey.shade600, fontSize: 10)),
                        ],
                      ),
                    ],
                  ),
                  Container(width: 1, height: 30, color: context.isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300),
                  Row(
                    children: [
                      const Icon(Icons.local_fire_department, size: 34, color: Colors.orange),
                      const SizedBox(width: 6),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("$streak", style: context.bodyLarge!.copyWith(fontWeight: FontWeight.w800)),
                          Text("Day Streak", style: context.bodySmall!.copyWith(color: Colors.grey.shade600, fontSize: 10)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
