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

          // For error state, show widget with zero values
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

  @override
  void initState() {
    super.initState();
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
          // Main Streak Display
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: hasData ? _toggleExpansion : null,
              borderRadius: BorderRadius.circular(16),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                child: Column(
                  children: [
                    Row(
                      children: [
                        // Current Streak
                        Expanded(
                          child: _MinimalStreakItem(
                            icon: Icons.local_fire_department_rounded,
                            iconColor: const Color(0xFFFF6B35),
                            value: currentStreak,
                            label: 'Current Streak',
                            isDark: isDark,
                          ),
                        ),

                        // Divider
                        Container(
                          width: 1,
                          height: 44,
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                           color: isDark ? Colors.grey.shade800: Colors.grey.shade200,
                          ),
                        ),

                        // Longest Streak
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
                    SizedBox(height: 12),

                    if (hasData) ...[
                      const SizedBox(height: 14),

                      // Expand Button
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

                      // No data message
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

          // Expandable Heatmap Calendar (only if has data)
          if (hasData)
            SizeTransition(
              sizeFactor: _expandAnimation,
              axisAlignment: -1.0,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    height: 1,
                    decoration: BoxDecoration(
                      color: isDark ? Colors.grey.shade800: Colors.grey.shade200,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Stats Row
                        Row(
                          children: [
                            _ActivityStat(label: 'Total Attempts', value: totalAttempts.toString(), isDark: isDark),
                            const SizedBox(width: 20),
                            _ActivityStat(label: 'Active Days', value: activeDays.toString(), isDark: isDark),
                          ],
                        ),

                        const SizedBox(height: 20),

                        // Heatmap Calendar
                        _ModernHeatmapCalendar(calendarData: calendarData, isDark: isDark),

                        const SizedBox(height: 16),

                        // Legend
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
        // Icon with gradient background
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: iconColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
          child: Icon(icon, color: iconColor, size: 24),
        ),

        const SizedBox(width: 12),

        // Text Info
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

class _ActivityStat extends StatelessWidget {
  final String label;
  final String value;
  final bool isDark;

  const _ActivityStat({required this.label, required this.value, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: isDark ? Colors.grey.shade800 : Colors.grey.shade50,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: isDark ? Colors.grey.shade800 : Colors.grey.shade200, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: isDark ? Colors.white : Colors.grey.shade900,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: isDark ? Colors.grey.shade500 : Colors.grey.shade600,
                letterSpacing: 0.1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ModernHeatmapCalendar extends StatelessWidget {
  final Map<String, CalendarDayData> calendarData;
  final bool isDark;

  const _ModernHeatmapCalendar({required this.calendarData, required this.isDark});

  Color _getIntensityColor(int attempts) {
    if (attempts == 0) {
      return isDark ? const Color(0xFF1A1A1A) : const Color(0xFFF5F5F5);
    }

    const baseColor = Color(0xFF10B981);

    if (attempts >= 5) {
      return baseColor;
    } else if (attempts >= 3) {
      return baseColor.withValues(alpha: 0.7);
    } else if (attempts >= 2) {
      return baseColor.withValues(alpha: 0.45);
    } else {
      return baseColor.withValues(alpha: 0.25);
    }
  }

  List<DateTime> _getLast12Weeks() {
    final today = DateTime.now();
    return List.generate(84, (index) {
      return today.subtract(Duration(days: 83 - index));
    });
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final last12Weeks = _getLast12Weeks();
    final weeks = <List<DateTime>>[];

    for (int i = 0; i < last12Weeks.length; i += 7) {
      weeks.add(last12Weeks.sublist(i, i + 7 > last12Weeks.length ? last12Weeks.length : i + 7));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(children: _buildMonthLabels(last12Weeks)),
        ),

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: ['Mon', 'Tue', 'Wed', 'Thur', 'Fri', 'Sat', 'Sun'].asMap().entries.map((entry) {
                return Container(
                  height: 14,
                  padding: const EdgeInsets.only(right: 8, top: 2, bottom: 2),
                  child: Text(
                    entry.value,
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w500,
                      color: isDark ? Colors.grey.shade600 : Colors.grey.shade500,
                      height: 1,
                    ),
                  ),
                );
              }).toList(),
            ),

            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: weeks.map((week) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 3),
                      child: Column(
                        children: week.asMap().entries.map((entry) {
                          final date = entry.value;
                          final dateKey = _formatDate(date);
                          final dayData = calendarData[dateKey];
                          final attempts = dayData?.attempts ?? 0;
                          final avgScore = dayData?.avgScore ?? 0.0;

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 3),
                            child: Tooltip(
                              message: attempts > 0
                                  ? '${_formatDateDisplay(date)}\n$attempts attempt${attempts > 1 ? 's' : ''}\nAvg: ${avgScore.toStringAsFixed(1)}'
                                  : '${_formatDateDisplay(date)}\nNo attempts',
                              textStyle: const TextStyle(fontSize: 11, color: Colors.white),
                              decoration: BoxDecoration(
                                color: isDark ? Colors.grey.shade800 : Colors.grey.shade900,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Container(
                                width: 11,
                                height: 11,
                                decoration: BoxDecoration(
                                  color: _getIntensityColor(attempts),
                                  borderRadius: BorderRadius.circular(2.5),
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
            ),
          ],
        ),
      ],
    );
  }

  List<Widget> _buildMonthLabels(List<DateTime> days) {
    final months = <String, int>{};
    var currentMonth = '';

    for (var i = 0; i < days.length; i += 7) {
      final monthName = _getMonthName(days[i].month);
      if (monthName != currentMonth) {
        months[monthName] = i ~/ 7;
        currentMonth = monthName;
      }
    }

    return months.entries.map((entry) {
      return Padding(
        padding: EdgeInsets.only(left: entry.value * 14.0),
        child: Text(
          entry.key,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.grey.shade500 : Colors.grey.shade600,
            letterSpacing: 0.3,
          ),
        ),
      );
    }).toList();
  }

  String _getMonthName(int month) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return months[month - 1];
  }

  String _formatDateDisplay(DateTime date) {
    return '${date.day} ${_getMonthName(date.month)} ${date.year}';
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
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: isDark ? Colors.grey.shade600 : Colors.grey.shade500,
            letterSpacing: 0.2,
          ),
        ),
        const SizedBox(width: 6),
        ...[0, 1, 2, 3, 5].map((attempts) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Container(
              width: 11,
              height: 11,
              decoration: BoxDecoration(
                color: attempts == 0
                    ? (isDark ? const Color(0xFF1A1A1A) : const Color(0xFFF5F5F5))
                    : const Color(0xFF10B981).withValues(
                        alpha: attempts == 1
                            ? 0.25
                            : attempts == 2
                            ? 0.45
                            : attempts == 3
                            ? 0.7
                            : 1.0,
                      ),
                borderRadius: BorderRadius.circular(2.5),
                border: attempts == 0
                    ? Border.all(color: isDark ? Colors.grey.shade800 : Colors.grey.shade300, width: 0.5)
                    : null,
              ),
            ),
          );
        }),
        const SizedBox(width: 6),
        Text(
          'More',
          style: TextStyle(
            fontSize: 10,
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
            // Left Streak Item
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Icon container
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(color: baseColor, borderRadius: BorderRadius.circular(12)),
                  ),
                  const SizedBox(width: 12),
                  // Text shimmer
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

            // Divider
            Container(
              width: 1,
              height: 44,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, isDark ? Colors.grey.shade700 : Colors.grey.shade300, Colors.transparent],
                ),
              ),
            ),

            // Right Streak Item
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Icon container
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(color: baseColor, borderRadius: BorderRadius.circular(12)),
                  ),
                  const SizedBox(width: 12),
                  // Text shimmer
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
