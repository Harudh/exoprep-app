part of '../exam_dashboard_view.dart';

class RecentsSection extends StatelessWidget {
  final ExamDashboardViewModel viewModel;

  const RecentsSection({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ViewModelState>(
      valueListenable: viewModel.recentsState,
      builder: (context, state, child) {
        final attempts = state.data ?? [];
        return SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: ExamDashboardView.horizontalPadding),
                child: Row(
                  children: [
                    Text("Recently completed", style: context.titleMedium!.copyWith(fontWeight: FontWeight.w800)),
                    const SizedBox(width: 8),
                    const Spacer(),
                    if (state.status == ViewModelStatus.success && (state.data?.length ?? 0) > 5)
                      InkWell(
                        onTap: () {
                          //TODO: View Attempted Papers History
                        },
                        borderRadius: BorderRadius.circular(8),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            children: [
                              Text("View History", style: context.bodySmall!.copyWith(fontWeight: FontWeight.bold)),
                              const Icon(Icons.chevron_right_rounded, size: 16),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              if (state.status == ViewModelStatus.loading)
                const _RecentsLoadingWidget()
              else if (state.status == ViewModelStatus.error)
                _RecentsErrorWidget(
                  error: state.error ?? 'Unknown error',
                  onRetry: () => viewModel.refreshRecentlyCompleted(viewModel.examID),
                )
              else if (attempts.isEmpty)
                const _NoRecentDataWidget()
              else
                _RecentsListWidget(attempts: attempts),
            ],
          ),
        );
      },
    );
  }
}

class _RecentsListWidget extends StatelessWidget {
  final List<AttemptedPaper> attempts;

  const _RecentsListWidget({required this.attempts});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: ExamDashboardView.horizontalPadding),
        scrollDirection: Axis.horizontal,
        itemCount: attempts.length,
        itemBuilder: (context, index) {
          final attempt = attempts[index];
          return _RecentTestCard(attempt: attempt);
        },
      ),
    );
  }
}

class _RecentTestCard extends StatelessWidget {
  final AttemptedPaper attempt;

  const _RecentTestCard({required this.attempt});

  String _getTimeAgo(DateTime dateTime) {
    final difference = DateTime.now().difference(dateTime.toLocal());

    if (difference.inSeconds < 60) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} min${difference.inMinutes > 1 ? 's' : ''} ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    } else {
      return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    }
  }

  @override
  Widget build(BuildContext context) {
    final timeDisplay = _getTimeAgo(attempt.completedAt);

    return GestureDetector(
      onTap: () => context.push(AppRoute.recentlyAttemptedPaper.path, extra: {
        'attempted_paper_id': attempt.id,
        'paper_id': attempt.paper.id,
      }),
      child: Container(
        width: 200,
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
            Text(
              attempt.paper.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.bodyLarge!.copyWith(fontWeight: FontWeight.w600, letterSpacing: -0.3),
            ),
            const SizedBox(height: 4),
            Text(
              'Score: ${attempt.percentage.toStringAsFixed(1)}%',
              style: context.bodySmall!.copyWith(
                color: attempt.percentage >= 50 ? Colors.green : Colors.orange,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(timeDisplay, style: context.bodySmall!.copyWith(color: Colors.grey.shade600, fontSize: 10)),
                Text('${attempt.score} pts', style: context.bodySmall!.copyWith(color: Colors.grey.shade600, fontSize: 10)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _NoRecentDataWidget extends StatelessWidget {
  const _NoRecentDataWidget();
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: ExamDashboardView.horizontalPadding),
      child: Text("No papers attempted yet."),
    );
  }
}

class _RecentsLoadingWidget extends StatefulWidget {
  const _RecentsLoadingWidget();

  @override
  State<_RecentsLoadingWidget> createState() => _RecentsLoadingWidgetState();
}

class _RecentsLoadingWidgetState extends State<_RecentsLoadingWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500))..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return SizedBox(
      height: 120,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: ExamDashboardView.horizontalPadding),
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 3,
        itemBuilder: (context, index) {
          return AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Container(
                width: 210,
                margin: const EdgeInsets.only(right: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey.shade900 : Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: isDark ? Colors.grey.shade800 : Colors.grey.shade200),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.0, _controller.value, 1.0],
                    colors: isDark
                        ? [Colors.transparent, Colors.white.withValues(alpha: 0.05), Colors.transparent]
                        : [Colors.transparent, Colors.white.withValues(alpha: 0.1), Colors.transparent],
                  ),
                ),
                child: child,
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title Skeleton
                _skeletonBlock(width: 130, height: 16, isDark: isDark),
                const SizedBox(height: 8),
                // Score Skeleton
                _skeletonBlock(width: 70, height: 12, isDark: isDark),
                const Spacer(),
                // Footer Row Skeleton
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _skeletonBlock(width: 50, height: 10, isDark: isDark),
                    _skeletonBlock(width: 35, height: 10, isDark: isDark),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _skeletonBlock({required double width, required double height, required bool isDark}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(4),
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
    final bool isDark = context.isDarkMode;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: ExamDashboardView.horizontalPadding),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
        border: Border.all(color: isDark ? Colors.white10 : Colors.grey.shade200),
      ),
      child: Row(
        children: [
          // Visual Indicator
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.red.withValues(alpha: 0.1), shape: BoxShape.circle),
            child: const Icon(Icons.cloud_off_rounded, color: Colors.redAccent, size: 24),
          ),
          const SizedBox(width: 16),
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Something went wrong", style: context.bodySmall!.copyWith(fontWeight: FontWeight.bold)),
                Text("Please try again", style: context.bodySmall!.copyWith(color: Colors.grey)),
              ],
            ),
          ),
          // Action
          ElevatedButton(
            onPressed: onRetry,
            style: ElevatedButton.styleFrom(
              backgroundColor: isDark ? Colors.white : Colors.black,
              foregroundColor: isDark ? Colors.black : Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              elevation: 0,
            ),
            child: const Text("Retry"),
          ),
        ],
      ),
    );
  }
}
