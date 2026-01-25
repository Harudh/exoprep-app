import 'package:flutter/material.dart';

class CustomShimmerProfile extends StatefulWidget {
  final double size;
  final BorderRadius? borderRadius;
  final ShapeBorder? shape;

  const CustomShimmerProfile.circular({super.key, required this.size}) : borderRadius = null, shape = const CircleBorder();

  @override
  State<CustomShimmerProfile> createState() => _CustomShimmerProfileState();
}

class _CustomShimmerProfileState extends State<CustomShimmerProfile> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1400))..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final baseColor = isDark ? Colors.grey.shade800 : Colors.grey.shade300;
    final highlightColor = isDark ? Colors.grey.shade600 : Colors.grey.shade100;

    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return ShaderMask(
          shaderCallback: (rect) {
            return LinearGradient(
              begin: Alignment(-1.0 + _controller.value * 2, 0),
              end: Alignment(1.0 + _controller.value * 2, 0),
              colors: [baseColor, highlightColor, baseColor],
              stops: const [0.35, 0.5, 0.65],
            ).createShader(rect);
          },
          blendMode: BlendMode.srcATop,
          child: Container(
            width: widget.size,
            height: widget.size,
            decoration: ShapeDecoration(color: baseColor, shape: widget.shape!),
          ),
        );
      },
    );
  }
}

class ProfileHeaderShimmer extends StatefulWidget {
  const ProfileHeaderShimmer({super.key});

  @override
  State<ProfileHeaderShimmer> createState() => _ProfileHeaderShimmerState();
}

class _ProfileHeaderShimmerState extends State<ProfileHeaderShimmer> with SingleTickerProviderStateMixin {
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
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 60, 20, 30),
      child: Column(
        children: [
          // Avatar shimmer
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              CustomShimmer(
                controller: _controller,
                isDark: isDark,
                child: Container(
                  width: 110,
                  height: 110,
                  decoration: BoxDecoration(color: isDark ? Colors.grey[800] : Colors.grey[300], shape: BoxShape.circle),
                ),
              ),
              CustomShimmer(
                controller: _controller,
                isDark: isDark,
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(color: isDark ? Colors.grey[800] : Colors.grey[300], shape: BoxShape.circle),
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),

          // Name shimmer
          CustomShimmer(
            controller: _controller,
            isDark: isDark,
            child: Container(
              width: 120,
              height: 20,
              decoration: BoxDecoration(
                color: isDark ? Colors.grey[800] : Colors.grey[300],
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),

          const SizedBox(height: 8),

          // Subtitle shimmer
          CustomShimmer(
            controller: _controller,
            isDark: isDark,
            child: Container(
              width: 80,
              height: 14,
              decoration: BoxDecoration(
                color: isDark ? Colors.grey[800] : Colors.grey[300],
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomShimmer extends StatelessWidget {
  final AnimationController controller;
  final Widget child;
  final bool isDark;

  const CustomShimmer({super.key, required this.controller, required this.child, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isDark
                  ? [Colors.grey[800]!, Colors.grey[700]!, Colors.grey[800]!]
                  : [Colors.grey[300]!, Colors.grey[100]!, Colors.grey[300]!],
              stops: [
                controller.value - 0.3,
                controller.value,
                controller.value + 0.3,
              ].map((stop) => stop.clamp(0.0, 1.0)).toList(),
            ).createShader(bounds);
          },
          child: child,
        );
      },
      child: child,
    );
  }
}
