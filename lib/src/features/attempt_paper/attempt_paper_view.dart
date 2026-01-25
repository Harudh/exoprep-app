import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:root/src/core/theme/colors.dart';
import 'package:root/src/core/logger/logger.dart';
import 'package:root/src/core/navigation/routes.dart';
import 'package:root/src/models/paper_model/paper_model.dart';
import 'package:root/src/core/extensions/context_extension.dart';
import 'package:root/src/core/common/state/viewmodel_state.dart';
import 'package:root/src/models/subject_model/subject_model.dart';
import 'package:root/src/models/question_model/question_model.dart';
import 'package:root/src/models/paper_model/paper_details_model.dart';
import 'package:root/src/features/attempt_paper/attempt_paper_viewmodel.dart';

part 'attempt_paper_mixin.dart';

class AttemptPaperView extends StatefulWidget {
  const AttemptPaperView({required this.paper, super.key});

  final Paper paper;

  @override
  State<AttemptPaperView> createState() => _AttemptPaperViewState();
}

class _AttemptPaperViewState extends State<AttemptPaperView> with AttemptPaperMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder<ViewModelState<String>>(
        valueListenable: viewModel.dataState,
        builder: (context, state, child) {
          if (state.status == ViewModelStatus.loading) {
            return const _LoadingView();
          }

          if (state.status == ViewModelStatus.error) {
            return _ErrorView(message: 'Failed to load test data', onRetry: onRefresh);
          }

          if (state.status == ViewModelStatus.success) {
            return ValueListenableBuilder<PaperDetail?>(
              valueListenable: viewModel.paperDetails,
              builder: (context, paperDetail, _) {
                return _LoadedView(
                  paper: widget.paper,
                  paperDetail: paperDetail,
                  subjects: viewModel.subjectsData.value,
                  questions: viewModel.questionsData.value,
                );
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _LoadingView extends StatefulWidget {
  const _LoadingView();

  @override
  State<_LoadingView> createState() => _LoadingViewState();
}

class _LoadingViewState extends State<_LoadingView> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              // App Bar Shimmer
              SliverAppBar(
                backgroundColor: Colors.transparent,
                expandedHeight: 120,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: _skeletonBlock(
                    width: 120,
                    height: 18,
                    isDark: isDark,
                    borderRadius: 4,
                  ),
                  centerTitle: true,
                  titlePadding: const EdgeInsets.only(bottom: 16),
                ),
              ),

              // Content Shimmer
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Header Card Shimmer
                      _buildShimmerCard(
                        isDark: isDark,
                        padding: const EdgeInsets.only(left: 20, right: 30, top: 18, bottom: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _skeletonBlock(width: 200, height: 24, isDark: isDark),
                            const SizedBox(height: 8),
                            _skeletonBlock(width: 250, height: 14, isDark: isDark),
                            const SizedBox(height: 16),
                            ...[
                              _buildDetailRowShimmer(isDark: isDark),
                              const SizedBox(height: 8),
                              _buildDetailRowShimmer(isDark: isDark),
                              const SizedBox(height: 8),
                              _buildDetailRowShimmer(isDark: isDark),
                              const SizedBox(height: 8),
                              _buildDetailRowShimmer(isDark: isDark),
                              const SizedBox(height: 8),
                              _buildDetailRowShimmer(isDark: isDark),
                            ],
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Section Title Shimmer
                      _skeletonBlock(width: 160, height: 20, isDark: isDark),
                      const SizedBox(height: 16),

                      // Instruction Cards Shimmer
                      ...[
                        _buildInstructionCardShimmer(isDark: isDark),
                        const SizedBox(height: 12),
                        _buildInstructionCardShimmer(isDark: isDark),
                        const SizedBox(height: 12),
                        _buildInstructionCardShimmer(isDark: isDark),
                        const SizedBox(height: 12),
                        _buildInstructionCardShimmer(isDark: isDark),
                      ],

                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Floating Button Shimmer
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, _) {
                return Container(
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: [0.0, _controller.value, 1.0],
                      colors: isDark
                          ? [
                        Colors.grey.shade800,
                        Colors.grey.shade700,
                        Colors.grey.shade800,
                      ]
                          : [
                        Colors.grey.shade300,
                        Colors.grey.shade200,
                        Colors.grey.shade300,
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerCard({
    required bool isDark,
    required Widget child,
    EdgeInsets padding = const EdgeInsets.all(16),
  }) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return Container(
          padding: padding,
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1A1A1A) : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isDark ? const Color(0xFF2A2A2A) : const Color(0xFFE5E7EB),
            ),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.0, _controller.value, 1.0],
              colors: isDark
                  ? [
                Colors.transparent,
                Colors.white.withValues(alpha: 0.03),
                Colors.transparent,
              ]
                  : [
                Colors.transparent,
                Colors.white.withValues(alpha: 0.1),
                Colors.transparent,
              ],
            ),
          ),
          child: child,
        );
      },
    );
  }

  Widget _buildDetailRowShimmer({required bool isDark}) {
    return Row(
      children: [
        _skeletonBlock(width: 20, height: 20, isDark: isDark, borderRadius: 4),
        const SizedBox(width: 12),
        Expanded(
          child: _skeletonBlock(width: double.infinity, height: 14, isDark: isDark),
        ),
        const SizedBox(width: 12),
        _skeletonBlock(width: 60, height: 14, isDark: isDark),
      ],
    );
  }

  Widget _buildInstructionCardShimmer({required bool isDark}) {
    return _buildShimmerCard(
      isDark: isDark,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const SizedBox(width: 12),
              _skeletonBlock(width: 140, height: 16, isDark: isDark),
            ],
          ),
          const SizedBox(height: 12),
          ...[
            _buildBulletPointShimmer(isDark: isDark),
            const SizedBox(height: 8),
            _buildBulletPointShimmer(isDark: isDark),
            const SizedBox(height: 8),
            _buildBulletPointShimmer(isDark: isDark),
          ],
        ],
      ),
    );
  }

  Widget _buildBulletPointShimmer({required bool isDark}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 6),
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _skeletonBlock(width: double.infinity, height: 14, isDark: isDark),
        ),
      ],
    );
  }

  Widget _skeletonBlock({
    required double width,
    required double height,
    required bool isDark,
    double borderRadius = 4,
  }) {
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

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return Scaffold(
      appBar: AppBar(title: const Text('Test Overview'), centerTitle: true),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 64, color: Colors.red.withValues(alpha: 0.7)),
              const SizedBox(height: 16),
              Text(
                '${message} ?? Failed to load test',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: isDark ? Colors.white : const Color(0xFF1F2937),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280)),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoadedView extends StatelessWidget {
  final Paper paper;
  final PaperDetail? paperDetail;
  final List<Subject> subjects;
  final List<Question> questions;

  const _LoadedView({required this.paper, required this.paperDetail, required this.subjects, required this.questions});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              // Sliver App Bar with Paper Name
              SliverAppBar(
                backgroundColor: Colors.transparent,
                expandedHeight: 120,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    'Test Overview',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white : const Color(0xFF1F2937),
                    ),
                  ),
                  centerTitle: true,
                  titlePadding: const EdgeInsets.only(bottom: 16),
                ),
              ),

              // Content
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Warning if detail fetch failed
                      if (paperDetail == null)
                        Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.orange.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.orange.withValues(alpha: 0.3)),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.info_outline, color: Colors.orange, size: 20),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  'Detailed marking information unavailable',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: isDark ? const Color(0xFFE5E5E5) : const Color(0xFF1F2937),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                      // Header Card
                      Container(
                        padding: const EdgeInsets.only(left: 20, right: 30, top: 18, bottom: 24),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppColors.primaryColor.withValues(alpha: 0.1),
                              AppColors.primaryColor.withValues(alpha: 0.05),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColors.primaryColor.withValues(alpha: 0.3), width: 1.5),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              paperDetail?.name ?? paper.name,
                              style: context.titleLarge!.copyWith(
                                fontWeight: FontWeight.bold,
                                color: isDark ? Colors.white : const Color(0xFF1F2937),
                              ),
                            ),
                            if ((paperDetail?.description ?? paper.description).isNotEmpty) ...[
                              const SizedBox(height: 4),
                              Text(
                                paperDetail?.description ?? paper.description,
                                style: TextStyle(fontSize: 14, color: isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280)),
                              ),
                            ],
                            const SizedBox(height: 16),
                            _TestDetailRow(
                              icon: Icons.article_outlined,
                              label: 'Total Questions',
                              value: (paperDetail?.totalQuestions ?? questions.length).toString(),
                            ),
                            const SizedBox(height: 8),
                            _TestDetailRow(
                              icon: Icons.timer_outlined,
                              label: 'Duration',
                              value: '${paperDetail?.duration ?? paper.durationInMinutes} minutes',
                            ),
                            if (subjects.isNotEmpty) ...[
                              const SizedBox(height: 8),
                              _TestDetailRow(icon: Icons.book_outlined, label: 'Subjects', value: subjects.length.toString()),
                            ],
                            if (paperDetail != null) ...[
                              const SizedBox(height: 8),
                              _TestDetailRow(
                                icon: Icons.add_circle_outline,
                                label: 'Marks per Correct',
                                value: '+${paperDetail!.positiveMarks}',
                              ),
                              const SizedBox(height: 8),
                              _TestDetailRow(
                                icon: Icons.remove_circle_outline,
                                label: 'Negative Marks',
                                value: '-${paperDetail!.negativeMarks}',
                              ),
                            ],
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      // General Instructions
                      Text(
                        'General Instructions',
                        style: context.titleMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : const Color(0xFF1F2937),
                        ),
                      ),
                      const SizedBox(height: 16),

                      _InstructionCard(
                        icon: Icons.laptop_chromebook,
                        title: 'Technical Requirements',
                        instructions: ['Ensure stable internet connection', 'Close unnecessary apps', 'Keep device charged'],
                      ),
                      const SizedBox(height: 12),

                      _InstructionCard(
                        icon: Icons.rule_outlined,
                        title: 'Test Rules',
                        instructions: [
                          'Navigate between questions freely',
                          'Mark questions for review later',
                          'Submit before time runs out',
                        ],
                      ),
                      const SizedBox(height: 12),

                      if (paperDetail != null) ...[
                        _InstructionCard(
                          icon: Icons.grade_outlined,
                          title: 'Marking Scheme',
                          instructions: [
                            'Correct: +${paperDetail!.positiveMarks} marks',
                            'Incorrect: -${paperDetail!.negativeMarks} mark',
                            'Unattempted: No penalty',
                          ],
                        ),
                        const SizedBox(height: 12),
                      ],

                      _InstructionCard(
                        icon: Icons.tips_and_updates_outlined,
                        title: 'Important Tips',
                        instructions: ['Read questions carefully', 'Manage time wisely', 'Review marked questions'],
                      ),

                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Floating Button
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: GestureDetector(
              onTap: () => context.pushReplacement(
                AppRoute.questions.path,
                extra: {'paper': paper, 'subjects': subjects, 'questions': questions},
              ),
              child: Container(
                height: 56,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(color: AppColors.primaryColor.withValues(alpha: 0.3), blurRadius: 12, offset: const Offset(0, 4)),
                  ],
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Start Test',
                        style: context.titleMedium!.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.arrow_forward, color: Colors.white, size: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TestDetailRow extends StatelessWidget {
  const _TestDetailRow({required this.icon, required this.label, required this.value});

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return Row(
      children: [
        Icon(icon, size: 20, color: AppColors.primaryColor),
        const SizedBox(width: 12),
        Expanded(
          child: Text(label, style: TextStyle(fontSize: 14, color: isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280))),
        ),
        Text(
          value,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: isDark ? Colors.white : const Color(0xFF1F2937)),
        ),
      ],
    );
  }
}

class _InstructionCard extends StatelessWidget {
  const _InstructionCard({required this.icon, required this.title, required this.instructions});

  final IconData icon;
  final String title;
  final List<String> instructions;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A1A1A) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isDark ? const Color(0xFF2A2A2A) : const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, size: 20, color: AppColors.primaryColor),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white : const Color(0xFF1F2937),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...instructions.map((instruction) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 6),
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(color: AppColors.primaryColor, shape: BoxShape.circle),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      instruction,
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.5,
                        color: isDark ? const Color(0xFFD1D5DB) : const Color(0xFF4B5563),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
