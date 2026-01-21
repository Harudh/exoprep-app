import 'package:root/src/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class BackgroundGradient extends StatelessWidget {
  const BackgroundGradient({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    // Adaptive Colors
    final Color bgColorTop = isDark ? const Color(0xFF423D39) : const Color(0xFFF5F2F0);
    final Color bgColorBottom = isDark ? const Color(0xFF121212) : const Color(0xFFFFFFFF);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [bgColorTop, bgColorBottom],
          stops: const [0.0, 0.4],
        ),
      ),
      child: child,
    );
  }
}
