import 'package:flutter/material.dart';
import 'package:root/src/core/extensions/context_extension.dart';
import 'package:root/src/core/theme/colors.dart';
import 'package:root/src/models/exam_model/exam_model.dart';

class ExamChipList extends StatelessWidget {
  final List<Exam> exams;
  final bool Function(String id) isSelected;
  final void Function(String id) toggleExam;

  const ExamChipList({required this.exams, required this.isSelected, required this.toggleExam, super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: exams.map((exam) {
        final selected = isSelected(exam.id);
        return FilterChip(
          label: Text(
            exam.name,
            style: TextStyle(
              color: selected ? Colors.white : (isDark ? Colors.grey[400] : Colors.grey[800]),
              fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
          selected: selected,
          onSelected: (_) => toggleExam(exam.id),
          selectedColor: AppColors.primaryColor,
          backgroundColor: isDark ? Colors.transparent : Colors.grey.shade100,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: selected ? Colors.blue : (isDark ? Colors.grey.shade700 : Colors.grey.shade300)),
          ),
          showCheckmark: false,
        );
      }).toList(),
    );
  }
}
