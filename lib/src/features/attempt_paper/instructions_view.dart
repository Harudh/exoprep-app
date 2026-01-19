import 'package:root/src/features/attempt_paper/attempt_paper_viewmodel.dart';
import 'package:root/src/models/paper_model/paper_details_model.dart';
import 'package:root/src/core/common/state/viewmodel_state.dart';
import 'package:root/src/core/extensions/context_extension.dart';
import 'package:root/src/models/paper_model/paper_model.dart';
import 'package:root/src/core/navigation/routes.dart';
import 'package:root/src/core/theme/colors.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

class InstructionsView extends StatefulWidget {
  const InstructionsView({required this.paper, super.key});

  final Paper paper;

  @override
  State<InstructionsView> createState() => _InstructionsViewState();
}

class _InstructionsViewState extends State<InstructionsView> {
  late AttemptPaperViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = AttemptPaperViewModel();
    viewModel.fetchPaperDetails(widget.paper.id);
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0F0F0F) : const Color(0xFFF9FAFB),
      appBar: AppBar(title: const Text('Test Instructions'), centerTitle: true, elevation: 0),
      body: ValueListenableBuilder<ViewModelState<String>>(
        valueListenable: viewModel.paperDetailsState,
        builder: (context, state, _) {
          // Show loading state
          if (state.status == ViewModelStatus.loading) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: AppColors.primaryColor),
                  const SizedBox(height: 16),
                  Text(
                    'Loading paper details...',
                    style: TextStyle(fontSize: 14, color: isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280)),
                  ),
                ],
              ),
            );
          }

          // Show content (with or without detailed data)
          return ValueListenableBuilder<PaperDetail?>(
            valueListenable: viewModel.paperDetails,
            builder: (context, paperDetail, _) {
              final hasError = state.status == ViewModelStatus.error;
              return _buildContent(context, isDark, paperDetail, hasError: hasError);
            },
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _buildFloatingButton(context, isDark),
    );
  }

  Widget _buildContent(BuildContext context, bool isDark, PaperDetail? paperDetail, {bool hasError = false}) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Error banner if details failed to load
          if (hasError)
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
                  Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Using cached paper details. Detailed information unavailable.',
                      style: TextStyle(fontSize: 13, color: isDark ? const Color(0xFFE5E5E5) : const Color(0xFF1F2937)),
                    ),
                  ),
                ],
              ),
            ),

          // Header Card with Test Details
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primaryColor.withValues(alpha: 0.1), AppColors.primaryColor.withValues(alpha: 0.05)],
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
                  paperDetail?.name ?? widget.paper.name,
                  style: context.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : const Color(0xFF1F2937),
                  ),
                ),
                if ((paperDetail?.description ?? widget.paper.description).isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    paperDetail?.description ?? widget.paper.description,
                    style: TextStyle(fontSize: 14, color: isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280)),
                  ),
                ],
                const SizedBox(height: 12),

                // Only show if paperDetail is available
                if (paperDetail != null) ...[
                  _TestDetailRow(
                    icon: Icons.article_outlined,
                    label: 'Total Questions',
                    value: paperDetail.totalQuestions.toString(),
                    isDark: isDark,
                  ),
                  const SizedBox(height: 8),
                ],

                _TestDetailRow(
                  icon: Icons.timer_outlined,
                  label: 'Duration',
                  value: '${paperDetail?.duration ?? widget.paper.durationInMinutes} minutes',
                  isDark: isDark,
                ),

                // Only show if paperDetail is available
                if (paperDetail != null) ...[
                  const SizedBox(height: 8),
                  _TestDetailRow(
                    icon: Icons.add_circle_outline,
                    label: 'Marks per Correct',
                    value: '+${paperDetail.positiveMarks}',
                    isDark: isDark,
                  ),
                  const SizedBox(height: 8),
                  _TestDetailRow(
                    icon: Icons.remove_circle_outline,
                    label: 'Negative Marks',
                    value: '-${paperDetail.negativeMarks}',
                    isDark: isDark,
                  ),
                ],
              ],
            ),
          ),

          const SizedBox(height: 24),

          // General Instructions Title
          Text(
            'General Instructions',
            style: context.titleMedium!.copyWith(
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : const Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 16),

          // Technical Requirements
          _InstructionCard(
            icon: Icons.laptop_chromebook,
            title: 'Technical Requirements',
            instructions: [
              'Ensure you have a stable internet connection',
              'Close unnecessary apps to avoid distractions',
              'Keep your device charged or connected to power',
              'Use the latest version of your browser',
            ],
            isDark: isDark,
          ),
          const SizedBox(height: 12),

          // Test Rules
          _InstructionCard(
            icon: Icons.rule_outlined,
            title: 'Test Rules',
            instructions: [
              'You can navigate between questions freely',
              'Bookmark questions to review them later',
              'Submit the test before time runs out',
            ],
            isDark: isDark,
          ),
          const SizedBox(height: 12),

          // Marking Scheme - only show if detailed data is available
          if (paperDetail != null) ...[
            _InstructionCard(
              icon: Icons.grade_outlined,
              title: 'Marking Scheme',
              instructions: [
                'Each correct answer: +${paperDetail.positiveMarks} marks',
                'Each incorrect answer: -${paperDetail.negativeMarks} mark',
                'Unattempted questions: No marks deducted',
                'Partial marking may apply for some questions',
              ],
              isDark: isDark,
            ),
            const SizedBox(height: 12),
          ],

          // Important Tips
          _InstructionCard(
            icon: Icons.tips_and_updates_outlined,
            title: 'Important Tips',
            instructions: [
              'Read each question carefully before answering',
              'Manage your time wisely across all sections',
              'Review marked questions before submitting',
              'Do not refresh the page during the test',
            ],
            isDark: isDark,
          ),

          // Bottom spacing for floating button
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildFloatingButton(BuildContext context, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap: () => context.pushReplacement(AppRoute.attemptPaper.path, extra: widget.paper),
        child: Container(
          height: 56,
          width: double.infinity,
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
    );
  }
}

class _TestDetailRow extends StatelessWidget {
  const _TestDetailRow({required this.icon, required this.label, required this.value, required this.isDark});

  final IconData icon;
  final String label;
  final String value;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
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
  const _InstructionCard({required this.icon, required this.title, required this.instructions, required this.isDark});

  final IconData icon;
  final String title;
  final List<String> instructions;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
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
