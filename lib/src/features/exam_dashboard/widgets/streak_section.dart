part of '../exam_dashboard_view.dart';

class StreakSection extends StatelessWidget {
  final ExamDashboardViewModel viewModel;

  const StreakSection({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: ValueListenableBuilder<ViewModelState<dynamic>>(
        valueListenable: viewModel.streakState,
        builder: (context, state, child) {
          if (state.status == ViewModelStatus.loading) {
            return _StreakLoadingWidget();
          }

          if (state.status == ViewModelStatus.error) {
            return _StreakErrorWidget(
              error: state.error ?? 'Unknown error',
              onRetry: () {},
              // onRetry: () => viewModel.refreshStreakData('exam_id'),
            );
          }

          return _StreakContentWidget(dayStreak: 15, totalPoints: 450);
        },
      ),
    );
  }
}

class _StreakContentWidget extends StatelessWidget {
  final int dayStreak;
  final int totalPoints;

  const _StreakContentWidget({required this.dayStreak, required this.totalPoints});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: ExamDashboardView.horizontalPadding),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.isDarkMode ? Colors.grey.shade900 : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.isDarkMode ? Colors.grey.shade800 : Colors.grey.shade300),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _StreakItem(
            icon: Icons.local_fire_department,
            iconColor: Colors.orange,
            value: dayStreak.toString(),
            label: 'Day Streak',
          ),
          Container(width: 1, height: 50, color: context.isDarkMode ? Colors.grey.shade800 : Colors.grey.shade300),
          _StreakItem(icon: Icons.stars, iconColor: Colors.amber, value: totalPoints.toString(), label: 'Total Points'),
        ],
      ),
    );
  }
}

class _StreakItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String value;
  final String label;

  const _StreakItem({required this.icon, required this.iconColor, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: iconColor, size: 36),
        const SizedBox(height: 8),
        Text(value, style: context.headlineSmall!.copyWith(fontWeight: FontWeight.w800, letterSpacing: -0.5)),
        Text(label, style: context.bodySmall!.copyWith(color: Colors.grey.shade600, fontSize: 12)),
      ],
    );
  }
}

class _StreakLoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: ExamDashboardView.horizontalPadding),
      padding: const EdgeInsets.all(20),
      height: 120,
      decoration: BoxDecoration(
        color: context.isDarkMode ? Colors.grey.shade900 : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.isDarkMode ? Colors.grey.shade800 : Colors.grey.shade300),
      ),
      child: const Center(child: CircularProgressIndicator()),
    );
  }
}

class _StreakErrorWidget extends StatelessWidget {
  final String error;
  final VoidCallback onRetry;

  const _StreakErrorWidget({required this.error, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: ExamDashboardView.horizontalPadding),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.isDarkMode ? Colors.grey.shade900 : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.red.shade300),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline, color: Colors.red.shade400),
          const SizedBox(width: 12),
          Expanded(
            child: Text('Failed to load streak data', style: context.bodyMedium!.copyWith(color: Colors.red.shade400)),
          ),
          IconButton(icon: const Icon(Icons.refresh), onPressed: onRetry),
        ],
      ),
    );
  }
}
