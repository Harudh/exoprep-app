part of '../recently_attempted_questions_view.dart';

class _AnswerStatusIndicator extends StatelessWidget {
  const _AnswerStatusIndicator({required this.response});

  final QuestionResponse response;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Color color;
    IconData icon;
    String label;

    // Check response status
    switch (response.isCorrect) {
      case 'YES':
        color = const Color(0xFF10B981);
        icon = Icons.check_circle;
        label = 'Correct';
        break;
      case 'PARTIAL':
        color = const Color(0xFFFBBF24);
        icon = Icons.adjust;
        label = 'Partial';
        break;
      case 'NO':
        color = const Color(0xFFEF4444);
        icon = Icons.cancel;
        label = 'Incorrect';
        break;
      default:
      // Skipped or not attempted
        color = isDark ? const Color(0xFF6B7280) : const Color(0xFF9CA3AF);
        icon = Icons.remove_circle_outline;
        label = 'Skipped';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: isDark ? 0.12 : 0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
