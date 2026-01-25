part of '../recently_attempted_paper_view.dart';

class _PaperHeaderCard extends StatelessWidget {
  const _PaperHeaderCard({required this.paper, required this.mixin});

  final RecentlyAttemptedPaper paper;
  final RecentlyAttemptedPaperMixin mixin;

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
          Text(paper.paper.name, style: context.titleLarge?.copyWith(fontWeight: FontWeight.w700, letterSpacing: -0.5)),
          if (paper.paper.description.isNotEmpty) ...[
            const SizedBox(height: 6),
            Text(paper.paper.description, style: context.bodySmall?.copyWith(color: Colors.grey.shade600, fontSize: 13)),
          ],
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: _InfoChip(icon: Icons.calendar_today_outlined, label: mixin.formatDate(paper.attemptedAt)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _InfoChip(icon: Icons.timer_outlined, label: mixin.formatDuration(paper.timeTaken)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
