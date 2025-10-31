import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:root/src/core/common/ui/widgets/theme_toggle_switch.dart';
import 'package:root/src/core/extensions/context_extension.dart';
import 'package:root/src/features/productivity/project_form/color_panel_picker.dart';
import 'package:root/src/features/productivity/project_form/project_name.dart';
import 'package:root/src/features/productivity/project_form/time_goal_section.dart';

class ProjectFormView extends StatefulWidget {
  const ProjectFormView({super.key});

  @override
  State<ProjectFormView> createState() => _ProjectFormViewState();
}

class _ProjectFormViewState extends State<ProjectFormView> {
  final TextEditingController _projectNameController = TextEditingController();

  @override
  void dispose() {
    _projectNameController.dispose();
    super.dispose();
  }

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

            ProjectName(projectName: _projectNameController),

            const SliverToBoxAdapter(child: TimeGoalWidget()),

            SliverToBoxAdapter(
              child: ColorPickerPanel(
                selectedColorValue: 0xFF42A5F5,
                onColorSelected: (colorValue) {
                  debugPrint('Selected color: $colorValue');
                  // Save to database here
                  // saveColorToDatabase(colorValue);
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: const ThemeToggleSwitch(),
    );
  }
}
