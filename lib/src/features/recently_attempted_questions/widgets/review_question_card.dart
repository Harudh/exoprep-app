part of '../recently_attempted_questions_view.dart';

class _ReviewQuestionCard extends StatelessWidget {
  const _ReviewQuestionCard({
    required this.question,
    required this.questionNumber,
    required this.response,
  });

  final Question question;
  final int questionNumber;
  final QuestionResponse? response;

  bool _isNumericalQuestion() => question.answer != null && question.answer!.isNotEmpty;

  // Check if question was attempted
  bool _isAttempted() {
    if (response == null) return false;

    // For numerical questions
    if (_isNumericalQuestion()) {
      return response!.attemptedAnswer != null && response!.attemptedAnswer!.isNotEmpty;
    }

    // For MCQ questions
    return response!.attemptedOptionIndexes.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isAttempted = _isAttempted();

    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A1A1A) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? const Color(0xFF2A2A2A) : const Color(0xFFE5E7EB),
          width: 1,
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _QuestionNumber(number: questionNumber),
              const Spacer(),
              if (response != null && isAttempted)
                _AnswerStatusIndicator(response: response!)
              else
                _NotAttemptedChip(),
            ],
          ),
          const SizedBox(height: 16),
          _QuestionTitle(title: question.title, isDark: isDark),
          if (question.image != null && question.image!.isNotEmpty) ...[
            const SizedBox(height: 20),
            _QuestionImage(base64Image: question.image!),
          ],
          const SizedBox(height: 20),
          if (_isNumericalQuestion())
            _ReviewNumericalAnswer(question: question, response: response)
          else
            _ReviewOptionsSection(question: question, response: response),
          if (response != null && isAttempted && response!.marksAwarded >= 0) ...[
            const SizedBox(height: 20),
            _MarksAwarded(marksAwarded: response!.marksAwarded),
          ],
        ],
      ),
    );
  }
}

// Add this new widget for Not Attempted chip
class _NotAttemptedChip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = isDark ? const Color(0xFF6B7280) : const Color(0xFF9CA3AF);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: isDark ? 0.12 : 0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.remove_circle_outline, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            'Not Attempted',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

class _QuestionNumber extends StatelessWidget {
  const _QuestionNumber({required this.number});

  final int number;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: (isDark ? const Color(0xFF818CF8) : colorScheme.primary)
            .withValues(alpha: isDark ? 0.12 : 0.08),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        'Question $number',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: isDark ? const Color(0xFF818CF8) : colorScheme.primary,
          letterSpacing: 0.4,
        ),
      ),
    );
  }
}

class _QuestionTitle extends StatelessWidget {
  const _QuestionTitle({required this.title, required this.isDark});

  final String title;
  final bool isDark;

  bool _isHtml(String text) {
    return text.trim().startsWith('<') && text.trim().contains('>');
  }

  @override
  Widget build(BuildContext context) {
    final textColor = isDark ? const Color(0xFFE5E5E5) : const Color(0xFF1F2937);
    final colorScheme = Theme.of(context).colorScheme;

    if (_isHtml(title)) {
      return Html(
        data: title,
        style: {
          "body": Style(
            margin: Margins.zero,
            fontSize: FontSize(17),
            padding: HtmlPaddings.zero,
            fontWeight: FontWeight.w500,
            lineHeight: LineHeight(1.6),
            display: Display.inline,
            color: textColor,
          ),
          "p": Style(
            margin: Margins.zero,
            fontSize: FontSize(17),
            padding: HtmlPaddings.zero,
            fontWeight: FontWeight.w500,
            lineHeight: LineHeight(1.6),
            display: Display.inline,
            color: textColor,
          ),
          "strong": Style(fontWeight: FontWeight.bold),
          "b": Style(fontWeight: FontWeight.bold),
          "em": Style(fontStyle: FontStyle.italic),
          "i": Style(fontStyle: FontStyle.italic),
          "u": Style(textDecoration: TextDecoration.underline),
          "sup": Style(fontSize: FontSize(14), verticalAlign: VerticalAlign.sup),
          "sub": Style(fontSize: FontSize(14), verticalAlign: VerticalAlign.sub),
          "a": Style(color: colorScheme.primary, textDecoration: TextDecoration.underline),
        },
      );
    }

    return Text(
      title,
      style: TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w500,
        color: textColor,
        height: 1.6,
        letterSpacing: 0.1,
      ),
    );
  }
}

class _QuestionImage extends StatelessWidget {
  const _QuestionImage({required this.base64Image});

  final String base64Image;

  Uint8List? _decodeBase64() {
    try {
      String cleanBase64 = base64Image;
      if (base64Image.contains(',')) {
        cleanBase64 = base64Image.split(',').last;
      }
      return base64Decode(cleanBase64);
    } catch (e) {
      debugPrint('Error decoding base64 image: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final imageBytes = _decodeBase64();

    if (imageBytes == null) {
      return const _ErrorImagePlaceholder();
    }

    return RepaintBoundary(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.withValues(alpha: 0.3), width: 1),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.memory(
            imageBytes,
            fit: BoxFit.contain,
            gaplessPlayback: true,
            errorBuilder: (context, error, stackTrace) {
              return const _ErrorImagePlaceholder();
            },
          ),
        ),
      ),
    );
  }
}

class _ErrorImagePlaceholder extends StatelessWidget {
  const _ErrorImagePlaceholder();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: isDark ? colorScheme.surfaceContainerHighest : colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorScheme.outline.withValues(alpha: 0.2), width: 1),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.broken_image_outlined, size: 48, color: colorScheme.onSurfaceVariant),
            const SizedBox(height: 8),
            Text(
              'Image unavailable',
              style: TextStyle(
                fontSize: 12,
                color: colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ReviewNumericalAnswer extends StatelessWidget {
  const _ReviewNumericalAnswer({required this.question, required this.response});

  final Question question;
  final QuestionResponse? response;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Get user's attempted answer from response
    final userAnswer = response?.attemptedAnswer ?? '';
    final correctAnswer = question.answer ?? '';
    final isCorrect = response?.isCorrect == 'YES';
    final isAttempted = userAnswer.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Numerical Answer:',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280),
          ),
        ),
        const SizedBox(height: 12),
        // User's Answer
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: isAttempted
                ? (isCorrect ? const Color(0xFF10B981) : const Color(0xFFEF4444))
                .withValues(alpha: isDark ? 0.12 : 0.08)
                : (isDark ? const Color(0xFF2A2A2A) : const Color(0xFFF3F4F6)),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isAttempted
                  ? (isCorrect ? const Color(0xFF10B981) : const Color(0xFFEF4444))
                  : (isDark ? const Color(0xFF3F3F3F) : const Color(0xFFD1D5DB)),
              width: isAttempted ? 1.5 : 1,
            ),
          ),
          child: Row(
            children: [
              if (isAttempted)
                Icon(
                  isCorrect ? Icons.check_circle : Icons.cancel,
                  size: 18,
                  color: isCorrect ? const Color(0xFF10B981) : const Color(0xFFEF4444),
                )
              else
                Icon(
                  Icons.remove_circle_outline,
                  size: 18,
                  color: isDark ? const Color(0xFF6B7280) : const Color(0xFF9CA3AF),
                ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Your Answer: ${isAttempted ? userAnswer : 'Not Attempted'}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isDark ? const Color(0xFFE5E5E5) : const Color(0xFF1F2937),
                  ),
                ),
              ),
            ],
          ),
        ),
        // Show correct answer if user was wrong or didn't attempt
        if (!isCorrect) ...[
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFF10B981).withValues(alpha: isDark ? 0.12 : 0.08),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: const Color(0xFF10B981).withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                const Icon(Icons.lightbulb_outline, size: 18, color: Color(0xFF10B981)),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Correct Answer: $correctAnswer',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isDark ? const Color(0xFFE5E5E5) : const Color(0xFF1F2937),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

class _ReviewOptionsSection extends StatelessWidget {
  const _ReviewOptionsSection({required this.question, required this.response});

  final Question question;
  final QuestionResponse? response;

  String _getOptionLabel(int index) => String.fromCharCode(65 + index);

  bool _isMultipleChoice() => question.correctOptionIndexes.length > 1;

  @override
  Widget build(BuildContext context) {
    // Get user's selected options from response
    final selectedOptions = response?.attemptedOptionIndexes ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_isMultipleChoice())
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _MultipleChoiceIndicator(),
          ),
        ...List.generate(
          question.options.length,
              (index) => Padding(
            padding: EdgeInsets.only(bottom: index < question.options.length - 1 ? 10 : 0),
            child: _ReviewOptionTile(
              option: question.options[index],
              optionLabel: _getOptionLabel(index),
              isCorrect: question.correctOptionIndexes.contains(index),
              isSelected: selectedOptions.contains(index),
              isMultipleChoice: _isMultipleChoice(),
            ),
          ),
        ),
      ],
    );
  }
}

class _MultipleChoiceIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
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
            'Multiple Choice Question',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: infoColor),
          ),
        ],
      ),
    );
  }
}

class _MarksAwarded extends StatelessWidget {
  const _MarksAwarded({required this.marksAwarded});

  final int marksAwarded;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = marksAwarded > 0
        ? const Color(0xFF10B981)
        : marksAwarded < 0
        ? const Color(0xFFEF4444)
        : const Color(0xFF6B7280);

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withValues(alpha: isDark ? 0.12 : 0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.3), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.stars_rounded, size: 18, color: color),
          const SizedBox(width: 8),
          Text(
            'Marks Awarded: $marksAwarded',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isDark ? const Color(0xFFE5E5E5) : const Color(0xFF1F2937),
            ),
          ),
        ],
      ),
    );
  }
}
