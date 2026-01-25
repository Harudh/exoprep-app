part of '../recently_attempted_paper_view.dart';

class _TopicInsightsCard extends StatelessWidget {
  const _TopicInsightsCard({required this.insights});

  final PaperInsights insights;

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
          Text('Topic-wise Performance', style: context.titleMedium?.copyWith(fontWeight: FontWeight.w700, letterSpacing: -0.5)),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: isDark ? Colors.grey.shade800.withValues(alpha: 0.3) : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.access_time_rounded, size: 14, color: Colors.grey.shade600),
                const SizedBox(width: 6),
                Text(
                  'Avg ${insights.timePerQuestionAvg.toStringAsFixed(1)}s per question',
                  style: context.bodySmall?.copyWith(fontWeight: FontWeight.w600, fontSize: 11, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          ...insights.accuracyByTopic.map(
                (topic) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _TopicPerformanceTile(topic: topic),
            ),
          ),
        ],
      ),
    );
  }
}
