import 'package:root/src/features/recently_attempted_paper/recently_attempted_paper_viewmodel.dart';
import 'package:root/src/models/paper_model/recently_attempted_paper_model.dart';
import 'package:root/src/core/common/ui/widgets/background_gradient.dart';
import 'package:root/src/core/extensions/context_extension.dart';
import 'package:root/src/core/common/state/viewmodel_state.dart';
import 'package:root/src/core/navigation/routes.dart';
import 'package:root/src/core/theme/colors.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

part 'widgets/performance_breakdown_card.dart';

part 'widgets/topic_performance_tile.dart';

part 'recently_attempted_paper_mixin.dart';

part 'widgets/score_card_summary.dart';

part 'widgets/topic_insight_card.dart';

part 'widgets/paper_header_card.dart';

part 'widgets/app_bar_widget.dart';

part 'widgets/stats_tile.dart';

part 'widgets/info_chip.dart';

class RecentlyAttemptedPaperView extends StatefulWidget {
  const RecentlyAttemptedPaperView({required this.recentlyAttemptedPaperId, required this.paperId, super.key});

  final String recentlyAttemptedPaperId;
  final String paperId;

  @override
  State<RecentlyAttemptedPaperView> createState() => _RecentlyAttemptedPaperViewState();
}

class _RecentlyAttemptedPaperViewState extends State<RecentlyAttemptedPaperView> with RecentlyAttemptedPaperMixin {
  static const double horizontalPadding = 12.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundGradient(
        child: ValueListenableBuilder<ViewModelState>(
          valueListenable: viewModel.paperState,
          builder: (context, state, _) {
            if (state.status == ViewModelStatus.loading) {
              return const _PaperAnalyticsLoadingWidget();
            }

            if (state.status == ViewModelStatus.error) {
              return CustomScrollView(
                slivers: [
                  _AppBarWidget(),
                  SliverFillRemaining(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.error_outline_rounded, size: 48, color: Colors.grey.shade400),
                            const SizedBox(height: 16),
                            Text(
                              state.error ?? 'Failed to load data',
                              style: context.textTheme.bodyMedium?.copyWith(color: Colors.grey.shade600),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 24),
                            OutlinedButton.icon(
                              onPressed: () => viewModel.fetchAllData(
                                attemptedPaperId: widget.recentlyAttemptedPaperId,
                                paperId: widget.paperId,
                              ),
                              icon: const Icon(Icons.refresh_rounded, size: 18),
                              label: const Text('Retry'),
                              style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }

            if (state.status == ViewModelStatus.success && state.data is RecentlyAttemptedPaper) {
              final paper = state.data as RecentlyAttemptedPaper;

              return CustomScrollView(
                slivers: [
                  _AppBarWidget(),
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(horizontalPadding, 24, horizontalPadding, 20),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        _PaperHeaderCard(paper: paper, mixin: this),
                        const SizedBox(height: 8),
                        _ScoreSummaryCard(paper: paper),
                        const SizedBox(height: 8),
                        _PerformanceBreakdownCard(paper: paper),
                        if (paper.insights.accuracyByTopic.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          _TopicInsightsCard(insights: paper.insights),
                        ],
                        const SizedBox(height: 16),
                        GestureDetector(
                          onTap: () {
                            context.push(
                              AppRoute.recentlyAttemptedQuestions.path,
                              extra: {'recentlyAttemptedPaper': paper, 'questions': viewModel.questions},
                            );
                          },
                          child: Container(
                            height: 56,
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primaryColor.withValues(alpha: 0.3),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Review Answers',
                                    style: context.titleMedium!.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(width: 8),
                                  const Icon(Icons.arrow_forward, color: Colors.white, size: 20),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ]),
                    ),
                  ),
                ],
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class _PaperAnalyticsLoadingWidget extends StatefulWidget {
  const _PaperAnalyticsLoadingWidget();

  @override
  State<_PaperAnalyticsLoadingWidget> createState() => _PaperAnalyticsLoadingWidgetState();
}

class _PaperAnalyticsLoadingWidgetState extends State<_PaperAnalyticsLoadingWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  static const double horizontalPadding = 12.0;

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

    return CustomScrollView(
      slivers: [
        _AppBarWidget(),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(horizontalPadding, 24, horizontalPadding, 20),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              // Paper Header Card Shimmer
              _buildShimmerCard(
                isDark: isDark,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _skeletonBlock(width: 180, height: 18, isDark: isDark),
                    const SizedBox(height: 8),
                    _skeletonBlock(width: 220, height: 12, isDark: isDark),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: _skeletonBlock(width: double.infinity, height: 36, isDark: isDark, borderRadius: 10),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _skeletonBlock(width: double.infinity, height: 36, isDark: isDark, borderRadius: 10),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Score Summary Card Shimmer
              _buildShimmerCard(
                isDark: isDark,
                padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 20),
                child: Column(
                  children: [
                    _skeletonBlock(width: 80, height: 13, isDark: isDark),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        _skeletonBlock(width: 100, height: 56, isDark: isDark),
                        const SizedBox(width: 8),
                        _skeletonBlock(width: 60, height: 32, isDark: isDark),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _skeletonBlock(width: 80, height: 32, isDark: isDark, borderRadius: 20),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Performance Breakdown Card Shimmer
              _buildShimmerCard(
                isDark: isDark,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _skeletonBlock(width: 180, height: 16, isDark: isDark),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(child: _buildStatTileShimmer(isDark: isDark)),
                        const SizedBox(width: 12),
                        Expanded(child: _buildStatTileShimmer(isDark: isDark)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(child: _buildStatTileShimmer(isDark: isDark)),
                        const SizedBox(width: 12),
                        Expanded(child: _buildStatTileShimmer(isDark: isDark)),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _skeletonBlock(width: 60, height: 12, isDark: isDark),
                        _skeletonBlock(width: 40, height: 12, isDark: isDark),
                      ],
                    ),
                    const SizedBox(height: 8),
                    _skeletonBlock(width: double.infinity, height: 6, isDark: isDark, borderRadius: 4),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Topic Insights Card Shimmer
              _buildShimmerCard(
                isDark: isDark,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _skeletonBlock(width: 160, height: 16, isDark: isDark),
                    const SizedBox(height: 8),
                    _skeletonBlock(width: 180, height: 24, isDark: isDark, borderRadius: 8),
                    const SizedBox(height: 20),
                    ...List.generate(
                      3,
                      (index) => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: _buildTopicTileShimmer(isDark: isDark),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Review Button Shimmer
              _skeletonBlock(width: double.infinity, height: 48, isDark: isDark, borderRadius: 12),
              const SizedBox(height: 20),
            ]),
          ),
        ),
      ],
    );
  }

  Widget _buildShimmerCard({required bool isDark, required Widget child, EdgeInsets padding = const EdgeInsets.all(20)}) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return Container(
          padding: padding,
          decoration: BoxDecoration(
            color: isDark ? Colors.grey.shade900 : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: isDark ? Colors.grey.shade800 : Colors.grey.shade200),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.0, _controller.value, 1.0],
              colors: isDark
                  ? [Colors.transparent, Colors.white.withValues(alpha: 0.03), Colors.transparent]
                  : [Colors.transparent, Colors.white.withValues(alpha: 0.1), Colors.transparent],
            ),
          ),
          child: child,
        );
      },
    );
  }

  Widget _buildStatTileShimmer({required bool isDark}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey.shade800.withValues(alpha: 0.3) : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isDark ? Colors.grey.shade800 : Colors.grey.shade200),
      ),
      child: Column(
        children: [
          _skeletonBlock(width: 40, height: 32, isDark: isDark),
          const SizedBox(height: 4),
          _skeletonBlock(width: 50, height: 11, isDark: isDark),
        ],
      ),
    );
  }

  Widget _buildTopicTileShimmer({required bool isDark}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _skeletonBlock(width: 120, height: 13, isDark: isDark),
            _skeletonBlock(width: 80, height: 24, isDark: isDark, borderRadius: 8),
          ],
        ),
        const SizedBox(height: 10),
        _skeletonBlock(width: double.infinity, height: 6, isDark: isDark, borderRadius: 4),
      ],
    );
  }

  Widget _skeletonBlock({required double width, required double height, required bool isDark, double borderRadius = 4}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }
}
