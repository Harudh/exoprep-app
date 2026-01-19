part of '../questions_view.dart';

class _NavigationButtons extends StatefulWidget {
  const _NavigationButtons({
    required this.totalQuestionsInSubject,
    required this.currentQuestion,
    required this.currentIndex,
    required this.allQuestions,
    required this.viewModel,
    required this.subjects,
    required this.subject,
    required this.paper,
  });

  final Subject subject;
  final int currentIndex;
  final List<Subject> subjects;
  final int totalQuestionsInSubject;
  final QuestionsViewModel viewModel;
  final List<Question> allQuestions;
  final Question currentQuestion;
  final Paper paper;

  @override
  State<_NavigationButtons> createState() => _NavigationButtonsState();
}

class _NavigationButtonsState extends State<_NavigationButtons> {
  bool _isSubmitting = false;

  bool get _isLastQuestionInSubject => widget.currentIndex >= widget.totalQuestionsInSubject - 1;

  bool get _isLastSubject {
    final currentSubjectIndex = widget.subjects.indexWhere((s) => s.id == widget.subject.id);
    return currentSubjectIndex == widget.subjects.length - 1;
  }

  void _goToNextSection(BuildContext context) {
    final currentSubjectIndex = widget.subjects.indexWhere((s) => s.id == widget.subject.id);
    if (currentSubjectIndex < widget.subjects.length - 1) {
      DefaultTabController.of(context).animateTo(currentSubjectIndex + 1);
      final nextSubject = widget.subjects[currentSubjectIndex + 1];
      widget.viewModel.jumpToQuestionInSubject(nextSubject.id, 0);
    }
  }

  Future<void> _handleFinish(BuildContext context) async {
    if (_isSubmitting) return;

    final totalQuestionsCount = widget.allQuestions.length;
    final attemptedCount = widget.viewModel.attemptedCount;
    final unattemptedCount = totalQuestionsCount - attemptedCount;

    final bool? shouldSubmit = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return FinishPaperDialog(
          totalQuestions: totalQuestionsCount,
          attemptedCount: attemptedCount,
          unattemptedCount: unattemptedCount,
        );
      },
    );

    if (shouldSubmit != true || !mounted) return;

    setState(() => _isSubmitting = true);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return const _SubmittingDialog();
      },
    );

    try {
      final attemptedQuestions = widget.viewModel.prepareSubmissionData(widget.paper.id, widget.allQuestions);
      await widget.viewModel.submitPaper(widget.paper.id, widget.allQuestions);
      if (!mounted) return;
      final state = widget.viewModel.questionsState.value;
      Navigator.of(context).pop();
      if (state.status == ViewModelStatus.success && state.type == QuestionStates.submissionSuccess) {
        await Future.delayed(const Duration(milliseconds: 500));
        if (mounted) {
          context.pushReplacement(
            AppRoute.paperResult.path,
            extra: {
              'paper': widget.paper,
              'subjects': widget.subjects,
              'questions': widget.allQuestions,
              'attempted_questions': attemptedQuestions,
            },
          );
        }
      } else if (state.status == ViewModelStatus.error && state.type == QuestionStates.submissionError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to submit paper'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 10),
            action: SnackBarAction(label: 'Retry', textColor: Colors.white, onPressed: () => _handleFinish(context)),
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
          action: SnackBarAction(label: 'Retry', textColor: Colors.white, onPressed: () => _handleFinish(context)),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
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
    if (_isLastQuestionInSubject && _isLastSubject) return Icons.check;
    return Icons.arrow_forward;
  }

  VoidCallback? _getButtonAction(BuildContext context) {
    if (_isSubmitting) return null;

    if (_isLastQuestionInSubject) {
      return _isLastSubject ? () => _handleFinish(context) : () => _goToNextSection(context);
    }
    return () => widget.viewModel.nextQuestion(widget.subject.id);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final colorScheme = context.colorScheme;
    final isFirstQuestion = widget.currentIndex == 0;

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
                  onPressed: _isSubmitting ? null : () => widget.viewModel.previousQuestion(widget.subject.id),
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
              valueListenable: widget.viewModel.markedForLater,
              builder: (context, markedForLater, _) {
                final isMarked = markedForLater.contains(widget.currentQuestion.id);
                return OutlinedButton(
                  onPressed: _isSubmitting ? null : () => widget.viewModel.markForLater(widget.currentQuestion.id),
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

class _SubmittingDialog extends StatelessWidget {
  const _SubmittingDialog();

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return PopScope(
      canPop: false,
      child: AlertDialog(
        backgroundColor: isDark ? const Color(0xFF1A1A1A) : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(color: context.colorScheme.primary),
            const SizedBox(height: 20),
            Text(
              'Submitting your test...',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: isDark ? const Color(0xFFE5E5E5) : const Color(0xFF1F2937),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Please wait',
              style: TextStyle(fontSize: 14, color: isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280)),
            ),
          ],
        ),
      ),
    );
  }
}
