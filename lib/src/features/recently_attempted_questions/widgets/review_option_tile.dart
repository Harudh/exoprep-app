part of '../recently_attempted_questions_view.dart';

class _ReviewOptionTile extends StatelessWidget {
  const _ReviewOptionTile({
    required this.option,
    required this.optionLabel,
    required this.isCorrect,
    required this.isSelected,
    required this.isMultipleChoice,
  });

  final String option;
  final String optionLabel;
  final bool isCorrect;
  final bool isSelected;
  final bool isMultipleChoice;

  bool _isHtml(String text) {
    return text.trim().startsWith('<') && text.trim().contains('>');
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    Color borderColor;
    Color backgroundColor;
    Color textColor = isDark ? const Color(0xFFE5E5E5) : const Color(0xFF1F2937);

    // Determine colors based on correctness and selection
    if (isCorrect) {
      // Correct answer - always show as green
      borderColor = const Color(0xFF10B981);
      backgroundColor = const Color(0xFF10B981).withValues(alpha: isDark ? 0.12 : 0.08);
    } else if (isSelected && !isCorrect) {
      // User selected wrong answer - show as red
      borderColor = const Color(0xFFEF4444);
      backgroundColor = const Color(0xFFEF4444).withValues(alpha: isDark ? 0.12 : 0.08);
    } else {
      // Not selected, not correct - neutral
      borderColor = isDark ? const Color(0xFF2A2A2A) : const Color(0xFFE5E7EB);
      backgroundColor = Colors.transparent;
    }

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: borderColor,
          width: (isCorrect || (isSelected && !isCorrect)) ? 1.5 : 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ReviewOptionSelector(
            label: optionLabel,
            isCorrect: isCorrect,
            isSelected: isSelected,
            isMultipleChoice: isMultipleChoice,
            borderColor: borderColor,
            isDark: isDark,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _isHtml(option)
                ? Html(
              data: option,
              style: {
                "body": Style(
                  margin: Margins.zero,
                  padding: HtmlPaddings.zero,
                  fontSize: FontSize(14),
                  fontWeight: FontWeight.normal,
                  lineHeight: LineHeight(1.5),
                  color: textColor,
                ),
                "p": Style(
                  margin: Margins.zero,
                  padding: HtmlPaddings.zero,
                  fontSize: FontSize(14),
                  lineHeight: LineHeight(1.5),
                  color: textColor,
                ),
                "strong": Style(fontWeight: FontWeight.bold, color: textColor),
                "b": Style(fontWeight: FontWeight.bold, color: textColor),
                "em": Style(fontStyle: FontStyle.italic, color: textColor),
                "i": Style(fontStyle: FontStyle.italic, color: textColor),
                "u": Style(textDecoration: TextDecoration.underline, color: textColor),
              },
            )
                : Text(
              option,
              style: TextStyle(
                fontSize: 14,
                height: 1.5,
                color: textColor,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          const SizedBox(width: 8),
          if (isCorrect)
            const Icon(Icons.check_circle, size: 18, color: Color(0xFF10B981))
          else if (isSelected && !isCorrect)
            const Icon(Icons.cancel, size: 18, color: Color(0xFFEF4444)),
        ],
      ),
    );
  }
}

class _ReviewOptionSelector extends StatelessWidget {
  const _ReviewOptionSelector({
    required this.label,
    required this.isCorrect,
    required this.isSelected,
    required this.isMultipleChoice,
    required this.borderColor,
    required this.isDark,
  });

  final String label;
  final bool isCorrect;
  final bool isSelected;
  final bool isMultipleChoice;
  final Color borderColor;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color iconColor;
    Color labelColor;

    if (isCorrect) {
      backgroundColor = const Color(0xFF10B981);
      iconColor = Colors.white;
      labelColor = Colors.white;
    } else if (isSelected && !isCorrect) {
      backgroundColor = const Color(0xFFEF4444);
      iconColor = Colors.white;
      labelColor = Colors.white;
    } else {
      backgroundColor = Colors.transparent;
      iconColor = isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280);
      labelColor = isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280);
    }

    if (isMultipleChoice) {
      return Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: borderColor, width: 1.5),
        ),
        child: Center(
          child: (isCorrect || (isSelected && !isCorrect))
              ? Icon(
            isCorrect ? Icons.check : Icons.close,
            size: 16,
            color: iconColor,
          )
              : Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12,
              color: labelColor,
            ),
          ),
        ),
      );
    }

    // Single choice (radio button style)
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
        border: Border.all(color: borderColor, width: 1.5),
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 12,
            color: labelColor,
          ),
        ),
      ),
    );
  }
}
