part of '../exam_dashboard_view.dart';

class ContinueSection extends StatelessWidget {
  final ExamDashboardViewModel viewModel;

  const ContinueSection({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ViewModelState<dynamic>>(
      valueListenable: viewModel.continueState,
      builder: (context, state, child) {
        return SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: ExamDashboardView.horizontalPadding),
                child: Text(
                  "Continue where you left",
                  style: context.titleMedium!.copyWith(fontWeight: FontWeight.w700, letterSpacing: -0.5),
                ),
              ),
              const SizedBox(height: 12),
              if (state.status == ViewModelStatus.loading)
                _ContinueLoadingWidget()
              else if (state.status == ViewModelStatus.error)
                _ContinueErrorWidget(
                  error: state.error ?? 'Unknown error',
                  // onRetry: () => viewModel.refreshContinueProgress('exam_id'),
                  onRetry: () {},
                )
              else
                _ContinueContentWidget(subject: 'Physics: Thermodynamics', progress: 'Question 12 of 50'),
            ],
          ),
        );
      },
    );
  }
}

class _ContinueContentWidget extends StatelessWidget {
  final String subject;
  final String progress;

  const _ContinueContentWidget({required this.subject, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: ExamDashboardView.horizontalPadding),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.isDarkMode ? Colors.grey.shade900 : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.isDarkMode ? Colors.grey.shade800 : Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(subject, style: context.bodyLarge!.copyWith(fontWeight: FontWeight.w600, letterSpacing: -0.3)),
                const SizedBox(height: 4),
                Text(progress, style: context.bodySmall!.copyWith(color: Colors.grey.shade600, fontSize: 12)),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: Colors.grey.shade400),
        ],
      ),
    );
  }
}

class _ContinueLoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: ExamDashboardView.horizontalPadding),
      padding: const EdgeInsets.all(16),
      height: 80,
      decoration: BoxDecoration(
        color: context.isDarkMode ? Colors.grey.shade900 : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.isDarkMode ? Colors.grey.shade800 : Colors.grey.shade300),
      ),
      child: const Center(child: CircularProgressIndicator()),
    );
  }
}

class _ContinueErrorWidget extends StatelessWidget {
  final String error;
  final VoidCallback onRetry;

  const _ContinueErrorWidget({required this.error, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: ExamDashboardView.horizontalPadding),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.isDarkMode ? Colors.grey.shade900 : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.red.shade300),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline, color: Colors.red.shade400, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text('Failed to load progress', style: context.bodySmall!.copyWith(color: Colors.red.shade400)),
          ),
          IconButton(icon: const Icon(Icons.refresh, size: 20), onPressed: onRetry),
        ],
      ),
    );
  }
}
