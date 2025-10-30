import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:root/src/core/extensions/context_extension.dart';

class HorizontalDatePicker extends StatefulWidget {
  const HorizontalDatePicker({
    required this.onDateSelected,
    super.key,
  });

  final void Function(DateTime date) onDateSelected;

  @override
  State<HorizontalDatePicker> createState() => _HorizontalDatePickerState();
}

class _HorizontalDatePickerState extends State<HorizontalDatePicker> {
  late ScrollController _scrollController;
  late List<DateTime> _dates;
  late DateTime _selectedDate;
  bool _isLoadingMoreDates = false;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _scrollController = ScrollController();
    _generateInitialDates();
    _setupScrollListener();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _generateInitialDates() {
    final now = DateTime.now();
    final dates = <DateTime>[];

    for (var i = 30; i >= 0; i--) {
      dates.add(now.subtract(Duration(days: i)));
    }

    dates.add(now.add(const Duration(days: 1)));

    setState(() {
      _dates = dates;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToToday();
    });
  }

  void _setupScrollListener() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels <= 100 && !_isLoadingMoreDates) {
        _loadMorePastDates();
      }
    });
  }

  void _loadMorePastDates() {
    if (_isLoadingMoreDates || _dates.isEmpty) return;

    setState(() {
      _isLoadingMoreDates = true;
    });

    final earliestDate = _dates.first;
    final newDates = <DateTime>[];

    for (var i = 30; i >= 1; i--) {
      newDates.add(earliestDate.subtract(Duration(days: i)));
    }

    setState(() {
      _dates = [...newDates, ..._dates];
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        final offset = newDates.length * 68.0;
        _scrollController.jumpTo(_scrollController.offset + offset);
      }
      setState(() {
        _isLoadingMoreDates = false;
      });
    });
  }

  void _scrollToToday() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !_scrollController.hasClients || _dates.isEmpty) return;

      final todayIndex = _dates.indexWhere(_isToday);

      if (todayIndex != -1) {
        Future.delayed(const Duration(milliseconds: 50), () {
          if (!mounted || !_scrollController.hasClients) return;

          final maxScrollExtent = _scrollController.position.maxScrollExtent;
          final viewportWidth = _scrollController.position.viewportDimension;

          const cardWidth = 78.0;

          final targetPosition =
              (todayIndex * cardWidth) - (viewportWidth - 150);
          final scrollPosition = targetPosition.clamp(0.0, maxScrollExtent);

          _scrollController.jumpTo(scrollPosition);
        });
      }
    });
  }

  void _onDateTapped(DateTime date) {
    HapticFeedback.lightImpact();
    setState(() {
      _selectedDate = date;
    });
    widget.onDateSelected(date);
  }

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  bool _isSelectedDate(DateTime date) {
    return date.year == _selectedDate.year &&
        date.month == _selectedDate.month &&
        date.day == _selectedDate.day;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: CustomScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        slivers: [
          const SliverToBoxAdapter(child: SizedBox(width: 6)),

          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final date = _dates[index];
                final isSelected = _isSelectedDate(date);
                final isToday = _isToday(date);

                return _DateCard(
                  date: date,
                  isSelected: isSelected,
                  isToday: isToday,
                  onTap: () => _onDateTapped(date),
                );
              },
              childCount: _dates.length,
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(width: 6)),
        ],
      ),
    );
  }
}

class _DateCard extends StatelessWidget {
  const _DateCard({
    required this.date,
    required this.isSelected,
    required this.isToday,
    required this.onTap,
  });

  final DateTime date;
  final bool isSelected;
  final bool isToday;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.isDarkMode;
    final dayName = DateFormat('EEE').format(date);
    final dayNumber = DateFormat('dd').format(date);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 65,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.blue.shade600
              : (isDarkMode ? const Color(0xFF1E1E1E) : Colors.grey.shade200),
          borderRadius: BorderRadius.circular(22),
          border: isToday && !isSelected
              ? Border.all(color: Colors.blue.shade600, width: 2)
              : Border.all(
                  color: isDarkMode
                      ? const Color(0xFF2A2A2A)
                      : Colors.grey.shade200,
                ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              dayName,
              style: TextStyle(
                fontSize: 11,
                color: isSelected
                    ? Colors.white
                    : (isDarkMode
                          ? Colors.grey.shade500
                          : Colors.grey.shade600),
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              dayNumber,
              style: TextStyle(
                fontSize: 20,
                color: isSelected
                    ? Colors.white
                    : (isDarkMode ? Colors.white : Colors.black),
                fontWeight: FontWeight.w800,
                height: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
