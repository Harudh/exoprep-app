part of '../recently_attempted_paper_view.dart';
class _PerformanceBreakdownCard extends StatelessWidget {
  const _PerformanceBreakdownCard({required this.paper});

  final RecentlyAttemptedPaper paper;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey.shade900 : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isDark ? Colors.grey.shade800 : Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Performance Breakdown', style: context.titleMedium?.copyWith(fontWeight: FontWeight.w700, letterSpacing: -0.5)),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _StatTile(label: 'Correct', value: paper.correctCount, color: const Color(0xFF10B981)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatTile(label: 'Incorrect', value: paper.incorrectCount, color: const Color(0xFFEF4444)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _StatTile(label: 'Partial', value: paper.partiallyCorrectCount, color: const Color(0xFFF59E0B)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatTile(label: 'Skipped', value: paper.skippedCount, color: Colors.grey.shade400),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Attempted',
                style: context.bodySmall?.copyWith(color: Colors.grey.shade600, fontWeight: FontWeight.w600, fontSize: 12),
              ),
              Text(
                '${paper.attemptedCount}/${paper.totalQuestions}',
                style: context.bodySmall?.copyWith(fontWeight: FontWeight.w700, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: paper.attemptedCount / paper.totalQuestions,
              backgroundColor: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
              color: isDark ? Colors.white : Colors.black,
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }
}
