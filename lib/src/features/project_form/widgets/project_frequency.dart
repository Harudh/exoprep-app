import 'dart:developer';

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:root/src/core/common/ui/widgets/cupertino_date_bottomsheet.dart';
import 'package:root/src/core/constants/enums.dart';
import 'package:root/src/core/extensions/context_extension.dart';
import 'package:root/src/features/project_form/project_form_viewmodel.dart';

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
  final viewmodel = ProjectViewModel();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      HapticFeedback.lightImpact();

      if (_tabController.index == 0) {
        viewmodel.frequencyType.value = TimeGoalFrequency.recurring;
      } else {
        viewmodel.frequencyType.value = TimeGoalFrequency.onetime;
      }

      log('Frequency is : ${viewmodel.frequencyType.value}');
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
  final viewmodel = ProjectViewModel();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    _tabController.addListener(() {
      HapticFeedback.lightImpact();

      if (_tabController.index == 0) {
        viewmodel.repeatingFrequency.value = TimeGoalRepeatingFrequency.daily;
      } else if (_tabController.index == 1) {
        viewmodel.repeatingFrequency.value = TimeGoalRepeatingFrequency.weekly;
      } else {
        viewmodel.repeatingFrequency.value = TimeGoalRepeatingFrequency.monthly;
      }

      log('Repeating frequency: ${viewmodel.repeatingFrequency.value}');
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
    return Container(
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
  final viewModel = ProjectViewModel();

  @override
  void initState() {
    super.initState();
    _controller = ExpandableController(
      initialExpanded: viewModel.oneTimeHasDeadline.value,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleDeadlineButton(bool value) {
    viewModel.oneTimeHasDeadline.value = value;
    _controller.expanded = value;

    log('Has deadline: $value');
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
        ValueListenableBuilder<DateTime>(
          valueListenable: viewModel.oneTimeGoalStartDate,
          builder: (context, startDate, child) {
            return GestureDetector(
              onTap: () {
                HapticFeedback.lightImpact();
                showDatePickerBottomSheet(
                  context: context,
                  title: 'Start Date',
                  initialDate: startDate,
                  onDateSelected: (date) {
                    viewModel.oneTimeGoalStartDate.value = date;
                    log('Start date: ${date.day}/${date.month}/${date.year}');
                  },
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
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
                    Text(
                      '${startDate.day}/${startDate.month}/${startDate.year}',
                      style: context.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
            );
          },
        ),
        const SizedBox(height: 16),
        ValueListenableBuilder<bool>(
          valueListenable: viewModel.oneTimeHasDeadline,
          builder: (context, hasDeadline, child) {
            return ExpandablePanel(
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
                    value: hasDeadline,
                    onChanged: _toggleDeadlineButton,
                    activeThumbColor: Colors.white,
                    activeTrackColor: Color(viewModel.colorTag.value),
                    inactiveThumbColor: Colors.white,
                    inactiveTrackColor: isDarkMode
                        ? Colors.grey.shade700
                        : Colors.grey.shade300,
                    trackOutlineColor: WidgetStateProperty.resolveWith((
                      states,
                    ) {
                      if (states.contains(WidgetState.selected)) {
                        return isDarkMode
                            ? Colors.grey.shade800
                            : Colors.grey.shade200;
                      }
                      return isDarkMode
                          ? Colors.grey.shade600
                          : Colors.grey.shade400;
                    }),
                  ),
                ],
              ),
              collapsed: const SizedBox.shrink(),
              expanded: ValueListenableBuilder<DateTime>(
                valueListenable: viewModel.oneTimeDeadlineDate,
                builder: (context, deadlineDate, child) {
                  return GestureDetector(
                    onTap: () {
                      HapticFeedback.lightImpact();
                      showDatePickerBottomSheet(
                        context: context,
                        title: 'Deadline Date',
                        initialDate: deadlineDate,
                        onDateSelected: (date) {
                          viewModel.oneTimeDeadlineDate.value = date;
                          log(
                            'Deadline date: ${date.day}/${date.month}/${date.year}',
                          );
                        },
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(top: 12),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
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
                          Text(
                            '${deadlineDate.day}/${deadlineDate.month}/${deadlineDate.year}',
                            style: context.bodyLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
