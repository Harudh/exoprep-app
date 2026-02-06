import 'package:flutter/material.dart';

class ExamAnalyticsLoadingShimmer extends StatefulWidget {
  const ExamAnalyticsLoadingShimmer({super.key});

  @override
  State<ExamAnalyticsLoadingShimmer> createState() => _ExamAnalyticsLoadingShimmerState();
}

class _ExamAnalyticsLoadingShimmerState extends State<ExamAnalyticsLoadingShimmer> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500))..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Exact colors from your ExamCardShimmer
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    final baseColor = isDark ? Colors.grey.shade900 : Colors.grey.shade300;
    final highlightColor = isDark ? Colors.grey.shade800 : Colors.grey.shade100;

    final containerColor = isDark ? Colors.grey.shade900 : Colors.white;
    final borderColor = isDark ? Colors.grey.shade800 : Colors.grey.shade300;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      physics: const NeverScrollableScrollPhysics(),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Column(
            children: [
              // 1. Summary Section (Grid + Hero)
              _SummaryShimmer(
                controller: _controller,
                baseColor: baseColor,
                highlightColor: highlightColor,
                containerColor: containerColor,
                borderColor: borderColor,
              ),
              const SizedBox(height: 12),

              // 2. Monthly Progress Chart
              _ChartShimmer(
                controller: _controller,
                baseColor: baseColor,
                highlightColor: highlightColor,
                containerColor: containerColor,
                borderColor: borderColor,
                height: 250,
              ),
              const SizedBox(height: 12),

              // 3. Subject Wise Breakdown Title
              Align(
                alignment: Alignment.centerLeft,
                child: _ShimmerBlock(
                  controller: _controller,
                  baseColor: baseColor,
                  highlightColor: highlightColor,
                  height: 20,
                  width: 180,
                  radius: 4,
                ),
              ),
              const SizedBox(height: 12),

              // 4. Subject Cards List
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 3,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (_, __) => _SubjectCardShimmer(
                  controller: _controller,
                  baseColor: baseColor,
                  highlightColor: highlightColor,
                  containerColor: containerColor,
                  borderColor: borderColor,
                ),
              ),
              const SizedBox(height: 12),

              // 5. Strong Topics (Collapsed)
              _ExpandableCardShimmer(
                controller: _controller,
                baseColor: baseColor,
                highlightColor: highlightColor,
                containerColor: containerColor,
                borderColor: borderColor,
              ),
              const SizedBox(height: 12),

              // 6. Weak Topics (Collapsed)
              _ExpandableCardShimmer(
                controller: _controller,
                baseColor: baseColor,
                highlightColor: highlightColor,
                containerColor: containerColor,
                borderColor: borderColor,
              ),

              const SizedBox(height: 120),
            ],
          );
        },
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// Component Shimmers
// -----------------------------------------------------------------------------

class _SummaryShimmer extends StatelessWidget {
  final AnimationController controller;
  final Color baseColor;
  final Color highlightColor;
  final Color containerColor;
  final Color borderColor;

  const _SummaryShimmer({
    required this.controller,
    required this.baseColor,
    required this.highlightColor,
    required this.containerColor,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Grid (5 items)
        Wrap(
          spacing: 12,
          runSpacing: 12,
          alignment: WrapAlignment.spaceBetween,
          children: List.generate(5, (index) {
            final width = (MediaQuery.of(context).size.width - 44) / 2;
            final isFullWidth = index == 4;
            return _MetricCardShimmer(
              controller: controller,
              baseColor: baseColor,
              highlightColor: highlightColor,
              containerColor: containerColor,
              borderColor: borderColor,
              width: isFullWidth ? double.infinity : width,
            );
          }),
        ),
        const SizedBox(height: 12),
        // Hero Score Card
        Container(
          width: double.infinity,
          height: 240,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: containerColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: borderColor),
          ),
          child: Center(
            child: Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: baseColor, width: 16),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _MetricCardShimmer extends StatelessWidget {
  final AnimationController controller;
  final Color baseColor;
  final Color highlightColor;
  final Color containerColor;
  final Color borderColor;
  final double width;

  const _MetricCardShimmer({
    required this.controller,
    required this.baseColor,
    required this.highlightColor,
    required this.containerColor,
    required this.borderColor,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 76,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        children: [
          // Icon Box
          _ShimmerBlock(
            controller: controller,
            baseColor: baseColor,
            highlightColor: highlightColor,
            height: 40,
            width: 40,
            radius: 12,
          ),
          const SizedBox(width: 12),
          // Text Lines
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _ShimmerBlock(
                  controller: controller,
                  baseColor: baseColor,
                  highlightColor: highlightColor,
                  height: 16,
                  width: 60,
                ),
                const SizedBox(height: 6),
                _ShimmerBlock(
                  controller: controller,
                  baseColor: baseColor,
                  highlightColor: highlightColor,
                  height: 10,
                  width: 40,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ChartShimmer extends StatelessWidget {
  final AnimationController controller;
  final Color baseColor;
  final Color highlightColor;
  final Color containerColor;
  final Color borderColor;
  final double height;

  const _ChartShimmer({
    required this.controller,
    required this.baseColor,
    required this.highlightColor,
    required this.containerColor,
    required this.borderColor,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ShimmerBlock(controller: controller, baseColor: baseColor, highlightColor: highlightColor, height: 20, width: 150),
          const SizedBox(height: 20),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(7, (index) {
                // Random-ish heights for chart effect
                final barHeight = 40.0 + (index * 15) % 100;
                return _ShimmerBlock(
                  controller: controller,
                  baseColor: baseColor,
                  highlightColor: highlightColor,
                  height: barHeight,
                  width: 12, // Bar width
                  radius: 4,
                );
              }),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _ShimmerBlock(controller: controller, baseColor: baseColor, highlightColor: highlightColor, height: 12, width: 60),
              const SizedBox(width: 20),
              _ShimmerBlock(controller: controller, baseColor: baseColor, highlightColor: highlightColor, height: 12, width: 60),
            ],
          ),
        ],
      ),
    );
  }
}

class _SubjectCardShimmer extends StatelessWidget {
  final AnimationController controller;
  final Color baseColor;
  final Color highlightColor;
  final Color containerColor;
  final Color borderColor;

  const _SubjectCardShimmer({
    required this.controller,
    required this.baseColor,
    required this.highlightColor,
    required this.containerColor,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _ShimmerBlock(controller: controller, baseColor: baseColor, highlightColor: highlightColor, height: 16, width: 100),
              _ShimmerBlock(
                controller: controller,
                baseColor: baseColor,
                highlightColor: highlightColor,
                height: 20,
                width: 60,
                radius: 8,
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Progress Bar
          _ShimmerBlock(
            controller: controller,
            baseColor: baseColor,
            highlightColor: highlightColor,
            height: 8,
            width: double.infinity,
            radius: 4,
          ),
          const SizedBox(height: 16),
          // Stats Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              4,
              (index) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ShimmerBlock(
                    controller: controller,
                    baseColor: baseColor,
                    highlightColor: highlightColor,
                    height: 14,
                    width: 24,
                  ),
                  const SizedBox(height: 4),
                  _ShimmerBlock(
                    controller: controller,
                    baseColor: baseColor,
                    highlightColor: highlightColor,
                    height: 10,
                    width: 32,
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

class _ExpandableCardShimmer extends StatelessWidget {
  final AnimationController controller;
  final Color baseColor;
  final Color highlightColor;
  final Color containerColor;
  final Color borderColor;

  const _ExpandableCardShimmer({
    required this.controller,
    required this.baseColor,
    required this.highlightColor,
    required this.containerColor,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _ShimmerBlock(controller: controller, baseColor: baseColor, highlightColor: highlightColor, height: 16, width: 120),
          Icon(Icons.keyboard_arrow_down_rounded, color: baseColor),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// Core Shimmer Logic
// -----------------------------------------------------------------------------

class _ShimmerBlock extends StatelessWidget {
  final AnimationController controller;
  final Color baseColor;
  final Color highlightColor;
  final double height;
  final double width;
  final double radius;

  const _ShimmerBlock({
    required this.controller,
    required this.baseColor,
    required this.highlightColor,
    required this.height,
    required this.width,
    this.radius = 4,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (bounds) {
        return LinearGradient(
          colors: [baseColor, highlightColor, baseColor],
          stops: const [0.0, 0.5, 1.0],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          transform: _SlidingGradientTransform(slidePercent: controller.value),
        ).createShader(bounds);
      },
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(color: baseColor, borderRadius: BorderRadius.circular(radius)),
      ),
    );
  }
}

class _SlidingGradientTransform extends GradientTransform {
  const _SlidingGradientTransform({required this.slidePercent});
  final double slidePercent;

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(bounds.width * slidePercent, 0.0, 0.0);
  }
}
