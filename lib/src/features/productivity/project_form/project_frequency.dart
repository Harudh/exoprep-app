import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:root/src/core/common/ui/widgets/cupertino_date_bottomsheet.dart';
import 'package:root/src/core/extensions/context_extension.dart';

class FrequencyTabBarWithContent extends StatefulWidget {
  const FrequencyTabBarWithContent({
    super.key,
  });

  @override
  State<FrequencyTabBarWithContent> createState() =>
      _FrequencyTabBarWithContentState();
}

class _FrequencyTabBarWithContentState extends State<FrequencyTabBarWithContent>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      HapticFeedback.lightImpact();
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.isDarkMode;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 44,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: isDarkMode ? const Color(0xFF1F1F1F) : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(12),
          ),
          child: TabBar(
            controller: _tabController,
            indicator: BoxDecoration(
              color: isDarkMode ? const Color(0xFF3A3A3A) : Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            indicatorSize: TabBarIndicatorSize.tab,
            dividerColor: Colors.transparent,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white.withValues(alpha: 0.6),
            labelStyle: context.bodyLarge,
            tabs: [
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.repeat,
                      size: 20,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Repeating',
                      style: context.bodyLarge,
                    ),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.flag_outlined,
                      size: 20,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'One Time',
                      style: context.bodyLarge,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        AnimatedBuilder(
          animation: _tabController,
          builder: (context, child) {
            return _tabController.index == 0
                ? const RepeatingContent(key: ValueKey('repeating'))
                : const OneTimeContent(key: ValueKey('onetime'));
          },
        ),
      ],
    );
  }
}

class RepeatingContent extends StatefulWidget {
  const RepeatingContent({super.key});

  @override
  State<RepeatingContent> createState() => _RepeatingContentState();
}

class _RepeatingContentState extends State<RepeatingContent>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.isDarkMode;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 42,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: isDarkMode ? const Color(0xFF1F1F1F) : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(12),
          ),
          child: TabBar(
            controller: _tabController,
            indicator: BoxDecoration(
              color: isDarkMode ? const Color(0xFF3A3A3A) : Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            indicatorSize: TabBarIndicatorSize.tab,
            dividerColor: Colors.transparent,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white.withValues(alpha: 0.6),
            labelStyle: context.bodyLarge,
            tabs: [
              Tab(
                child: Text(
                  'Daily',
                  style: context.bodyLarge,
                ),
              ),
              Tab(
                child: Text(
                  'Weekly',
                  style: context.bodyLarge,
                ),
              ),
              Tab(
                child: Text(
                  'Monthly',
                  style: context.bodyLarge,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class OneTimeContent extends StatefulWidget {
  const OneTimeContent({super.key});

  @override
  State<OneTimeContent> createState() => _OneTimeContentState();
}

class _OneTimeContentState extends State<OneTimeContent> {
  late ExpandableController _controller;
  bool isDeadlineDateSet = false;

  @override
  void initState() {
    _controller = ExpandableController(initialExpanded: isDeadlineDateSet);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleDeadlineButton(bool value) {
    setState(() {
      isDeadlineDateSet = value;
      _controller.expanded = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.isDarkMode;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Start Date',
          style: context.titleMedium!.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 8),
        GestureDetector(
          onTap: () {
            HapticFeedback.lightImpact();
            showDatePickerBottomSheet(
              context: context,
              title: 'Start Date',
              initialDate: DateTime.now(),
              onDateSelected: (date) {
                debugPrint(
                  'Selected date: ${date.day}/${date.month}/${date.year}',
                );
              },
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: isDarkMode
                  ? const Color(0xFF3A3A3A)
                  : Colors.grey.shade300,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('1h 00m', style: context.bodyLarge),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: isDarkMode
                      ? Colors.grey.shade300
                      : Colors.grey.shade500,
                  size: 28,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),

        ExpandablePanel(
          controller: _controller,
          theme: const ExpandableThemeData(
            hasIcon: false,
            tapBodyToCollapse: false,
            tapBodyToExpand: false,
            animationDuration: Duration(milliseconds: 500),
          ),
          header: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Deadline Date',
                style: context.titleMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),

              Switch(
                value: isDeadlineDateSet,
                onChanged: _toggleDeadlineButton,
                activeThumbColor: Colors.white,
                activeTrackColor: const Color(0xFF34C759),
                inactiveThumbColor: Colors.white,
                inactiveTrackColor: Colors.grey.shade700,
              ),
            ],
          ),
          collapsed: const SizedBox.shrink(),

          expanded: GestureDetector(
            onTap: () {
              HapticFeedback.lightImpact();
              showDatePickerBottomSheet(
                context: context,
                title: 'Start Date',
                initialDate: DateTime.now(),
                onDateSelected: (date) {
                  debugPrint(
                    'Selected date: ${date.day}/${date.month}/${date.year}',
                  );
                },
              );
            },
            child: Container(
              margin: const EdgeInsets.only(top: 8),
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: isDarkMode
                    ? const Color(0xFF3A3A3A)
                    : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('1h 00m', style: context.bodyLarge),
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: isDarkMode
                        ? Colors.grey.shade300
                        : Colors.grey.shade500,
                    size: 28,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
