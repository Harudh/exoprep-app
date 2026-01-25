part of 'questions_view.dart';

mixin QuestionsMixin on State<QuestionsView> {
  late QuestionsViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = QuestionsViewModel();
    viewModel.initializeQuestions(widget.questions, widget.paper.durationInMinutes);

    // Set callback for auto-submit when timer ends
    viewModel.onTimerEnd = () {
      if (mounted) {
        _autoSubmitPaper();
      }
    };
  }

  Future<void> _autoSubmitPaper() async {
    showDialog(context: context, barrierDismissible: false, builder: (context) => const _AutoSubmitDialog());

    try {
      final attemptedQuestions = viewModel.prepareSubmissionData(widget.paper.id, widget.questions);

      await viewModel.submitPaper(widget.paper.id, widget.questions);

      if (!mounted) return;

      Navigator.of(context).pop();

      final state = viewModel.questionsState.value;
      if (state.status == ViewModelStatus.success && state.type == QuestionStates.submissionSuccess) {
        await Future.delayed(const Duration(milliseconds: 500));
        if (mounted) {
          context.pushReplacement(
            AppRoute.paperResult.path,
            extra: {
              'paper': widget.paper,
              'subjects': widget.subjects,
              'questions': widget.questions,
              'attempted_questions': attemptedQuestions,
            },
          );
        }
      }
    } catch (e) {
      if (!mounted) return;
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Auto-submit failed: ${e.toString()}'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 5),
        ),
      );
    }
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }
}
