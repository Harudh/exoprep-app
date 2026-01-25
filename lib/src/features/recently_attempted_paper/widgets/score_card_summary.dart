part of '../recently_attempted_paper_view.dart';

class _ScoreSummaryCard extends StatelessWidget {
  const _ScoreSummaryCard({required this.paper});

  final RecentlyAttemptedPaper paper;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 20),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey.shade900 : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isDark ? Colors.grey.shade800 : Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Text(
            'Your Score',
            style: context.bodyMedium?.copyWith(
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w600,
              fontSize: 13,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                paper.score.toStringAsFixed(1),
                style: context.titleLarge?.copyWith(fontWeight: FontWeight.w800, letterSpacing: -2, fontSize: 56),
              ),
              Text(
                ' / ${paper.totalQuestions * 4}',
                style: context.headlineSmall?.copyWith(color: Colors.grey.shade500, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: BoxDecoration(
              color: isDark ? Colors.grey.shade800.withValues(alpha: 0.5) : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '${paper.percentage.toStringAsFixed(1)}%',
              style: context.titleMedium?.copyWith(fontWeight: FontWeight.w700, letterSpacing: -0.5),
            ),
          ),
        ],
      ),
    );
  }
}
