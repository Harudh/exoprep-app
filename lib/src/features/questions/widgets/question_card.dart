part of '../questions_view.dart';

class _QuestionCard extends StatelessWidget {
  const _QuestionCard({required this.question, required this.questionNumber, required this.viewModel});

  final Question question;
  final int questionNumber;
  final QuestionsViewModel viewModel;

  bool _isNumericalQuestion() => question.answer != null && question.answer!.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A1A1A) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isDark ? const Color(0xFF2A2A2A) : const Color(0xFFE5E7EB), width: 1),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _QuestionNumber(number: questionNumber),
          const SizedBox(height: 16),
          _QuestionTitle(title: question.title),
          if (question.image != null && question.image!.isNotEmpty) ...[
            const SizedBox(height: 20),
            _QuestionImage(base64Image: question.image!),
          ],
          const SizedBox(height: 20),
          if (_isNumericalQuestion())
            _NumericalAnswerInput(question: question, viewModel: viewModel)
          else
            _OptionsSection(question: question, viewModel: viewModel),
        ],
      ),
    );
  }
}

class _NumericalAnswerInput extends StatelessWidget {
  const _NumericalAnswerInput({required this.question, required this.viewModel});

  final Question question;
  final QuestionsViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final colorScheme = context.colorScheme;

    return ValueListenableBuilder<Map<String, String>>(
      valueListenable: viewModel.numericalAnswers,
      builder: (context, numericalAnswers, _) {
        final controller = TextEditingController(text: numericalAnswers[question.id] ?? '');

        // Update cursor position to end when text changes
        controller.selection = TextSelection.fromPosition(TextPosition(offset: controller.text.length));

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter your numerical answer:',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: controller,
              keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
              decoration: InputDecoration(
                hintText: 'Enter answer',
                hintStyle: TextStyle(color: isDark ? const Color(0xFF6B7280) : const Color(0xFF9CA3AF)),
                filled: true,
                fillColor: isDark ? const Color(0xFF2A2A2A) : const Color(0xFFF3F4F6),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: isDark ? const Color(0xFF3F3F3F) : const Color(0xFFD1D5DB), width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: isDark ? const Color(0xFF3F3F3F) : const Color(0xFFD1D5DB), width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: colorScheme.primary, width: 1.5),
                ),
              ),
              style: TextStyle(fontSize: 16, color: isDark ? const Color(0xFFE5E5E5) : const Color(0xFF1F2937)),
              onChanged: (value) {
                viewModel.setNumericalAnswer(question.id, value);
              },
            ),
          ],
        );
      },
    );
  }
}

class _OptionsSection extends StatelessWidget {
  const _OptionsSection({required this.question, required this.viewModel});

  final Question question;
  final QuestionsViewModel viewModel;

  String _getOptionLabel(int index) => String.fromCharCode(65 + index);

  bool _isMultipleChoice() => question.correctOptionIndexes.length > 1;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Map<String, List<int>>>(
      valueListenable: viewModel.selectedAnswers,
      builder: (context, selectedAnswers, _) {
        final selectedOptions = selectedAnswers[question.id] ?? [];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_isMultipleChoice()) Padding(padding: const EdgeInsets.only(bottom: 12), child: _MultipleChoiceIndicator()),
            ...List.generate(
              question.options.length,
              (index) => Padding(
                padding: EdgeInsets.only(bottom: index < question.options.length - 1 ? 10 : 0),
                child: _OptionTile(
                  option: question.options[index],
                  optionLabel: _getOptionLabel(index),
                  isCorrect: question.correctOptionIndexes.contains(index),
                  isSelected: selectedOptions.contains(index),
                  isMultipleChoice: _isMultipleChoice(),
                  onTap: () {
                    viewModel.toggleOption(question.id, index, _isMultipleChoice());
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _MultipleChoiceIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final infoColor = isDark ? const Color(0xFF60A5FA) : const Color(0xFF3B82F6);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: infoColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: infoColor.withValues(alpha: 0.3), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check_box_outlined, size: 16, color: infoColor),
          const SizedBox(width: 6),
          Text(
            'Multiple Choice - Select all that apply',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: infoColor),
          ),
        ],
      ),
    );
  }
}

class _AnswerExplanation extends StatelessWidget {
  const _AnswerExplanation({required this.answer});

  final String answer;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final infoColor = isDark ? const Color(0xFF60A5FA) : const Color(0xFF3B82F6);
    final infoSubtleColor = infoColor.withValues(alpha: isDark ? 0.12 : 0.08);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: infoSubtleColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: infoColor.withValues(alpha: 0.3), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.lightbulb_outline, size: 20, color: infoColor),
              const SizedBox(width: 8),
              Text(
                'Explanation',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: infoColor),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            answer,
            style: TextStyle(fontSize: 14, height: 1.5, color: isDark ? const Color(0xFFE5E5E5) : const Color(0xFF1F2937)),
          ),
        ],
      ),
    );
  }
}
