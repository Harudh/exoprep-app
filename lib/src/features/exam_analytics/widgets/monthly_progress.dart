import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:root/src/core/extensions/context_extension.dart';
import 'package:root/src/models/exam_analytics_model/exam_analytics_model.dart';

class MonthlyProgressWidget extends StatefulWidget {
  final List<MonthlyProgress> monthlyProgress;

  const MonthlyProgressWidget({super.key, required this.monthlyProgress});

  @override
  State<MonthlyProgressWidget> createState() => _MonthlyProgressWidgetState();
}

class _MonthlyProgressWidgetState extends State<MonthlyProgressWidget> {
  final Color attemptsColor = Colors.cyan;
  final Color percentageColor = Colors.orange;
  static const double _leftTitlesWidth = 28.0;

  @override
  Widget build(BuildContext context) {
    if (widget.monthlyProgress.isEmpty) {
      return _buildEmptyState();
    }

    double maxY = 0;
    for (var item in widget.monthlyProgress) {
      if (item.attempts > maxY) maxY = item.attempts.toDouble();
      if (item.avgPercentage > maxY) maxY = item.avgPercentage.toDouble();
    }
    maxY = (maxY == 0 ? 10 : maxY) * 1.2;
    double minX = 0;
    double maxX = (widget.monthlyProgress.length - 1).toDouble();
    if (widget.monthlyProgress.length == 1) {
      minX = -0.5;
      maxX = 0.5;
    }

    return AspectRatio(
      aspectRatio: 1.3,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: context.isDarkMode ? Colors.grey.shade900 : Colors.white,
          border: Border.all(color: context.isDarkMode ? Colors.grey.shade800 : Colors.grey.shade300),
        ),
        padding: const EdgeInsets.fromLTRB(4, 20, 12, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text('Monthly Performance', style: context.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: LineChart(
                LineChartData(
                  minX: minX,
                  maxX: maxX,
                  minY: 0,
                  maxY: maxY,
                  lineTouchData: _buildTouchData(),
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: true,
                    horizontalInterval: maxY / 5,
                    getDrawingHorizontalLine: (value) =>
                        FlLine(color: Theme.of(context).dividerColor.withValues(alpha: 0.2), strokeWidth: 1),
                    getDrawingVerticalLine: (value) =>
                        FlLine(color: Theme.of(context).dividerColor.withValues(alpha: 0.1), strokeWidth: 1),
                  ),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true, reservedSize: 22, interval: 1, getTitlesWidget: _bottomTitles),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: maxY / 5,
                        getTitlesWidget: _leftTitles,
                        reservedSize: _leftTitlesWidth,
                      ),
                    ),
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: widget.monthlyProgress.asMap().entries.map((e) {
                        return FlSpot(e.key.toDouble(), e.value.attempts.toDouble());
                      }).toList(),
                      isCurved: true,
                      color: attemptsColor,
                      barWidth: 3,
                      isStrokeCapRound: true,
                      dotData: const FlDotData(show: true),
                      belowBarData: BarAreaData(show: true, color: attemptsColor.withValues(alpha: 0.1)),
                    ),
                    LineChartBarData(
                      spots: widget.monthlyProgress.asMap().entries.map((e) {
                        return FlSpot(e.key.toDouble(), e.value.avgPercentage.toDouble());
                      }).toList(),
                      isCurved: true,
                      color: percentageColor,
                      barWidth: 3,
                      isStrokeCapRound: true,
                      dotData: const FlDotData(show: true),
                      belowBarData: BarAreaData(show: false),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _ChartIndicator(color: attemptsColor, text: 'Attempts'),
                const SizedBox(width: 20),
                _ChartIndicator(color: percentageColor, text: 'Avg %'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      height: 200,
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(12)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.bar_chart_rounded, size: 48, color: Colors.grey.shade400),
          const SizedBox(height: 8),
          Text("No monthly data yet", style: TextStyle(color: Colors.grey.shade500)),
        ],
      ),
    );
  }

  LineTouchData _buildTouchData() {
    return LineTouchData(
      handleBuiltInTouches: true,
      touchTooltipData: LineTouchTooltipData(
        getTooltipColor: (_) => Colors.blueGrey.shade800,
        getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
          return touchedBarSpots.map((barSpot) {
            final flSpot = barSpot;
            final isAttempts = barSpot.barIndex == 0;
            return LineTooltipItem(
              '${isAttempts ? "Attempts" : "Avg %"}: ',
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                  text: flSpot.y.toStringAsFixed(1),
                  style: TextStyle(color: isAttempts ? attemptsColor : percentageColor, fontWeight: FontWeight.w900),
                ),
              ],
            );
          }).toList();
        },
      ),
    );
  }

  Widget _bottomTitles(double value, TitleMeta meta) {
    final index = value.toInt();
    if (index < 0 || index >= widget.monthlyProgress.length) {
      return const SizedBox.shrink();
    }
    final rawDate = widget.monthlyProgress[index].month;
    final label = rawDate.split(' ').first;

    return SideTitleWidget(
      meta: meta,
      space: 4,
      child: Text(
        label,
        style: TextStyle(
          color: Colors.grey.shade600,
          fontSize: 10, // Slightly smaller font
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _leftTitles(double value, TitleMeta meta) {
    return SideTitleWidget(
      meta: meta,
      space: 4,
      child: Text(value.toInt().toString(), style: TextStyle(color: Colors.grey.shade500, fontSize: 10)),
    );
  }
}

class _ChartIndicator extends StatelessWidget {
  final Color color;
  final String text;

  const _ChartIndicator({required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(
          text,
          style: context.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold, color: Colors.grey.shade700, fontSize: 11),
        ),
      ],
    );
  }
}
