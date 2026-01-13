import 'package:flutter/material.dart';
import 'package:root/src/core/extensions/context_extension.dart';
import 'package:root/src/features/select_exams/widgets/exam_chip_list.dart';
import 'package:root/src/models/exam_model/exam_model.dart';

class ExamCategorySection extends StatelessWidget {
  final String title;
  final List<Exam> exams;
  final bool Function(String id) isSelected;
  final void Function(String id) toggleExam;

  const ExamCategorySection({
    required this.title,
    required this.exams,
    required this.isSelected,
    required this.toggleExam,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: context.titleMedium),
          const SizedBox(height: 12),
          ExamChipList(exams: exams, isSelected: isSelected, toggleExam: toggleExam),
        ],
      ),
    );
  }
}
