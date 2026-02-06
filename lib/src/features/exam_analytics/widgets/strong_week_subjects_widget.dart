import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:root/src/core/extensions/context_extension.dart';

class StrongWeekSubjectsCard extends StatefulWidget {
  final String title;
  final List<String> topics;
  final ScrollController scrollController;
  final double scrollOffset;

  const StrongWeekSubjectsCard({
    super.key,
    required this.title,
    required this.topics,
    required this.scrollController,
    this.scrollOffset = 100.0,
  });

  @override
  State<StrongWeekSubjectsCard> createState() => _StrongWeekSubjectsCardState();
}

class _StrongWeekSubjectsCardState extends State<StrongWeekSubjectsCard> {
  late ExpandableController _expandableController;

  @override
  void initState() {
    super.initState();
    _expandableController = ExpandableController(initialExpanded: true);
    _expandableController.addListener(_onExpandChange);
  }

  void _onExpandChange() {
    if (_expandableController.expanded) {
      Future.delayed(const Duration(milliseconds: 50), () {
        if (mounted) {
          adjustScroll(
            controller: widget.scrollController,
            pixels: widget.scrollOffset,
            duration: const Duration(milliseconds: 800),
          );
        }
      });
    }
  }

  @override
  void dispose() {
    _expandableController.removeListener(_onExpandChange);
    _expandableController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.topics.isEmpty) return const SizedBox.shrink();

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
        controller: _expandableController,
        child: ScrollOnExpand(
          scrollOnExpand: true,
          scrollOnCollapse: false,
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
                  Expanded(child: Text(widget.title, style: context.titleSmall)),
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
                  children: widget.topics.map((topic) {
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

void adjustScroll({
  bool animate = true,
  required double pixels,
  required ScrollController controller,
  Duration duration = const Duration(milliseconds: 300),
  Curve curve = Curves.easeInOut,
}) {
  if (!controller.hasClients) return;

  final double currentPos = controller.offset;
  final double maxScroll = controller.position.maxScrollExtent;
  final double minScroll = controller.position.minScrollExtent;

  final double targetPos = (currentPos + pixels).clamp(minScroll, maxScroll);

  if (animate) {
    controller.animateTo(targetPos, duration: duration, curve: curve);
  } else {
    controller.jumpTo(targetPos);
  }
}
