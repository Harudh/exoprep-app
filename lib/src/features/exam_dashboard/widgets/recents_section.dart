part of '../exam_dashboard_view.dart';

class RecentsSection extends StatelessWidget {
  final ExamDashboardViewModel viewModel;

  const RecentsSection({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ViewModelState<dynamic>>(
      valueListenable: viewModel.recentsState,
      builder: (context, state, child) {
        return SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: ExamDashboardView.horizontalPadding),
                child: Text(
                  "Recently completed",
                  style: context.titleMedium!.copyWith(fontWeight: FontWeight.w700, letterSpacing: -0.5),
                ),
              ),
              const SizedBox(height: 12),
              if (state.status == ViewModelStatus.loading)
                _RecentsLoadingWidget()
              else if (state.status == ViewModelStatus.error)
                _RecentsErrorWidget(
                  error: state.error ?? 'Unknown error',
                  onRetry: () {},
                  // onRetry: () => viewModel.refreshRecentlyCompleted('exam_id'),
                )
              else
                _RecentsListWidget(),
            ],
          ),
        );
      },
    );
  }
}

class _RecentsListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: ExamDashboardView.horizontalPadding),
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (context, index) =>
            _RecentTestCard(testName: 'Mock Test ${index + 1}', score: 85 - index * 5, daysAgo: index + 1),
      ),
    );
  }
}

class _RecentTestCard extends StatelessWidget {
  final String testName;
  final int score;
  final int daysAgo;

  const _RecentTestCard({required this.testName, required this.score, required this.daysAgo});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.isDarkMode ? Colors.grey.shade900 : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.isDarkMode ? Colors.grey.shade800 : Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(testName, style: context.bodyLarge!.copyWith(fontWeight: FontWeight.w600, letterSpacing: -0.3)),
          const SizedBox(height: 4),
          Text(
            'Score: $score%',
            style: context.bodySmall!.copyWith(color: Colors.green, fontSize: 12, fontWeight: FontWeight.w600),
          ),
          const Spacer(),
          Text('$daysAgo days ago', style: context.bodySmall!.copyWith(color: Colors.grey.shade600, fontSize: 10)),
        ],
      ),
    );
  }
}

class _RecentsLoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: ExamDashboardView.horizontalPadding),
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (context, index) => Container(
          width: 180,
          margin: const EdgeInsets.only(right: 12),
          decoration: BoxDecoration(
            color: context.isDarkMode ? Colors.grey.shade900 : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: context.isDarkMode ? Colors.grey.shade800 : Colors.grey.shade300),
          ),
          child: const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}

class _RecentsErrorWidget extends StatelessWidget {
  final String error;
  final VoidCallback onRetry;

  const _RecentsErrorWidget({required this.error, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: ExamDashboardView.horizontalPadding),
      padding: const EdgeInsets.all(16),
      height: 110,
      decoration: BoxDecoration(
        color: context.isDarkMode ? Colors.grey.shade900 : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.red.shade300),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, color: Colors.red.shade400),
          const SizedBox(width: 12),
          Expanded(
            child: Text('Failed to load recent tests', style: context.bodySmall!.copyWith(color: Colors.red.shade400)),
          ),
          IconButton(icon: const Icon(Icons.refresh), onPressed: onRetry),
        ],
      ),
    );
  }
}
