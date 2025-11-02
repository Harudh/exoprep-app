import 'package:flutter/material.dart';
import 'package:root/src/core/extensions/context_extension.dart';

class ProjectName extends StatelessWidget {
  const ProjectName({required this.projectName, super.key});

  final TextEditingController projectName;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.isDarkMode;

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: TextField(
          controller: projectName,
          style: context.titleMedium?.copyWith(
            color: isDarkMode ? Colors.white : Colors.black,
          ),
          decoration: InputDecoration(
            hintText: 'Project name',
            hintStyle: context.titleMedium!.copyWith(
              color: isDarkMode ? Colors.grey.shade600 : Colors.grey.shade500,
              fontWeight: FontWeight.w600,
            ),

            filled: true,
            fillColor: isDarkMode
                ? const Color(0xFF2A2A2A)
                : Colors.grey.shade100,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 16,
            ),
          ),
        ),
      ),
    );
  }
}
