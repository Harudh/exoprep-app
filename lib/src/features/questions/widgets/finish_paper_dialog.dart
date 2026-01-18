part of '../questions_view.dart';

class FinishPaperDialog extends StatelessWidget {
  const FinishPaperDialog({
    super.key,
    required this.totalQuestions,
    required this.attemptedCount,
    required this.unattemptedCount,
  });

  final int totalQuestions;
  final int attemptedCount;
  final int unattemptedCount;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final colorScheme = context.colorScheme;

    return AlertDialog(
      backgroundColor: isDark ? const Color(0xFF1A1A1A) : Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Row(
        children: [
          Icon(Icons.warning_amber_rounded, color: colorScheme.primary, size: 28),
          const SizedBox(width: 12),
          Text(
            'Submit Test?',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: isDark ? const Color(0xFFE5E5E5) : const Color(0xFF1F2937),
            ),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Are you sure you want to submit the test? You won\'t be able to change your answers after submission.',
            style: TextStyle(fontSize: 14, height: 1.5, color: isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280)),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF2A2A2A) : const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                _StatRow(label: 'Total Questions', value: '$totalQuestions', isDark: isDark),
                const SizedBox(height: 8),
                _StatRow(label: 'Attempted', value: '$attemptedCount', valueColor: colorScheme.primary, isDark: isDark),
                const SizedBox(height: 8),
                _StatRow(
                  label: 'Unattempted',
                  value: '$unattemptedCount',
                  valueColor: unattemptedCount > 0 ? (isDark ? const Color(0xFFF59E0B) : const Color(0xFFD97706)) : null,
                  isDark: isDark,
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(
            'Cancel',
            style: TextStyle(color: isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280), fontWeight: FontWeight.w600),
          ),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(true),
          style: FilledButton.styleFrom(
            backgroundColor: colorScheme.primary,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
          child: const Text('Submit', style: TextStyle(fontWeight: FontWeight.w600)),
        ),
      ],
    );
  }
}

class _StatRow extends StatelessWidget {
  const _StatRow({required this.label, required this.value, required this.isDark, this.valueColor});

  final String label;
  final String value;
  final bool isDark;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 14, color: isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280))),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: valueColor ?? (isDark ? const Color(0xFFE5E5E5) : const Color(0xFF1F2937)),
          ),
        ),
      ],
    );
  }
}
