import 'package:flutter/material.dart';
import 'package:root/src/core/extensions/context_extension.dart';

class ReadPaperLoadingShimmer extends StatelessWidget {
  const ReadPaperLoadingShimmer({required this.paperName, super.key});

  final String paperName;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    // Define colors once here to pass down
    final baseColor = isDark ? Colors.grey[800]! : Colors.grey[300]!;
    final highlightColor = isDark ? Colors.grey[700]! : Colors.grey[100]!;

    return Scaffold(
      appBar: AppBar(
        title: Text(paperName, style: context.titleMedium),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Container(
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            alignment: Alignment.centerLeft,
            child: CustomShimmer(
              baseColor: baseColor,
              highlightColor: highlightColor,
              child: Row(
                children: List.generate(3, (index) {
                  return Container(
                    margin: const EdgeInsets.only(right: 24),
                    width: 70,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.white, // The color here acts as a mask
                      borderRadius: BorderRadius.circular(4),
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        itemCount: 6,
        itemBuilder: (context, index) {
          return _QuestionTileShimmer(baseColor: baseColor, highlightColor: highlightColor);
        },
      ),
    );
  }
}

class _QuestionTileShimmer extends StatelessWidget {
  const _QuestionTileShimmer({required this.baseColor, required this.highlightColor});

  final Color baseColor;
  final Color highlightColor;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A1A1A) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isDark ? const Color(0xFF2A2A2A) : const Color(0xFFE5E7EB), width: 1),
      ),
      padding: const EdgeInsets.all(16),
      child: CustomShimmer(
        baseColor: baseColor,
        highlightColor: highlightColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Question Badge
            Container(
              width: 90,
              height: 26,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6)),
            ),
            const SizedBox(height: 16),

            // Question Title Lines
            Container(
              width: double.infinity,
              height: 14,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              height: 14,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
            ),
            const SizedBox(height: 8),
            Container(
              width: 180,
              height: 14,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
            ),

            const SizedBox(height: 16),

            // Answer Badge
            Container(
              width: 70,
              height: 26,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6)),
            ),
            const SizedBox(height: 8),

            // Answer Text Line
            Container(
              width: 160,
              height: 14,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// CUSTOM SHIMMER IMPLEMENTATION (No Package)
// ---------------------------------------------------------------------------
class CustomShimmer extends StatefulWidget {
  final Widget child;
  final Color baseColor;
  final Color highlightColor;
  final Duration duration;

  const CustomShimmer({
    super.key,
    required this.child,
    required this.baseColor,
    required this.highlightColor,
    this.duration = const Duration(milliseconds: 1500),
  });

  @override
  State<CustomShimmer> createState() => _CustomShimmerState();
}

class _CustomShimmerState extends State<CustomShimmer> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback: (bounds) {
            // This creates the moving gradient
            final double start = _controller.value * 2 - 0.5; // Runs from -0.5 to 1.5
            final double end = start + 0.5;

            return LinearGradient(
              colors: [widget.baseColor, widget.highlightColor, widget.baseColor],
              stops: [start, (start + end) / 2, end],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              tileMode: TileMode.clamp, // Prevents weird artifacts at edges
            ).createShader(bounds);
          },
          child: widget.child,
        );
      },
    );
  }
}
