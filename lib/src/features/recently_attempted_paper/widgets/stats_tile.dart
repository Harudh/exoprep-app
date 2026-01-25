part of '../recently_attempted_paper_view.dart';

class _StatTile extends StatelessWidget {
  const _StatTile({required this.label, required this.value, required this.color});

  final String label;
  final int value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey.shade800.withValues(alpha: 0.3) : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isDark ? Colors.grey.shade800 : Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Text(
            value.toString(),
            style: context.headlineMedium?.copyWith(fontWeight: FontWeight.w800, color: color, letterSpacing: -1),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: context.bodySmall?.copyWith(fontWeight: FontWeight.w600, color: Colors.grey.shade600, fontSize: 11),
          ),
        ],
      ),
    );
  }
}
