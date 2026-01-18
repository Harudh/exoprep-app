part of '../questions_view.dart';

class _NavigationButtons extends StatelessWidget {
  const _NavigationButtons({
    required this.viewModel,
    required this.subject,
    required this.subjects,
    required this.currentIndex,
    required this.totalQuestionsInSubject,
    required this.currentQuestion,
    required this.allQuestions,
    required this.paperId,
  });

  final Subject subject;
  final int currentIndex;
  final List<Subject> subjects;
  final int totalQuestionsInSubject;
  final QuestionsViewModel viewModel;
  final List<Question> allQuestions;
  final Question currentQuestion;
  final String paperId;

  bool get _isLastQuestionInSubject => currentIndex >= totalQuestionsInSubject - 1;

  bool get _isLastSubject {
    final currentSubjectIndex = subjects.indexWhere((s) => s.id == subject.id);
    return currentSubjectIndex == subjects.length - 1;
  }

  void _goToNextSection(BuildContext context) {
    final currentSubjectIndex = subjects.indexWhere((s) => s.id == subject.id);
    if (currentSubjectIndex < subjects.length - 1) {
      DefaultTabController.of(context).animateTo(currentSubjectIndex + 1);
      final nextSubject = subjects[currentSubjectIndex + 1];
      viewModel.jumpToQuestionInSubject(nextSubject.id, 0);
    }
  }

  Future<void> _handleFinish(BuildContext context) async {
    final totalQuestionsCount = allQuestions.length;
    final attemptedCount = viewModel.attemptedCount;
    final unattemptedCount = totalQuestionsCount - attemptedCount;

    final bool? shouldSubmit = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return FinishPaperDialog(
          totalQuestions: totalQuestionsCount,
          attemptedCount: attemptedCount,
          unattemptedCount: unattemptedCount,
        );
      },
    );

    if (shouldSubmit == true && context.mounted) {
      await viewModel.submitQuiz(paperId, allQuestions);

      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Test submitted successfully!'), backgroundColor: Colors.green));
        // TODO: Navigate to results page
        // context.go('/results');
      }
    }
  }

  String get _buttonLabel {
    if (_isLastQuestionInSubject) {
      return _isLastSubject ? 'Finish' : 'Next Section';
    }
    return 'Next';
  }

  IconData get _buttonIcon {
    if (_isLastQuestionInSubject && _isLastSubject) {
      return Icons.check;
    }
    return Icons.arrow_forward;
  }

  VoidCallback _getButtonAction(BuildContext context) {
    if (_isLastQuestionInSubject) {
      return _isLastSubject ? () => _handleFinish(context) : () => _goToNextSection(context);
    }
    return () => viewModel.nextQuestion(subject.id);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final colorScheme = context.colorScheme;
    final isFirstQuestion = currentIndex == 0;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A1A1A) : Colors.white,
        border: Border(top: BorderSide(color: isDark ? const Color(0xFF2A2A2A) : const Color(0xFFE5E7EB), width: 1)),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            if (!isFirstQuestion) ...[
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => viewModel.previousQuestion(subject.id),
                  icon: const Icon(Icons.arrow_back, size: 18),
                  label: const Text('Previous'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    side: BorderSide(color: isDark ? const Color(0xFF2A2A2A) : const Color(0xFFE5E7EB)),
                  ),
                ),
              ),
              const SizedBox(width: 12),
            ],
            ValueListenableBuilder<Set<String>>(
              valueListenable: viewModel.markedForLater,
              builder: (context, markedForLater, _) {
                final isMarked = markedForLater.contains(currentQuestion.id);
                return OutlinedButton(
                  onPressed: () => viewModel.markForLater(currentQuestion.id),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    backgroundColor: isMarked
                        ? (isDark
                              ? const Color(0xFFFBBF24).withValues(alpha: 0.2)
                              : const Color(0xFFFBBF24).withValues(alpha: 0.1))
                        : null,
                    side: BorderSide(
                      color: isMarked ? const Color(0xFFFBBF24) : (isDark ? const Color(0xFF2A2A2A) : const Color(0xFFE5E7EB)),
                    ),
                  ),
                  child: Icon(
                    isMarked ? Icons.bookmark : Icons.bookmark_border,
                    size: 20,
                    color: isMarked ? const Color(0xFFFBBF24) : (isDark ? const Color(0xFFE5E5E5) : const Color(0xFF1F2937)),
                  ),
                );
              },
            ),
            const SizedBox(width: 12),
            Expanded(
              child: FilledButton.icon(
                onPressed: _getButtonAction(context),
                icon: Icon(_buttonIcon, size: 18),
                label: Text(_buttonLabel),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  backgroundColor: colorScheme.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
