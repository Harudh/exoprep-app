import 'package:flutter/material.dart';
import 'package:root/src/models/exam_analytics_model/exam_analytics_model.dart';

/// Analytics View - Twitter-inspired design with dark mode support
///
/// Features:
/// - Clean, feed-style layout
/// - Area chart for performance trends
/// - Subject breakdown with progress bars
/// - Key insights section
/// - Full dark mode support
class AnalyticsView extends StatelessWidget {
  final ExamAnalyticsModel model;

  const AnalyticsView({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          // Stats Row
          AnalyticsStatsRow(model: model),

          // Progress Chart
          if (model.monthlyProgress.isNotEmpty) AnalyticsProgressChart(data: model.monthlyProgress),

          // Subjects Section Header
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Text(
              'Subject Breakdown',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w800,
                color: isDark ? const Color(0xFFE7E9EA) : Colors.grey.shade800,
              ),
            ),
          ),

          // Subjects List
          ...model.subjectPerformance.map((subject) => AnalyticsSubjectCard(subject: subject)),

          // Insights Section
          if (model.strengths.isNotEmpty || model.weaknesses.isNotEmpty)
            AnalyticsInsightsSection(strengths: model.strengths, weaknesses: model.weaknesses),

          const SizedBox(height: 120),
        ],
      ),
    );
  }
}

// =============================================================================
// STATS ROW WIDGET
// =============================================================================

class AnalyticsStatsRow extends StatelessWidget {
  final ExamAnalyticsModel model;

  const AnalyticsStatsRow({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: isDark ? const Color(0xFF2F3336) : Colors.grey.shade200)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          AnalyticsStatItem(value: '${model.avgScorePercentage.toStringAsFixed(0)}%', label: 'Score'),
          Container(width: 1, height: 40, color: isDark ? const Color(0xFF2F3336) : Colors.grey.shade300),
          AnalyticsStatItem(value: '${model.overallAccuracy.toStringAsFixed(0)}%', label: 'Accuracy'),
          Container(width: 1, height: 40, color: isDark ? const Color(0xFF2F3336) : Colors.grey.shade300),
          AnalyticsStatItem(value: '${model.totalAttempts}', label: 'Attempts'),
        ],
      ),
    );
  }
}

class AnalyticsStatItem extends StatelessWidget {
  final String value;
  final String label;

  const AnalyticsStatItem({super.key, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        Text(
          value,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: isDark ? Colors.white : Colors.black),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            color: isDark ? const Color(0xFF71767B) : Colors.grey.shade600,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

// =============================================================================
// PROGRESS CHART WIDGET
// =============================================================================

class AnalyticsProgressChart extends StatelessWidget {
  final List<MonthlyProgress> data;

  const AnalyticsProgressChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF16181C) : Colors.white,
        border: Border.all(color: isDark ? const Color(0xFF2F3336) : Colors.grey.shade300),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.show_chart, color: isDark ? const Color(0xFF1D9BF0) : const Color(0xFF1DA1F2), size: 20),
              const SizedBox(width: 8),
              Text(
                'Performance Trend',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: isDark ? Colors.white : Colors.black),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 100,
            child: CustomPaint(
              size: const Size(double.infinity, 100),
              painter: AnalyticsAreaChartPainter(
                data: data,
                color: isDark ? const Color(0xFF1D9BF0) : const Color(0xFF1DA1F2),
                isDark: isDark,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: data.map((p) {
              return Column(
                children: [
                  Text(
                    p.month,
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? const Color(0xFF71767B) : Colors.grey.shade600,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '${p.avgPercentage.toStringAsFixed(0)}%',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: isDark ? const Color(0xFF1D9BF0) : const Color(0xFF1DA1F2),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// SUBJECT CARD WIDGET
// =============================================================================

class AnalyticsSubjectCard extends StatelessWidget {
  final SubjectPerformance subject;

  const AnalyticsSubjectCard({super.key, required this.subject});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF16181C) : Colors.white,
        border: Border.all(color: isDark ? const Color(0xFF2F3336) : Colors.grey.shade300),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  subject.subjectName,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: isDark ? Colors.white : Colors.black),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: (isDark ? const Color(0xFF1D9BF0) : const Color(0xFF1DA1F2)).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${subject.accuracy.toStringAsFixed(0)}%',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: isDark ? const Color(0xFF1D9BF0) : const Color(0xFF1DA1F2),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              AnalyticsStatBadge(
                icon: Icons.check_circle,
                value: '${subject.correctAnswers}',
                label: 'Correct',
                color: isDark ? const Color(0xFF00BA7C) : const Color(0xFF00B894),
              ),
              const SizedBox(width: 12),
              AnalyticsStatBadge(
                icon: Icons.cancel,
                value: '${subject.incorrectAnswers}',
                label: 'Wrong',
                color: isDark ? const Color(0xFFF91880) : const Color(0xFFE84393),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: (subject.accuracy / 100).clamp(0.0, 1.0),
              minHeight: 6,
              backgroundColor: isDark ? const Color(0xFF2F3336) : Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation(isDark ? const Color(0xFF1D9BF0) : const Color(0xFF1DA1F2)),
            ),
          ),
        ],
      ),
    );
  }
}

class AnalyticsStatBadge extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;

  const AnalyticsStatBadge({super.key, required this.icon, required this.value, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 4),
        Text(
          '$value $label',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: color),
        ),
      ],
    );
  }
}

// =============================================================================
// INSIGHTS SECTION WIDGET
// =============================================================================

class AnalyticsInsightsSection extends StatelessWidget {
  final List<String> strengths;
  final List<String> weaknesses;

  const AnalyticsInsightsSection({super.key, required this.strengths, required this.weaknesses});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
          child: Text(
            'Key Insights',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w800,
              color: isDark ? const Color(0xFFE7E9EA) : Colors.grey.shade800,
            ),
          ),
        ),
        if (strengths.isNotEmpty)
          AnalyticsInsightCard(
            title: 'Strengths',
            icon: Icons.emoji_events,
            items: strengths,
            color: isDark ? const Color(0xFF00BA7C) : const Color(0xFF00B894),
            backgroundColor: isDark ? const Color(0xFF00BA7C).withOpacity(0.1) : const Color(0xFF00B894).withOpacity(0.1),
            borderColor: isDark ? const Color(0xFF00BA7C).withOpacity(0.3) : const Color(0xFF00B894).withOpacity(0.3),
          ),
        if (weaknesses.isNotEmpty)
          AnalyticsInsightCard(
            title: 'Focus Areas',
            icon: Icons.trending_up,
            items: weaknesses,
            color: isDark ? const Color(0xFFFFAD1F) : const Color(0xFFFF9F43),
            backgroundColor: isDark ? const Color(0xFFFFAD1F).withOpacity(0.1) : const Color(0xFFFF9F43).withOpacity(0.1),
            borderColor: isDark ? const Color(0xFFFFAD1F).withOpacity(0.3) : const Color(0xFFFF9F43).withOpacity(0.3),
          ),
      ],
    );
  }
}

class AnalyticsInsightCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<String> items;
  final Color color;
  final Color backgroundColor;
  final Color borderColor;

  const AnalyticsInsightCard({
    super.key,
    required this.title,
    required this.icon,
    required this.items,
    required this.color,
    required this.backgroundColor,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF16181C) : backgroundColor,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: color),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ...items
              .take(3)
              .map(
                (item) => Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    children: [
                      Icon(Icons.check_circle, size: 14, color: color),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          item,
                          style: TextStyle(fontSize: 13, color: isDark ? const Color(0xFFE7E9EA) : color.withOpacity(0.9)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
        ],
      ),
    );
  }
}

// =============================================================================
// AREA CHART PAINTER
// =============================================================================

class AnalyticsAreaChartPainter extends CustomPainter {
  final List<MonthlyProgress> data;
  final Color color;
  final bool isDark;

  AnalyticsAreaChartPainter({required this.data, required this.color, required this.isDark});

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;

    final maxValue = data.map((e) => e.avgPercentage).reduce((a, b) => a > b ? a : b).toDouble();
    final points = <Offset>[];

    for (var i = 0; i < data.length; i++) {
      final x = (size.width / (data.length - 1)) * i;
      final y = size.height - (size.height * (data[i].avgPercentage / (maxValue * 1.2)));
      points.add(Offset(x, y));
    }

    // Draw area
    final areaPath = Path();
    if (points.isNotEmpty) {
      areaPath.moveTo(points[0].dx, size.height);
      areaPath.lineTo(points[0].dx, points[0].dy);
      for (var i = 1; i < points.length; i++) {
        areaPath.lineTo(points[i].dx, points[i].dy);
      }
      areaPath.lineTo(points.last.dx, size.height);
      areaPath.close();

      final areaPaint = Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [color.withOpacity(isDark ? 0.3 : 0.3), color.withOpacity(isDark ? 0.05 : 0.05)],
        ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

      canvas.drawPath(areaPath, areaPaint);

      // Draw line
      final linePath = Path();
      linePath.moveTo(points[0].dx, points[0].dy);
      for (var i = 1; i < points.length; i++) {
        linePath.lineTo(points[i].dx, points[i].dy);
      }

      final linePaint = Paint()
        ..color = color
        ..strokeWidth = 2.5
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;

      canvas.drawPath(linePath, linePaint);

      // Draw dots
      final dotPaint = Paint()..color = color;
      for (final point in points) {
        canvas.drawCircle(point, 4, dotPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
