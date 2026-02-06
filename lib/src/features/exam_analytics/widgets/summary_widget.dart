// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:root/src/core/extensions/context_extension.dart';
import 'package:root/src/models/exam_analytics_model/exam_analytics_model.dart';

class AnalyticsSummaryWidget extends StatelessWidget {
  final ExamAnalyticsModel analytics;

  const AnalyticsSummaryWidget({super.key, required this.analytics});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          alignment: WrapAlignment.spaceBetween,
          children: [
            _MetricCard(
              label: 'Papers',
              value: analytics.totalPapersAttempted.toString(),
              icon: Icons.description_outlined,
              color: Colors.blueAccent,
              width: _calculateWidth(context),
            ),
            _MetricCard(
              label: 'Attempts',
              value: analytics.totalAttempts.toString(),
              icon: Icons.refresh_rounded,
              color: Colors.purpleAccent,
              width: _calculateWidth(context),
            ),
            _MetricCard(
              label: 'Questions',
              value: analytics.totalQuestionsAttempted.toString(),
              icon: Icons.quiz_outlined,
              color: Colors.orangeAccent,
              width: _calculateWidth(context),
            ),

            // Row 2: Performance stats
            _MetricCard(
              label: 'Accuracy',
              value: '${analytics.overallAccuracy.toStringAsFixed(1)}%',
              icon: Icons.track_changes_outlined,
              color: Colors.green,
              width: _calculateWidth(context),
            ),
            _MetricCard(
              label: 'Time Spent',
              value: _formatTime(analytics.totalTimeSpent),
              icon: Icons.timer_outlined,
              color: Colors.pinkAccent,
              width: double.infinity, // Full width for time
            ),
          ],
        ),
        const SizedBox(height: 8),

        _ScoreHeroCard(percentage: analytics.avgScorePercentage),
      ],
    );
  }

  double _calculateWidth(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return (width - 36) / 2;
  }

  String _formatTime(num seconds) {
    if (seconds < 60) return '${seconds}s';
    final int min = seconds ~/ 60;
    if (min < 60) return '${min}m';
    final int hr = min ~/ 60;
    final int remainingMin = min % 60;
    return '${hr}h ${remainingMin}m';
  }
}

class _ScoreHeroCard extends StatelessWidget {
  final num percentage;

  const _ScoreHeroCard({required this.percentage});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    // slightly smaller size to fit inside the card padding
    final double size = 160;
    final double strokeWidth = 16;
    final double value = (percentage / 100).clamp(0.0, 1.0);
    final Color scoreColor = _getScoreColor(percentage);

    return Container(
      width: double.infinity, // Full width card
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey.shade900 : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isDark ? Colors.grey.shade800 : Colors.grey.shade300),
        boxShadow: [BoxShadow(color: scoreColor.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        children: [
          SizedBox(
            width: size,
            height: size,
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Background Circle
                CircularProgressIndicator(
                  value: 1.0,
                  strokeWidth: strokeWidth,
                  color: isDark ? Colors.grey.shade800 : Colors.grey.shade100,
                  strokeCap: StrokeCap.round,
                ),
                // Value Circle
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0, end: value),
                  duration: const Duration(seconds: 2),
                  curve: Curves.easeOutQuart,
                  builder: (context, val, _) {
                    return CircularProgressIndicator(
                      value: val,
                      strokeWidth: strokeWidth,
                      color: scoreColor,
                      strokeCap: StrokeCap.round,
                    );
                  },
                ),
                // Text in Center
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Avg. Score',
                        style: context.textTheme.labelMedium?.copyWith(color: Colors.grey, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${percentage.toStringAsFixed(1)}%',
                        style: context.textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold, color: scoreColor),
                      ),
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

  Color _getScoreColor(num score) {
    if (score >= 80) return Colors.green;
    if (score >= 50) return Colors.amber;
    if (score >= 30) return Colors.orange;
    return Colors.redAccent;
  }
}

class _ScoreHero extends StatelessWidget {
  final num percentage;

  const _ScoreHero({required this.percentage});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final double size = 180;
    final double strokeWidth = 18;

    // Convert 0-100 to 0.0-1.0
    final double value = (percentage / 100).clamp(0.0, 1.0);

    return Center(
      child: Column(
        children: [
          SizedBox(
            width: size,
            height: size,
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Background Circle
                CircularProgressIndicator(
                  value: 1.0,
                  strokeWidth: strokeWidth,
                  color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
                  strokeCap: StrokeCap.round,
                ),
                // Value Circle
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0, end: value),
                  duration: const Duration(seconds: 2),
                  curve: Curves.easeOutQuart,
                  builder: (context, val, _) {
                    return CircularProgressIndicator(
                      value: val,
                      strokeWidth: strokeWidth,
                      color: _getScoreColor(val * 100),
                      strokeCap: StrokeCap.round,
                    );
                  },
                ),
                // Text in Center
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Avg. Score',
                        style: context.textTheme.labelMedium?.copyWith(color: Colors.grey, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${percentage.toStringAsFixed(1)}%',
                        style: context.textTheme.headlineLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: _getScoreColor(percentage),
                        ),
                      ),
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

  Color _getScoreColor(num score) {
    if (score >= 80) return Colors.green;
    if (score >= 50) return Colors.amber;
    if (score >= 30) return Colors.orange;
    return Colors.redAccent;
  }
}

class _MetricCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;
  final double width;

  const _MetricCard({required this.label, required this.value, required this.icon, required this.color, required this.width});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey.shade900 : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isDark ? Colors.grey.shade800 : Colors.grey.shade300),
        boxShadow: [BoxShadow(color: color.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 16, // Ensure numbers pop
                  ),
                ),
                Text(
                  label,
                  style: context.textTheme.bodySmall?.copyWith(color: Colors.grey, fontSize: 11),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
