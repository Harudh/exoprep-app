part of '../recently_attempted_questions_view.dart';

class _ReviewDrawer extends StatelessWidget {
  const _ReviewDrawer({
    required this.recentlyAttemptedPaper,
    required this.questions,
    required this.currentIndex,
    required this.onQuestionTap,
  });

  final RecentlyAttemptedPaper recentlyAttemptedPaper;
  final List<Question> questions;
  final int currentIndex;
  final Function(int) onQuestionTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dividerColor = isDark ? Colors.grey.shade800 : Colors.grey.shade200;

    return Drawer(
      backgroundColor: isDark ? const Color(0xFF1A1A1A) : Colors.white,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'All Questions',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: isDark ? const Color(0xFFE5E5E5) : const Color(0xFF1F2937),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.close,
                      color: isDark ? const Color(0xFFE5E5E5) : const Color(0xFF1F2937),
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 12),
              child: _ReviewLegendSection(),
            ),
            Divider(height: 1, color: dividerColor),
            Expanded(
              child: _QuestionGridView(
                questions: questions,
                responses: recentlyAttemptedPaper.responses,
                currentIndex: currentIndex,
                onQuestionTap: onQuestionTap,
              ),
            ),
            Divider(height: 1, color: dividerColor),
            Padding(
              padding: const EdgeInsets.all(18),
              child: _ReviewStats(recentlyAttemptedPaper: recentlyAttemptedPaper),
            ),
          ],
        ),
      ),
    );
  }
}

class _ReviewLegendSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Legend',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280),
          ),
        ),
        const SizedBox(height: 12),
        _LegendItem(color: const Color(0xFF10B981), label: 'Correct'),
        const SizedBox(height: 8),
        _LegendItem(color: const Color(0xFFFBBF24), label: 'Partially Correct'),
        const SizedBox(height: 8),
        _LegendItem(color: const Color(0xFFEF4444), label: 'Incorrect'),
        const SizedBox(height: 8),
        _LegendItem(
          color: isDark ? const Color(0xFF2A2A2A) : const Color(0xFFF3F4F6),
          label: 'Skipped',
          borderColor: isDark ? const Color(0xFF3F3F3F) : const Color(0xFFD1D5DB),
        ),
      ],
    );
  }
}

class _LegendItem extends StatelessWidget {
  const _LegendItem({required this.color, required this.label, this.borderColor});

  final Color color;
  final String label;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
            border: borderColor != null ? Border.all(color: borderColor!, width: 1) : null,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: isDark ? const Color(0xFFE5E5E5) : const Color(0xFF1F2937),
          ),
        ),
      ],
    );
  }
}

class _QuestionGridView extends StatelessWidget {
  const _QuestionGridView({
    required this.questions,
    required this.responses,
    required this.currentIndex,
    required this.onQuestionTap,
  });

  final List<Question> questions;
  final List<QuestionResponse> responses;
  final int currentIndex;
  final Function(int) onQuestionTap;

  QuestionResponse? _getResponseForQuestion(String questionId) {
    try {
      return responses.firstWhere((r) => r.questionId == questionId);
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 1,
      ),
      itemCount: questions.length,
      itemBuilder: (context, index) {
        final question = questions[index];
        final response = _getResponseForQuestion(question.id);

        return _QuestionGridItem(
          questionNumber: index + 1,
          response: response,
          isCurrentQuestion: index == currentIndex,
          onTap: () => onQuestionTap(index),
        );
      },
    );
  }
}

class _QuestionGridItem extends StatelessWidget {
  const _QuestionGridItem({
    required this.questionNumber,
    required this.response,
    required this.isCurrentQuestion,
    required this.onTap,
  });

  final int questionNumber;
  final QuestionResponse? response;
  final bool isCurrentQuestion;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Color backgroundColor;
    Color textColor;
    Color? borderColor;

    if (response == null) {
      // Skipped/Not attempted
      backgroundColor = isDark ? const Color(0xFF2A2A2A) : const Color(0xFFF3F4F6);
      textColor = isDark ? const Color(0xFFE5E5E5) : const Color(0xFF1F2937);
      borderColor = isDark ? const Color(0xFF3F3F3F) : const Color(0xFFD1D5DB);
    } else {
      switch (response!.isCorrect) {
        case 'YES':
          backgroundColor = const Color(0xFF10B981);
          textColor = Colors.white;
          borderColor = null;
          break;
        case 'PARTIAL':
          backgroundColor = const Color(0xFFFBBF24);
          textColor = const Color(0xFF1F2937);
          borderColor = null;
          break;
        case 'NO':
          backgroundColor = const Color(0xFFEF4444);
          textColor = Colors.white;
          borderColor = null;
          break;
        default:
          backgroundColor = isDark ? const Color(0xFF2A2A2A) : const Color(0xFFF3F4F6);
          textColor = isDark ? const Color(0xFFE5E5E5) : const Color(0xFF1F2937);
          borderColor = isDark ? const Color(0xFF3F3F3F) : const Color(0xFFD1D5DB);
      }
    }

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
          border: borderColor != null
              ? Border.all(color: borderColor, width: 1)
              : (isCurrentQuestion ? Border.all(color: Colors.white, width: 2) : null),
        ),
        child: Center(
          child: Text(
            '$questionNumber',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}

class _ReviewStats extends StatelessWidget {
  const _ReviewStats({required this.recentlyAttemptedPaper});

  final RecentlyAttemptedPaper recentlyAttemptedPaper;

  String _formatDuration(int seconds) {
    final duration = Duration(seconds: seconds);
    final minutes = duration.inMinutes;
    final secs = duration.inSeconds % 60;
    return '${minutes}m ${secs}s';
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Statistics',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280),
          ),
        ),
        const SizedBox(height: 12),
        _StatRow(
          label: 'Total Questions',
          value: '${recentlyAttemptedPaper.totalQuestions}',
          isDark: isDark,
        ),
        const SizedBox(height: 8),
        _StatRow(
          label: 'Attempted',
          value: '${recentlyAttemptedPaper.attemptedCount}',
          isDark: isDark,
        ),
        const SizedBox(height: 8),
        _StatRow(
          label: 'Time Taken',
          value: _formatDuration(recentlyAttemptedPaper.timeTaken),
          isDark: isDark,
        ),
        const SizedBox(height: 8),
        _StatRow(
          label: 'Score',
          value: '${recentlyAttemptedPaper.score}',
          isDark: isDark,
        ),
      ],
    );
  }
}

class _StatRow extends StatelessWidget {
  const _StatRow({
    required this.label,
    required this.value,
    required this.isDark,
  });

  final String label;
  final String value;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: isDark ? const Color(0xFFE5E5E5) : const Color(0xFF1F2937),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isDark ? const Color(0xFFE5E5E5) : const Color(0xFF1F2937),
          ),
        ),
      ],
    );
  }
}
