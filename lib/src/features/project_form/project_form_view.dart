import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:root/src/core/common/state/viewmodel_state.dart';
import 'package:root/src/core/common/ui/overlays/toast.dart';
import 'package:root/src/core/extensions/context_extension.dart';
import 'package:root/src/features/project_form/project_form_viewmodel.dart';
import 'package:root/src/features/project_form/widgets/color_panel_picker.dart';
import 'package:root/src/features/project_form/widgets/project_name.dart';
import 'package:root/src/features/project_form/widgets/time_goal_section.dart';

part 'project_form_mixin.dart';

class ProjectFormView extends StatefulWidget {
  const ProjectFormView({super.key});

  @override
  State<ProjectFormView> createState() => _ProjectFormViewState();
}

class _ProjectFormViewState extends State<ProjectFormView>
    with ProductivityMixin {
  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.isDarkMode;

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              elevation: 0,
              pinned: true,
              leadingWidth: 200,
              leading: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
                child: Text(
                  'New project',
                  style: context.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
              ),
              actions: [
                GestureDetector(
                  onTap: () {
                    HapticFeedback.lightImpact();
                    ProjectViewModel.reset();
                    context.pop();
                  },
                  child: Container(
                    height: 36,
                    width: 36,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isDarkMode
                          ? Colors.grey.shade800
                          : Colors.grey.shade100,
                      border: Border.all(
                        color: isDarkMode
                            ? Colors.grey.shade700
                            : Colors.grey.shade300,
                      ),
                    ),
                    child: const Icon(IonIcons.close, size: 22),
                  ),
                ),
                const SizedBox(width: 12),
              ],
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 12),
            ),

            ProjectName(projectName: projectNameController),

            const SliverToBoxAdapter(child: TimeGoalWidget()),

            const SliverToBoxAdapter(
              child: ColorPickerPanel(),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: ValueListenableBuilder(
        valueListenable: viewModel.colorTag,
        builder: (context, value, child) {
          return ElevatedButton(
            onPressed: () {
              HapticFeedback.lightImpact();
              viewModel.saveProject(projectNameController.text);
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(14),
              ),
              fixedSize: Size(
                MediaQuery.widthOf(context) - 50,
                60,
              ),
              backgroundColor: Color(viewModel.colorTag.value),
            ),
            child: Text(
              'Save',
              style: context.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          );
        },
      ),
    );
  }
}
