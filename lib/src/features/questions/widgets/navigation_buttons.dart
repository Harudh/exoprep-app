part of '../questions_view.dart';

class _NavigationButtons extends StatelessWidget {
  const _NavigationButtons({
    required this.viewModel,
    required this.currentIndex,
    required this.totalQuestions,
    required this.currentQuestion,
  });

  final QuestionsViewModel viewModel;
  final int currentIndex;
  final int totalQuestions;
  final Question currentQuestion;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

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
            if (currentIndex > 0) ...[
              Expanded(
                child: _NavButton(
                  label: 'Previous',
                  icon: Icons.arrow_back,
                  onPressed: () => viewModel.previousQuestion(),
                  isPrimary: false,
                ),
              ),
              const SizedBox(width: 8),
            ],
            Expanded(
              child: _NavButton(
                label: 'Later',
                icon: Icons.flag_outlined,
                onPressed: () => viewModel.markForLater(currentQuestion.id),
                isPrimary: false,
                isOutlined: true,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _NavButton(
                label: currentIndex < totalQuestions - 1 ? 'Next' : 'Finish',
                icon: currentIndex < totalQuestions - 1 ? Icons.arrow_forward : Icons.check,
                onPressed: () {
                  if (currentIndex < totalQuestions - 1) {
                    viewModel.nextQuestion();
                  } else {
                    _showFinishDialog(context);
                  }
                },
                isPrimary: true,
                iconAtEnd: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showFinishDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Finish Quiz'),
        content: const Text('Are you sure you want to finish this quiz?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              viewModel.finishQuiz();
            },
            child: const Text('Finish'),
          ),
        ],
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  const _NavButton({
    required this.label,
    required this.icon,
    required this.onPressed,
    required this.isPrimary,
    this.isOutlined = false,
    this.iconAtEnd = false,
  });

  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  final bool isPrimary;
  final bool isOutlined;
  final bool iconAtEnd;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    if (isPrimary) {
      return FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!iconAtEnd) ...[Icon(icon, size: 18), const SizedBox(width: 6)],
            Text(label, maxLines: 1, overflow: TextOverflow.ellipsis),
            if (iconAtEnd) ...[const SizedBox(width: 6), Icon(icon, size: 18)],
          ],
        ),
      );
    }

    if (isOutlined) {
      return OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          side: BorderSide(color: isDark ? const Color(0xFF2A2A2A) : const Color(0xFFE5E7EB)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18),
            const SizedBox(width: 6),
            Flexible(child: Text(label, maxLines: 1, overflow: TextOverflow.ellipsis)),
          ],
        ),
      );
    }

    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18),
          const SizedBox(width: 6),
          Text(label, maxLines: 1, overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }
}
