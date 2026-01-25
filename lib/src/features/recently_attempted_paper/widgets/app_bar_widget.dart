part of '../recently_attempted_paper_view.dart';

class _AppBarWidget extends StatelessWidget {
  const _AppBarWidget();

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(20, 64, 20, 0),
      sliver: SliverToBoxAdapter(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                height: 44,
                width: 44,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isDark ? Colors.grey.shade800 : Colors.grey.shade100,
                  border: Border.all(color: isDark ? Colors.grey.shade700 : Colors.grey.shade300),
                ),
                child: const Icon(Icons.arrow_back, size: 22),
              ),
            ),
            Text(
              'Paper Analytics',
              style: context.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800, letterSpacing: -0.5),
            ),
            const SizedBox(width: 44),
          ],
        ),
      ),
    );
  }
}
