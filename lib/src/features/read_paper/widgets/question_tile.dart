import 'package:flutter/material.dart';
import 'package:root/src/core/extensions/context_extension.dart';
import 'package:root/src/features/questions/questions_view.dart';
import 'package:root/src/models/question_model/question_model.dart';

class QuestionTile extends StatelessWidget {
  const QuestionTile({super.key, required this.question, required this.index});

  final Question question;
  final int index;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    bool _isNumericalQuestion() => question.answer != null && question.answer!.isNotEmpty;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A1A1A) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isDark ? const Color(0xFF2A2A2A) : const Color(0xFFE5E7EB), width: 1),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: (isDark ? const Color(0xFF818CF8) : context.colorScheme.primary).withValues(alpha: isDark ? 0.12 : 0.08),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              'Question $index',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isDark ? const Color(0xFF818CF8) : context.colorScheme.primary,
                letterSpacing: 0.4,
              ),
            ),
          ),

          const SizedBox(height: 16),
          QuestionTitle(title: question.title),
          if (question.image != null && question.image!.isNotEmpty) ...[
            const SizedBox(height: 16),
            QuestionImage(base64Image: question.image!),
          ],
          const SizedBox(height: 16),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: (isDark ? const Color(0xFF818CF8) : context.colorScheme.primary).withValues(alpha: isDark ? 0.12 : 0.08),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              'Answer ',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isDark ? const Color(0xFF818CF8) : context.colorScheme.primary,
                letterSpacing: 0.4,
              ),
            ),
          ),
          QuestionTitle(title: _isNumericalQuestion() ? question.answer! : question.options[question.correctOptionIndexes[0]]),
        ],
      ),
    );
  }
}
