part of '../recently_attempted_questions_view.dart';

class _ReviewHeader extends StatelessWidget {
  const _ReviewHeader({
    required this.recentlyAttemptedPaper,
    required this.currentQuestionNumber,
  });

  final RecentlyAttemptedPaper recentlyAttemptedPaper;
  final int currentQuestionNumber;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A1A1A) : Colors.white,
        border: Border(
          bottom: BorderSide(
            color: isDark ? const Color(0xFF2A2A2A) : const Color(0xFFE5E7EB),
            width: 1,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            recentlyAttemptedPaper.paper.name,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: isDark ? const Color(0xFFE5E5E5) : const Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 8,
            children: [
              _ScoreBadge(
                label: 'Score',
                value: '${recentlyAttemptedPaper.percentage.toStringAsFixed(1)}%',
                color: colorScheme.primary,
              ),
              _ScoreBadge(
                label: 'Correct',
                value: '${recentlyAttemptedPaper.correctCount}',
                color: const Color(0xFF10B981),
              ),
              _ScoreBadge(
                label: 'Incorrect',
                value: '${recentlyAttemptedPaper.incorrectCount}',
                color: const Color(0xFFEF4444),
              ),
              if (recentlyAttemptedPaper.partiallyCorrectCount > 0)
                _ScoreBadge(
                  label: 'Partial',
                  value: '${recentlyAttemptedPaper.partiallyCorrectCount}',
                  color: const Color(0xFFFBBF24),
                ),
              _ScoreBadge(
                label: 'Skipped',
                value: '${recentlyAttemptedPaper.skippedCount}',
                color: const Color(0xFF6B7280),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ScoreBadge extends StatelessWidget {
  const _ScoreBadge({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: isDark ? 0.12 : 0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$label: ',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
