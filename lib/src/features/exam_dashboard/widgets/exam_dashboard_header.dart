part of '../exam_dashboard_view.dart';

class ExamDashboardHeader extends StatelessWidget {
  final String examName;

  const ExamDashboardHeader({super.key, required this.examName});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(ExamDashboardView.horizontalPadding, 16, ExamDashboardView.horizontalPadding, 0),
        child: Row(
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                height: 44,
                width: 44,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: context.isDarkMode ? Colors.grey.shade800 : Colors.grey.shade100,
                  border: Border.all(color: context.isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300),
                ),
                child: const Icon(Icons.arrow_back, size: 22),
              ),
            ),
            const SizedBox(width: 12),
            Text(examName, style: context.headlineSmall!.copyWith(fontWeight: FontWeight.w800, letterSpacing: -0.5)),
          ],
        ),
      ),
    );
  }
}
