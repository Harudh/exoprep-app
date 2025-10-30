import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:root/src/core/common/ui/widgets/theme_toggle_switch.dart';
import 'package:root/src/core/extensions/context_extension.dart';

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
      backgroundColor: isDarkMode ? const Color(0xFF121212) : Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 200,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Text(
            'New project',
            style: context.headlineSmall?.copyWith(
              fontWeight: FontWeight.w600,
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
                color: context.isDarkMode
                    ? Colors.grey.shade800
                    : Colors.grey.shade100,
                border: Border.all(
                  color: context.isDarkMode
                      ? Colors.grey.shade700
                      : Colors.grey.shade300,
                ),
              ),
              child: const Icon(IonIcons.close, size: 22),
            ),
          ),
          const SizedBox(
            width: 12,
          ),
        ],
      ),
      body: const SafeArea(
        child: Column(
          children: [],
        ),
      ),
      floatingActionButton: const ThemeToggleSwitch(),
    );
  }
}
