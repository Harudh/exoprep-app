part of '../questions_view.dart';

class QuestionsDrawer extends StatelessWidget {
  const QuestionsDrawer({super.key, required this.viewModel, required this.questions, required this.subjects});

  final QuestionsViewModel viewModel;
  final List<Question> questions;
  final List<Subject> subjects;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final colorScheme = context.colorScheme;
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
                    'Progress',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: isDark ? const Color(0xFFE5E5E5) : const Color(0xFF1F2937),
                    ),
                  ),
                  ThemeToggleSwitch(),
                  IconButton(
                    icon: Icon(Icons.close, color: isDark ? const Color(0xFFE5E5E5) : const Color(0xFF1F2937)),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 12),
              child: _LegendSection(colorScheme: colorScheme),
            ),
            Divider(height: 1, color: dividerColor),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: viewModel.selectedAnswers,
                builder: (context, selectedAnswers, _) {
                  return ValueListenableBuilder(
                    valueListenable: viewModel.numericalAnswers,
                    builder: (context, numericalAnswers, _) {
                      return ValueListenableBuilder(
                        valueListenable: viewModel.markedForLater,
                        builder: (context, markedForLater, _) {
                          return _SubjectSections(
                            subjects: subjects,
                            questions: questions,
                            selectedAnswers: selectedAnswers,
                            numericalAnswers: numericalAnswers,
                            markedForLater: markedForLater,
                            colorScheme: colorScheme,
                            viewModel: viewModel,
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
            Divider(height: 1, color: dividerColor),
            Padding(
              padding: EdgeInsets.only(left: 18, right: 18, top: 12),
              child: ValueListenableBuilder(
                valueListenable: viewModel.selectedAnswers,
                builder: (context, selectedAnswers, _) {
                  return ValueListenableBuilder(
                    valueListenable: viewModel.numericalAnswers,
                    builder: (context, numericalAnswers, _) {
                      final totalAttempted = selectedAnswers.length + numericalAnswers.length;
                      return _ProgressIndicator(
                        totalQuestions: questions.length,
                        attemptedCount: totalAttempted,
                        colorScheme: colorScheme,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SubjectSections extends StatelessWidget {
  const _SubjectSections({
    required this.subjects,
    required this.questions,
    required this.selectedAnswers,
    required this.numericalAnswers,
    required this.markedForLater,
    required this.viewModel,
    required this.colorScheme,
  });

  final List<Subject> subjects;
  final List<Question> questions;
  final Map<String, List<int>> selectedAnswers;
  final Map<String, String> numericalAnswers;
  final Set<String> markedForLater;
  final QuestionsViewModel viewModel;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      itemCount: subjects.length,
      itemBuilder: (context, index) {
        final subject = subjects[index];
        final subjectQuestions = questions.where((q) => q.topic.subject.id == subject.id).toList();

        if (subjectQuestions.isEmpty) return const SizedBox.shrink();

        return _SubjectExpansionTile(
          subject: subject,
          subjectIndex: index,
          questions: subjectQuestions,
          allQuestions: questions,
          selectedAnswers: selectedAnswers,
          numericalAnswers: numericalAnswers,
          markedForLater: markedForLater,
          viewModel: viewModel,
          colorScheme: colorScheme,
        );
      },
    );
  }
}

class _SubjectExpansionTile extends StatelessWidget {
  const _SubjectExpansionTile({
    required this.subject,
    required this.subjectIndex,
    required this.questions,
    required this.allQuestions,
    required this.selectedAnswers,
    required this.numericalAnswers,
    required this.markedForLater,
    required this.viewModel,
    required this.colorScheme,
  });

  final Subject subject;
  final int subjectIndex;
  final List<Question> questions;
  final List<Question> allQuestions;
  final Map<String, List<int>> selectedAnswers;
  final Map<String, String> numericalAnswers;
  final Set<String> markedForLater;
  final QuestionsViewModel viewModel;
  final ColorScheme colorScheme;

  int get attemptedCount {
    return questions.where((q) {
      if (q.answer != null && q.answer!.isNotEmpty) {
        return numericalAnswers.containsKey(q.id) && numericalAnswers[q.id]!.isNotEmpty;
      }
      return selectedAnswers.containsKey(q.id) && selectedAnswers[q.id]!.isNotEmpty;
    }).length;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        initiallyExpanded: true,
        backgroundColor: Colors.transparent,
        collapsedBackgroundColor: Colors.transparent,
        tilePadding: const EdgeInsets.symmetric(horizontal: 8),
        childrenPadding: const EdgeInsets.only(left: 8, right: 8, bottom: 12),
        iconColor: isDark ? const Color(0xFFE5E5E5) : const Color(0xFF1F2937),
        collapsedIconColor: isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280),
        title: Row(
          children: [
            Expanded(
              child: Text(
                subject.name,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: isDark ? const Color(0xFFE5E5E5) : const Color(0xFF1F2937),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: colorScheme.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '$attemptedCount/${questions.length}',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: colorScheme.primary),
              ),
            ),
          ],
        ),
        children: [
          _QuestionGrid(
            questions: questions,
            allQuestions: allQuestions,
            selectedAnswers: selectedAnswers,
            numericalAnswers: numericalAnswers,
            markedForLater: markedForLater,
            viewModel: viewModel,
            subjectIndex: subjectIndex,
            subjectId: subject.id,
            colorScheme: colorScheme,
          ),
        ],
      ),
    );
  }
}

class _LegendSection extends StatelessWidget {
  const _LegendSection({required this.colorScheme});

  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
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
        _LegendItem(color: colorScheme.primary, label: 'Attempted'),
        const SizedBox(height: 8),
        _LegendItem(
          color: isDark ? const Color(0xFF2A2A2A) : const Color(0xFFF3F4F6),
          label: 'Unattempted',
          borderColor: isDark ? const Color(0xFF3F3F3F) : const Color(0xFFD1D5DB),
        ),
        const SizedBox(height: 8),
        _LegendItem(color: isDark ? const Color(0xFFFBBF24) : const Color(0xFFFBBF24), label: 'Marked for Later'),
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
    final isDark = context.isDarkMode;
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
        Text(label, style: TextStyle(fontSize: 14, color: isDark ? const Color(0xFFE5E5E5) : const Color(0xFF1F2937))),
      ],
    );
  }
}

class _QuestionGrid extends StatelessWidget {
  const _QuestionGrid({
    required this.questions,
    required this.allQuestions,
    required this.selectedAnswers,
    required this.numericalAnswers,
    required this.markedForLater,
    required this.viewModel,
    required this.subjectIndex,
    required this.subjectId,
    required this.colorScheme,
  });

  final List<Question> questions;
  final List<Question> allQuestions;
  final Map<String, List<int>> selectedAnswers;
  final Map<String, String> numericalAnswers;
  final Set<String> markedForLater;
  final QuestionsViewModel viewModel;
  final int subjectIndex;
  final String subjectId;
  final ColorScheme colorScheme;

  bool _isQuestionAttempted(Question question) {
    // Check if it's a numerical question
    if (question.answer != null && question.answer!.isNotEmpty) {
      return numericalAnswers.containsKey(question.id) && numericalAnswers[question.id]!.isNotEmpty;
    }
    // Check if it's an MCQ question
    return selectedAnswers.containsKey(question.id) && selectedAnswers[question.id]!.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 1,
      ),
      itemCount: questions.length,
      itemBuilder: (context, index) {
        final question = questions[index];
        final isAttempted = _isQuestionAttempted(question);
        final isMarked = markedForLater.contains(question.id);

        return _QuestionGridItem(
          questionNumber: index + 1,
          isAttempted: isAttempted,
          isMarked: isMarked,
          onTap: () {
            Navigator.pop(context);
            DefaultTabController.of(context).animateTo(subjectIndex);
            viewModel.jumpToQuestionInSubject(subjectId, index);
          },
          colorScheme: colorScheme,
        );
      },
    );
  }
}

class _QuestionGridItem extends StatelessWidget {
  const _QuestionGridItem({
    required this.questionNumber,
    required this.isAttempted,
    required this.isMarked,
    required this.onTap,
    required this.colorScheme,
  });

  final int questionNumber;
  final bool isAttempted;
  final bool isMarked;
  final VoidCallback onTap;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    Color backgroundColor;
    Color textColor;
    Color? borderColor;

    if (isMarked) {
      backgroundColor = isDark ? const Color(0xFFFBBF24) : const Color(0xFFFBBF24);
      textColor = const Color(0xFF1F2937);
      borderColor = null;
    } else if (isAttempted) {
      backgroundColor = colorScheme.primary;
      textColor = Colors.white;
      borderColor = null;
    } else {
      backgroundColor = isDark ? const Color(0xFF2A2A2A) : const Color(0xFFF3F4F6);
      textColor = isDark ? const Color(0xFFE5E5E5) : const Color(0xFF1F2937);
      borderColor = isDark ? const Color(0xFF3F3F3F) : const Color(0xFFD1D5DB);
    }

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
          border: borderColor != null ? Border.all(color: borderColor, width: 1) : null,
        ),
        child: Center(
          child: Text(
            '$questionNumber',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: textColor),
          ),
        ),
      ),
    );
  }
}

class _ProgressIndicator extends StatelessWidget {
  const _ProgressIndicator({required this.totalQuestions, required this.attemptedCount, required this.colorScheme});

  final int totalQuestions;
  final int attemptedCount;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final percentage = totalQuestions > 0 ? (attemptedCount / totalQuestions * 100).toInt() : 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Completion',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280),
              ),
            ),
            Text(
              '$percentage%',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: colorScheme.primary),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: attemptedCount / totalQuestions,
            backgroundColor: isDark ? const Color(0xFF2A2A2A) : const Color(0xFFE5E7EB),
            valueColor: AlwaysStoppedAnimation<Color>(colorScheme.primary),
            minHeight: 8,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '$attemptedCount of $totalQuestions questions attempted',
          style: TextStyle(fontSize: 12, color: isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280)),
        ),
      ],
    );
  }
}
