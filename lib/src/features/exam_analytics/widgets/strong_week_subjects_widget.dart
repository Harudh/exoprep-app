import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:root/src/core/extensions/context_extension.dart';

class SubjectsFlowCard extends StatelessWidget {
  final String title;
  final List<String> topics;

  const SubjectsFlowCard({super.key, required this.title, required this.topics});

  @override
  Widget build(BuildContext context) {
    if (topics.isEmpty) return const SizedBox.shrink();

    // Define colors based on theme once for cleaner code
    final borderColor = context.isDarkMode ? Colors.grey.shade800 : Colors.grey.shade300;
    final cardColor = context.isDarkMode ? Colors.grey.shade900 : Colors.white;
    final chipColor = context.isDarkMode ? Colors.grey.shade800 : Colors.grey.shade100;
    final chipBorderColor = context.isDarkMode ? Colors.grey.shade400 : Colors.grey.shade300;
    final iconColor = context.isDarkMode ? Colors.white70 : Colors.black54;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: cardColor,
        border: Border.all(color: borderColor),
      ),
      child: ExpandableNotifier(
        initialExpanded: false,
        child: ScrollOnExpand(
          child: ExpandablePanel(
            theme: const ExpandableThemeData(
              headerAlignment: ExpandablePanelHeaderAlignment.center,
              tapBodyToCollapse: false,
              tapHeaderToExpand: true,
              animationDuration: Duration(milliseconds: 800),
              scrollAnimationDuration: Duration(milliseconds: 800),
              fadeCurve: Curves.easeInOut,
              sizeCurve: Curves.easeInOut,
              hasIcon: false,
            ),
            header: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  Expanded(child: Text(title, style: context.titleSmall)),
                  ExpandableIcon(
                    theme: ExpandableThemeData(
                      expandIcon: Icons.keyboard_arrow_down_rounded,
                      collapseIcon: Icons.keyboard_arrow_up_rounded,
                      iconColor: iconColor,
                      iconSize: 24,
                      iconRotationAngle: 3.14159,
                      iconPadding: EdgeInsets.zero,
                    ),
                  ),
                ],
              ),
            ),
            collapsed: const SizedBox.shrink(),
            expanded: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: SizedBox(
                width: double.infinity,
                child: Wrap(
                  spacing: 6,
                  runSpacing: 8,
                  children: topics.map((topic) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        border: Border.all(color: chipBorderColor, width: 0.4),
                        color: chipColor,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Text(
                        topic,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: context.isDarkMode ? Colors.white : Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
