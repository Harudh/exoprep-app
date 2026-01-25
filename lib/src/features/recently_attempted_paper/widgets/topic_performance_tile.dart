
part of '../recently_attempted_paper_view.dart';

class _TopicPerformanceTile extends StatelessWidget {
  const _TopicPerformanceTile({required this.topic});

  final TopicAccuracy topic;

  Color _getAccuracyColor(double accuracy) {
    if (accuracy >= 75) return const Color(0xFF10B981);
    if (accuracy >= 50) return const Color(0xFFF59E0B);
    return const Color(0xFFEF4444);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final accuracyColor = _getAccuracyColor(topic.accuracy);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(topic.topicName, style: context.bodyMedium?.copyWith(fontWeight: FontWeight.w600, fontSize: 13)),
            ),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: isDark ? Colors.grey.shade800.withValues(alpha: 0.3) : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '${topic.correct}/${topic.attempted} · ${topic.accuracy.toStringAsFixed(0)}%',
                style: context.bodySmall?.copyWith(color: accuracyColor, fontWeight: FontWeight.w700, fontSize: 11),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: topic.accuracy / 100,
            backgroundColor: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
            color: accuracyColor,
            minHeight: 6,
          ),
        ),
      ],
    );
  }
}
