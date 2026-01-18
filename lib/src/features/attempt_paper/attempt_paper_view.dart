import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:root/src/core/theme/colors.dart';
import 'package:root/src/core/navigation/routes.dart';
import 'package:root/src/models/paper_model/paper_model.dart';
import 'package:root/src/core/extensions/context_extension.dart';
import 'package:root/src/core/common/state/viewmodel_state.dart';
import 'package:root/src/models/subject_model/subject_model.dart';
import 'package:root/src/models/question_model/question_model.dart';
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
      appBar: AppBar(title: Text(widget.paper.name), centerTitle: true),
      body: ValueListenableBuilder<ViewModelState<String>>(
        valueListenable: viewModel.paperDataState,
        builder: (context, state, child) {
          if (state.status == ViewModelStatus.loading) {
            return const _LoadingView();
          }

          if (state.status == ViewModelStatus.error) {
            return _ErrorView(message: state.error ?? 'Failed to load paper data', onRetry: onRefresh);
          }

          if (state.status == ViewModelStatus.success) {
            return _LoadedView(
              paper: widget.paper,
              subjects: viewModel.subjectsData.value,
              questions: viewModel.questionsData.value,
              onContinue: _startAttempt,
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  void _startAttempt() {
    // Navigate to the actual paper attempt screen
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Starting paper attempt...')));
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text('Loading paper data...', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        ],
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
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.red.shade400),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.red.shade400),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
              style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16)),
            ),
          ],
        ),
      ),
    );
  }
}

class _LoadedView extends StatelessWidget {
  final Paper paper;
  final List<Subject> subjects;
  final List<Question> questions;
  final VoidCallback onContinue;

  const _LoadedView({required this.paper, required this.subjects, required this.questions, required this.onContinue});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _InfoCard(icon: CupertinoIcons.book_solid, label: 'Paper', value: paper.name),
            const SizedBox(height: 12),
            _InfoCard(icon: CupertinoIcons.question_circle, label: 'Total Questions', value: '${questions.length} questions'),
            const SizedBox(height: 12),
            _InfoCard(icon: CupertinoIcons.collections, label: 'Subjects', value: '${subjects.length} subjects'),
            const SizedBox(height: 64),
            GestureDetector(
              onTap: () => context.pushReplacement(
                AppRoute.questions.path,
                extra: {'paper': paper, 'subjects': subjects, 'questions': questions},
              ),
              child: Container(
                height: 56,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(color: AppColors.primaryColor, borderRadius: BorderRadius.circular(30)),
                child: Center(
                  child: Text(
                    "Continue",
                    style: context.titleMedium!.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoCard({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark ? Colors.grey.shade900 : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, size: 24, color: Theme.of(context).primaryColor),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                const SizedBox(height: 4),
                Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
