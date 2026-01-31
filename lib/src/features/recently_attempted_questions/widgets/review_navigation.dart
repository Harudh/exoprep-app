part of '../recently_attempted_questions_view.dart';

class _ReviewNavigation extends StatelessWidget {
  const _ReviewNavigation({
    required this.currentIndex,
    required this.totalQuestions,
    required this.onPrevious,
    required this.onNext,
    required this.onClose,
  });

  final int currentIndex;
  final int totalQuestions;
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final colorScheme = context.colorScheme;
    final isFirstQuestion = currentIndex == 0;
    final isLastQuestion = currentIndex >= totalQuestions - 1;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A1A1A) : Colors.white,
        border: Border(
          top: BorderSide(
            color: isDark ? const Color(0xFF2A2A2A) : const Color(0xFFE5E7EB),
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            if (!isFirstQuestion) ...[
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: onPrevious,
                  icon: const Icon(Icons.arrow_back, size: 18),
                  label: const Text('Previous'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    side: BorderSide(
                      color: isDark ? const Color(0xFF2A2A2A) : const Color(0xFFE5E7EB),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
            ],
            Expanded(
              child: FilledButton.icon(
                onPressed: isLastQuestion ? onClose : onNext,
                icon: Icon(isLastQuestion ? Icons.close : Icons.arrow_forward, size: 18),
                label: Text(isLastQuestion ? 'Close Review' : 'Next'),
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
