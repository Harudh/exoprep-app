import 'package:root/src/features/select_exams/widgets/exam_category_section.dart';
import 'package:root/src/features/select_exams/select_exams_viewmodel.dart';
import 'package:root/src/core/common/ui/widgets/theme_toggle_switch.dart';
import 'package:root/src/core/extensions/context_extension.dart';
import 'package:root/src/core/common/state/viewmodel_state.dart';
import 'package:root/src/core/common/ui/overlays/toast.dart';
import 'package:root/src/models/exam_model/exam_model.dart';
import 'package:root/src/core/navigation/routes.dart';
import 'package:root/src/core/constants/enums.dart';
import 'package:root/src/core/theme/colors.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

part 'select_exams_mixin.dart';

class SelectExamsView extends StatefulWidget {
  const SelectExamsView({super.key});

  @override
  State<SelectExamsView> createState() => _SelectExamsViewState();
}

class _SelectExamsViewState extends State<SelectExamsView> with SelectExamsMixin {
  @override
  Widget build(BuildContext context) {
    final noChildren = exams.where((e) => e.children.isEmpty).toList();
    final withChildren = exams.where((e) => e.children.isNotEmpty).toList();
    final isDark = context.isDarkMode;

    final hasSelection = selectedExamIds.isNotEmpty;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            actions: const [ThemeToggleSwitch()],
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Select Exam',
                style: context.titleLarge?.copyWith(fontWeight: FontWeight.w600, color: isDark ? Colors.white : Colors.grey[900]),
              ),
              centerTitle: false,
              expandedTitleScale: 1,
            ),
            floating: true,
            pinned: true,
            elevation: 0,
            surfaceTintColor: Colors.transparent,
          ),
          if (noChildren.isEmpty && withChildren.isEmpty)
            const SliverFillRemaining(hasScrollBody: false, child: Center(child: CupertinoActivityIndicator()))
          else
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  if (noChildren.isNotEmpty)
                    ExamCategorySection(
                      title: "EXAM CATEGORIES",
                      exams: noChildren,
                      isSelected: isSelected,
                      toggleExam: toggleExam,
                    ),
                  for (final parentExam in withChildren)
                    ExamCategorySection(
                      title: parentExam.name,
                      exams: parentExam.children,
                      isSelected: isSelected,
                      toggleExam: toggleExam,
                    ),
                ]),
              ),
            ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 36),
        child: GestureDetector(
          onTap: hasSelection ? () => _viewModel.handleSelectedExams(selectedExamIds.toList()) : null,
          child: Container(
            height: 56,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: hasSelection ? AppColors.primaryColor : (isDark ? Colors.grey.shade800 : Colors.grey.shade300),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Center(
              child: ValueListenableBuilder(
                valueListenable: _viewModel.selectExamState,
                builder: (context, value, child) {
                  if (value.status == ViewModelStatus.loading) {
                    return const CupertinoActivityIndicator(color: Colors.white);
                  }
                  return Text(
                    "Continue",
                    style: context.titleMedium!.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/*
SizedBox(
          height: 48,
          width: double.infinity,
          child: Container(
            // onPressed: hasSelection ? () => _viewModel.handleSelectedExams(selectedExamIds.toList()) : null,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Center(
              child: const Text(
                'Continue',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
            ),
          ),
        ),
*/
