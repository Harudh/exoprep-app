import 'package:flutter/material.dart';
import 'package:root/src/core/extensions/context_extension.dart';

class ExamCardShimmer extends StatefulWidget {
  final double width;
  const ExamCardShimmer({required this.width, super.key});

  @override
  State<ExamCardShimmer> createState() => _ExamCardShimmerState();
}

class _ExamCardShimmerState extends State<ExamCardShimmer> with SingleTickerProviderStateMixin {
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
    final bool isDark = context.isDarkMode;
    final baseColor = isDark ? Colors.grey.shade900 : Colors.grey.shade300;
    final highlightColor = isDark ? Colors.grey.shade800 : Colors.grey.shade100;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          width: widget.width,
          margin: const EdgeInsets.only(right: 12),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: isDark ? Colors.grey.shade900 : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: isDark ? Colors.grey.shade800 : Colors.grey.shade300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _shimmerBlock(baseColor: baseColor, highlightColor: highlightColor, height: 24, width: widget.width * 0.4),
                  _shimmerBlock(baseColor: baseColor, highlightColor: highlightColor, height: 24, width: 50, radius: 8),
                ],
              ),
              const SizedBox(height: 4),

              // Subtitle
              _shimmerBlock(baseColor: baseColor, highlightColor: highlightColor, height: 12, width: widget.width * 0.6),
              const SizedBox(height: 16),

              // Progress Labels Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _shimmerBlock(baseColor: baseColor, highlightColor: highlightColor, height: 12, width: 60),
                  _shimmerBlock(baseColor: baseColor, highlightColor: highlightColor, height: 12, width: 80),
                ],
              ),
              const SizedBox(height: 8),

              // Progress Bar
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: _shimmerBlock(
                  baseColor: baseColor,
                  highlightColor: highlightColor,
                  height: 6,
                  width: double.infinity,
                  radius: 4,
                ),
              ),
              const Spacer(),

              // Bottom Stats Container
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey.shade900 : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: isDark ? Colors.grey.shade800 : Colors.grey.shade200),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _shimmerStat(baseColor: baseColor, highlightColor: highlightColor, iconColor: Colors.green),
                    Container(width: 1, height: 30, color: isDark ? Colors.grey.shade700 : Colors.grey.shade300),
                    _shimmerStat(baseColor: baseColor, highlightColor: highlightColor, iconColor: Colors.orange),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _shimmerBlock({
    required Color baseColor,
    required Color highlightColor,
    required double height,
    required double width,
    double radius = 4,
  }) {
    return ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (bounds) {
        return LinearGradient(
          colors: [baseColor, highlightColor, baseColor],
          stops: const [0.0, 0.5, 1.0],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          transform: _SlidingGradientTransform(slidePercent: _controller.value),
        ).createShader(bounds);
      },
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(color: baseColor, borderRadius: BorderRadius.circular(radius)),
      ),
    );
  }

  Widget _shimmerStat({required Color baseColor, required Color highlightColor, required Color iconColor}) {
    return Row(
      children: [
        Icon(Icons.check_circle_outline, size: 34, color: iconColor),
        const SizedBox(width: 6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _shimmerBlock(baseColor: baseColor, highlightColor: highlightColor, height: 16, width: 30),
            const SizedBox(height: 4),
            _shimmerBlock(baseColor: baseColor, highlightColor: highlightColor, height: 10, width: 50),
          ],
        ),
      ],
    );
  }
}

// Gradient transform for sliding animation
class _SlidingGradientTransform extends GradientTransform {
  const _SlidingGradientTransform({required this.slidePercent});

  final double slidePercent;

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(bounds.width * slidePercent, 0.0, 0.0);
  }
}

class PopularExamShimmer extends StatefulWidget {
  const PopularExamShimmer({super.key});

  @override
  State<PopularExamShimmer> createState() => _PopularExamShimmerState();
}

class _PopularExamShimmerState extends State<PopularExamShimmer> with SingleTickerProviderStateMixin {
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
    final bool isDark = context.isDarkMode;
    final baseColor = isDark ? Colors.grey.shade900 : Colors.grey.shade300;
    final highlightColor = isDark ? Colors.grey.shade800 : Colors.grey.shade100;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDark ? Colors.grey.shade900 : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: isDark ? Colors.grey.shade800 : Colors.grey.shade300),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title shimmer block
                    ShaderMask(
                      blendMode: BlendMode.srcATop,
                      shaderCallback: (bounds) {
                        return LinearGradient(
                          colors: [baseColor, highlightColor, baseColor],
                          stops: const [0.0, 0.5, 1.0],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          transform: _SlidingGradientTransform(slidePercent: _controller.value),
                        ).createShader(bounds);
                      },
                      child: Container(
                        height: 18,
                        width: MediaQuery.of(context).size.width * 0.45,
                        decoration: BoxDecoration(color: baseColor, borderRadius: BorderRadius.circular(4)),
                      ),
                    ),
                    const SizedBox(height: 4),
                    // Subtitle shimmer block
                    ShaderMask(
                      blendMode: BlendMode.srcATop,
                      shaderCallback: (bounds) {
                        return LinearGradient(
                          colors: [baseColor, highlightColor, baseColor],
                          stops: const [0.0, 0.5, 1.0],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          transform: _SlidingGradientTransform(slidePercent: _controller.value),
                        ).createShader(bounds);
                      },
                      child: Container(
                        height: 12,
                        width: MediaQuery.of(context).size.width * 0.35,
                        decoration: BoxDecoration(color: baseColor, borderRadius: BorderRadius.circular(4)),
                      ),
                    ),
                  ],
                ),
              ),
              // Chevron icon shimmer
              ShaderMask(
                blendMode: BlendMode.srcATop,
                shaderCallback: (bounds) {
                  return LinearGradient(
                    colors: [baseColor, highlightColor, baseColor],
                    stops: const [0.0, 0.5, 1.0],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    transform: _SlidingGradientTransform(slidePercent: _controller.value),
                  ).createShader(bounds);
                },
                child: Icon(Icons.chevron_right, color: isDark ? Colors.grey.shade700 : Colors.grey.shade400),
              ),
            ],
          ),
        );
      },
    );
  }
}
