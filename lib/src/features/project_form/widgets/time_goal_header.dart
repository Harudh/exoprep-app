import 'package:flutter/material.dart';
import 'package:root/src/core/extensions/context_extension.dart';
import 'package:root/src/features/project_form/project_form_viewmodel.dart';

class TimeGoalHeader extends StatelessWidget {
  final bool isEnabled;

  final ValueChanged<bool> onToggle;

  const TimeGoalHeader({
    required this.isEnabled,
    required this.onToggle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.isDarkMode;
    final viewModel = ProjectViewModel();
    return ValueListenableBuilder(
      valueListenable: viewModel.colorTag,
      builder: (context, value, child) {
        return Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: Color(viewModel.colorTag.value),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.ads_click,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Text('Time Goal', style: context.titleLarge),
            const Spacer(),
            Switch(
              value: isEnabled,
              onChanged: onToggle,
              activeThumbColor: Colors.white,
              activeTrackColor: Color(viewModel.colorTag.value),
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: isDarkMode
                  ? Colors.grey.shade700
                  : Colors.grey.shade300,
              trackOutlineColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return isDarkMode
                      ? Colors.grey.shade800
                      : Colors.grey.shade200;
                }
                return isDarkMode ? Colors.grey.shade600 : Colors.grey.shade400;
              }),
            ),
          ],
        );
      },
    );
  }
}
