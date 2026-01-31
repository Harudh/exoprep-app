part of '../exam_dashboard_view.dart';

class StreakSection extends StatelessWidget {
  final ExamDashboardViewModel viewModel;

  const StreakSection({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: ValueListenableBuilder<ViewModelState<dynamic>>(
        valueListenable: viewModel.streakState,
        builder: (context, state, child) {
          if (state.status == ViewModelStatus.loading) {
            return _StreakLoadingWidget();
          }

          if (state.status == ViewModelStatus.error) {
            return _StreakContentWidget(streakData: null);
          }

          return ValueListenableBuilder<StreakHeatmapModel?>(
            valueListenable: viewModel.streakData,
            builder: (context, streakData, _) {
              return _StreakContentWidget(streakData: streakData);
            },
          );
        },
      ),
    );
  }
}

class _StreakContentWidget extends StatefulWidget {
  final StreakHeatmapModel? streakData;

  const _StreakContentWidget({this.streakData});

  @override
  State<_StreakContentWidget> createState() => _StreakContentWidgetState();
}

class _StreakContentWidgetState extends State<_StreakContentWidget> with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _animationController;
  late Animation<double> _expandAnimation;
  late Animation<double> _iconRotation;
  late int _selectedYear;

  @override
  void initState() {
    super.initState();
    _selectedYear = DateTime.now().year;
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 250));
    _expandAnimation = CurvedAnimation(parent: _animationController, curve: Curves.easeInOutCubic);
    _iconRotation = Tween<double>(
      begin: 0,
      end: 0.5,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOutCubic));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  List<int> _getAvailableYears() {
    final currentYear = DateTime.now().year;
    final startYear = widget.streakData?.streakStartDate.year ?? currentYear;
    return List.generate(currentYear - startYear + 1, (index) => startYear + index).reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final hasData = widget.streakData != null && widget.streakData!.totalAttempts > 0;

    // Use zero values if no data
    final currentStreak = widget.streakData?.currentStreak ?? 0;
    final longestStreak = widget.streakData?.longestStreak ?? 0;
    final totalAttempts = widget.streakData?.totalAttempts ?? 0;
    final activeDays = widget.streakData?.calendar.length ?? 0;
    final calendarData = widget.streakData?.calendar ?? {};

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: ExamDashboardView.horizontalPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: isDark ? Colors.grey.shade900 : Colors.white,
        border: Border.all(color: isDark ? Colors.grey.shade800 : Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              splashFactory: NoSplash.splashFactory,
              onTap: hasData ? _toggleExpansion : null,
              borderRadius: BorderRadius.circular(16),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: _MinimalStreakItem(
                            icon: Icons.local_fire_department_rounded,
                            iconColor: const Color(0xFFFF6B35),
                            value: currentStreak,
                            label: 'Current Streak',
                            isDark: isDark,
                          ),
                        ),

                        Container(
                          width: 1,
                          height: 44,
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
                        ),

                        Expanded(
                          child: _MinimalStreakItem(
                            icon: Icons.emoji_events_rounded,
                            iconColor: const Color(0xFFFFC107),
                            value: longestStreak,
                            label: 'Best Streak',
                            isDark: isDark,
                          ),
                        ),
                      ],
                    ),

                    if (hasData) ...[
                      const SizedBox(height: 14),
                      AnimatedBuilder(
                        animation: _iconRotation,
                        builder: (context, child) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                _isExpanded ? 'Hide Activity' : 'View Activity',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: isDark ? Colors.grey.shade500 : Colors.grey.shade600,
                                  letterSpacing: 0.2,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Transform.rotate(
                                angle: _iconRotation.value * 3.14159 * 2,
                                child: Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  size: 18,
                                  color: isDark ? Colors.grey.shade500 : Colors.grey.shade600,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ] else ...[
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          color: isDark ? Colors.grey.shade800 : Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: isDark ? Colors.grey.shade800 : Colors.grey.shade200, width: 1),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.info_outline_rounded,
                              size: 16,
                              color: isDark ? Colors.grey.shade500 : Colors.grey.shade600,
                            ),
                            const SizedBox(width: 8),
                            Flexible(
                              child: Text(
                                'No data available. Attempt papers to build your streak!',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: isDark ? Colors.grey.shade500 : Colors.grey.shade600,
                                  overflow: TextOverflow.ellipsis,
                                  letterSpacing: 0.1,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),

          if (hasData)
            SizeTransition(
              sizeFactor: _expandAnimation,
              axisAlignment: -1.0,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    height: 1,
                    color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Builder(
                              builder: (BuildContext context) {
                                return Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () => _showYearPicker(context, isDark),
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                      decoration: BoxDecoration(
                                        color: isDark ? Colors.grey.shade800 : Colors.grey.shade50,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(color: isDark ? Colors.grey.shade800 : Colors.grey.shade200, width: 1),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            _selectedYear.toString(),
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                              color: isDark ? Colors.white : Colors.grey.shade900,
                                            ),
                                          ),
                                          const SizedBox(width: 4),
                                          Icon(
                                            Icons.arrow_drop_down_rounded,
                                            color: isDark ? Colors.grey.shade400 : Colors.grey.shade700,
                                            size: 20,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),

                            Row(
                              children: [
                                _CompactStat(label: 'Total \nAttempts', value: totalAttempts.toString(),),
                                const SizedBox(width: 12),
                                _CompactStat(label: 'Days \nActive', value: activeDays.toString(),),
                                // const SizedBox(width: 24),
                              ],
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        _GitHubStyleHeatmap(calendarData: calendarData, selectedYear: _selectedYear, isDark: isDark),

                        const SizedBox(height: 16),

                        _MinimalLegend(isDark: isDark),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  void _showYearPicker(BuildContext context, bool isDark) {
    final availableYears = _getAvailableYears();
    final RenderBox button = context.findRenderObject() as RenderBox;
    final RenderBox overlay = Navigator.of(context).overlay!.context.findRenderObject() as RenderBox;
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(Offset.zero, ancestor: overlay),
        button.localToGlobal(button.size.bottomRight(Offset.zero), ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );

    showMenu<int>(
      context: context,
      position: position,
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: isDark ? Colors.grey.shade900 : Colors.white,
      constraints: const BoxConstraints(maxWidth: 160),
      items: availableYears.map((year) {
        final isSelected = year == _selectedYear;
        return PopupMenuItem<int>(
          value: year,
          height: 44,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                year.toString(),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  color: isSelected
                      ? (isDark ? Colors.white : Colors.grey.shade900)
                      : (isDark ? Colors.grey.shade400 : Colors.grey.shade700),
                ),
              ),
              if (isSelected) Icon(Icons.check_rounded, color: const Color(0xFF10B981), size: 18),
            ],
          ),
        );
      }).toList(),
    ).then((selectedYear) {
      if (selectedYear != null && selectedYear != _selectedYear) {
        setState(() {
          _selectedYear = selectedYear;
        });
      }
    });
  }
}

class _CompactStat extends StatelessWidget {
  final String label;
  final String value;

  const _CompactStat({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isDark ? Colors.grey.shade800: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: isDark ? Colors.white : Colors.grey.shade900,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 9,
              height: 0,
              fontWeight: FontWeight.w500,
              color: isDark ? Colors.grey.shade500 : Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}

class _GitHubStyleHeatmap extends StatelessWidget {
  final Map<String, CalendarDayData> calendarData;
  final int selectedYear;
  final bool isDark;

  const _GitHubStyleHeatmap({required this.calendarData, required this.selectedYear, required this.isDark});

  Color _getIntensityColor(int attempts) {
    if (attempts == 0) {
      return isDark ? const Color(0xFF1A1A1A) : const Color(0xFFEBEDF0);
    }

    if (attempts >= 5) {
      return const Color(0xFF0D9668);
    } else if (attempts >= 3) {
      return const Color(0xFF26A269);
    } else if (attempts >= 2) {
      return const Color(0xFF57D9A3);
    } else {
      return const Color(0xFF9BE9A8);
    }
  }

  List<DateTime> _getYearDates() {
    final startDate = DateTime(selectedYear, 1, 1);
    final endDate = DateTime(selectedYear, 12, 31);
    final daysDiff = endDate.difference(startDate).inDays + 1;

    return List.generate(daysDiff, (index) => startDate.add(Duration(days: index)));
  }

  List<List<DateTime?>> _organizeIntoWeeks() {
    final yearDates = _getYearDates();
    final weeks = <List<DateTime?>>[];

    final firstDate = yearDates.first;
    final startWeekday = firstDate.weekday;

    final firstWeek = List<DateTime?>.filled(7, null);
    for (int i = startWeekday - 1; i < 7 && (i - startWeekday + 1) < yearDates.length; i++) {
      firstWeek[i] = yearDates[i - startWeekday + 1];
    }
    weeks.add(firstWeek);

    int currentIndex = 7 - startWeekday + 1;
    while (currentIndex < yearDates.length) {
      final week = <DateTime?>[];
      for (int i = 0; i < 7; i++) {
        if (currentIndex < yearDates.length) {
          week.add(yearDates[currentIndex]);
          currentIndex++;
        } else {
          week.add(null);
        }
      }
      weeks.add(week);
    }

    return weeks;
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  String _formatDateDisplay(DateTime date) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final weeks = _organizeIntoWeeks();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: weeks.map((week) {
              return Padding(
                padding: const EdgeInsets.only(right: 2),
                child: Column(
                  children: week.map((date) {
                    if (date == null) {
                      return Container(width: 11, height: 11, margin: const EdgeInsets.only(bottom: 2));
                    }

                    final dateKey = _formatDate(date);
                    final dayData = calendarData[dateKey];
                    final attempts = dayData?.attempts ?? 0;
                    final avgScore = dayData?.avgScore ?? 0.0;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 2),
                      child: Tooltip(
                        message: attempts > 0
                            ? '${_formatDateDisplay(date)}\n$attempts attempt${attempts > 1 ? 's' : ''}\nAvg: ${avgScore.toStringAsFixed(1)}'
                            : '${_formatDateDisplay(date)}\nNo attempts',
                        textStyle: const TextStyle(fontSize: 10, color: Colors.white),
                        decoration: BoxDecoration(
                          color: isDark ? Colors.grey.shade800 : Colors.grey.shade900,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Container(
                          width: 11,
                          height: 11,
                          decoration: BoxDecoration(
                            color: _getIntensityColor(attempts),
                            borderRadius: BorderRadius.circular(2),
                            border: attempts > 0
                                ? null
                                : Border.all(color: isDark ? Colors.grey.shade800 : Colors.grey.shade300, width: 0.5),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class _MinimalStreakItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final int value;
  final String label;
  final bool isDark;

  const _MinimalStreakItem({
    required this.icon,
    required this.iconColor,
    required this.value,
    required this.label,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: iconColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
          child: Icon(icon, color: iconColor, size: 24),
        ),
        const SizedBox(width: 12),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value.toString(),
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: isDark ? Colors.white : Colors.grey.shade900,
                  height: 1.2,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: isDark ? Colors.grey.shade500 : Colors.grey.shade600,
                  letterSpacing: 0.2,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MinimalLegend extends StatelessWidget {
  final bool isDark;

  const _MinimalLegend({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          'Less',
          style: TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.w500,
            color: isDark ? Colors.grey.shade600 : Colors.grey.shade500,
            letterSpacing: 0.2,
          ),
        ),
        const SizedBox(width: 4),
        ...[
          const Color(0xFFEBEDF0),
          const Color(0xFF9BE9A8),
          const Color(0xFF57D9A3),
          const Color(0xFF26A269),
          const Color(0xFF0D9668),
        ].map((color) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1.5),
            child: Container(
              width: 11,
              height: 11,
              decoration: BoxDecoration(
                color: isDark && color == const Color(0xFFEBEDF0) ? const Color(0xFF1A1A1A) : color,
                borderRadius: BorderRadius.circular(2),
                border: color == const Color(0xFFEBEDF0)
                    ? Border.all(color: isDark ? Colors.grey.shade800 : Colors.grey.shade300, width: 0.5)
                    : null,
              ),
            ),
          );
        }),
        const SizedBox(width: 4),
        Text(
          'More',
          style: TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.w500,
            color: isDark ? Colors.grey.shade600 : Colors.grey.shade500,
            letterSpacing: 0.2,
          ),
        ),
      ],
    );
  }
}

class _StreakLoadingWidget extends StatefulWidget {
  @override
  State<_StreakLoadingWidget> createState() => _StreakLoadingWidgetState();
}

class _StreakLoadingWidgetState extends State<_StreakLoadingWidget> with SingleTickerProviderStateMixin {
  late AnimationController _shimmerController;
  late Animation<double> _shimmerAnimation;

  @override
  void initState() {
    super.initState();
    _shimmerController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500));
    _shimmerAnimation = Tween<double>(
      begin: -2.0,
      end: 2.0,
    ).animate(CurvedAnimation(parent: _shimmerController, curve: Curves.easeInOutSine));
    _shimmerController.repeat();
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  double _getShimmerStop(double value) {
    return (value + 2) / 4;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final baseColor = isDark ? Colors.grey.shade800 : Colors.grey.shade300;
    final highlightColor = isDark ? Colors.grey.shade700 : Colors.grey.shade100;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: ExamDashboardView.horizontalPadding),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey.shade900 : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isDark ? Colors.grey.shade800 : Colors.grey.shade200, width: 1),
      ),
      child: AnimatedBuilder(
        animation: _shimmerAnimation,
        builder: (context, child) {
          return ShaderMask(
            blendMode: BlendMode.srcATop,
            shaderCallback: (bounds) {
              return LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [baseColor, highlightColor, baseColor],
                stops: [
                  _getShimmerStop(_shimmerAnimation.value - 1),
                  _getShimmerStop(_shimmerAnimation.value),
                  _getShimmerStop(_shimmerAnimation.value + 1),
                ],
              ).createShader(bounds);
            },
            child: child,
          );
        },
        child: Row(
          children: [
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(color: baseColor, borderRadius: BorderRadius.circular(12)),
                  ),
                  const SizedBox(width: 12),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 40,
                          height: 20,
                          decoration: BoxDecoration(color: baseColor, borderRadius: BorderRadius.circular(4)),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          width: 80,
                          height: 10,
                          decoration: BoxDecoration(color: baseColor, borderRadius: BorderRadius.circular(4)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(width: 1, height: 44, margin: const EdgeInsets.symmetric(horizontal: 16), color: baseColor),
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(color: baseColor, borderRadius: BorderRadius.circular(12)),
                  ),
                  const SizedBox(width: 12),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 35,
                          height: 20,
                          decoration: BoxDecoration(color: baseColor, borderRadius: BorderRadius.circular(4)),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          width: 70,
                          height: 10,
                          decoration: BoxDecoration(color: baseColor, borderRadius: BorderRadius.circular(4)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
