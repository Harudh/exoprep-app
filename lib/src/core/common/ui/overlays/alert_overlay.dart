import 'dart:async';
import 'package:flutter/material.dart';
import 'package:root/src/core/extensions/context_extension.dart';

class OverlayBannerService {
  static OverlayEntry? _currentOverlay;
  static Timer? _timer;

  /// Show an overlay banner with custom title and description
  static void show(
    BuildContext context, {
    required String title,
    required String description,
    Duration? duration, // null = manual dismiss only
    Color? accentColor,
    bool showButtons = true, // Show dismiss buttons or auto-dismiss
  }) {
    // Remove existing overlay if any
    hide();

    final overlay = Overlay.of(context);
    final isDark = context.isDarkMode;

    _currentOverlay = OverlayEntry(
      builder: (context) => _OverlayBanner(
        title: title,
        description: description,
        isDark: isDark,
        accentColor: accentColor,
        showButtons: showButtons,
        onDismiss: hide,
      ),
    );

    overlay.insert(_currentOverlay!);

    // Auto dismiss after duration if provided and no buttons
    if (duration != null && !showButtons) {
      _timer = Timer(duration, () {
        hide();
      });
    }
  }

  /// Manually hide the overlay
  static void hide() {
    _timer?.cancel();
    _timer = null;
    _currentOverlay?.remove();
    _currentOverlay = null;
  }
}

class _OverlayBanner extends StatefulWidget {
  const _OverlayBanner({
    required this.title,
    required this.description,
    required this.isDark,
    required this.onDismiss,
    required this.showButtons,
    this.accentColor,
  });

  final String title;
  final String description;
  final bool isDark;
  final Color? accentColor;
  final bool showButtons;
  final VoidCallback onDismiss;

  @override
  State<_OverlayBanner> createState() => _OverlayBannerState();
}

class _OverlayBannerState extends State<_OverlayBanner> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 400));

    _scaleAnimation = Tween<double>(
      begin: 0.7,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _dismiss() async {
    await _controller.reverse();
    widget.onDismiss();
  }

  @override
  Widget build(BuildContext context) {
    final accentColor = widget.accentColor ?? Colors.red;

    // Strong background color with opacity
    final cardBackground = widget.isDark ? const Color(0xFF1C1C1E) : Colors.white;

    // Stronger shadows for depth
    final cardShadows = [
      BoxShadow(color: Colors.black.withValues(alpha: 0.3), blurRadius: 40, spreadRadius: 0, offset: const Offset(0, 20)),
      BoxShadow(color: Colors.black.withValues(alpha: 0.15), blurRadius: 20, spreadRadius: 0, offset: const Offset(0, 10)),
    ];

    return Material(
      color: Colors.black.withValues(alpha: 0.7), // Darker backdrop
      child: Center(
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                constraints: const BoxConstraints(maxWidth: 420),
                decoration: BoxDecoration(
                  color: cardBackground,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: cardShadows,
                  border: Border.all(
                    color: widget.isDark ? Colors.white.withValues(alpha: 0.1) : Colors.black.withValues(alpha: 0.05),
                    width: 1,
                  ),
                ),
                clipBehavior: Clip.antiAlias, // FIX: Clip the overflow
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Accent color header bar - FIXED
                    // Container(
                    //   height: 6,
                    //   decoration: BoxDecoration(
                    //     gradient: LinearGradient(colors: [accentColor, accentColor.withValues(alpha: 0.8)]),
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.all(32),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Icon with gradient background
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [accentColor.withValues(alpha: 0.2), accentColor.withValues(alpha: 0.1)],
                              ),
                              shape: BoxShape.circle,
                              border: Border.all(color: accentColor.withValues(alpha: 0.3), width: 2),
                            ),
                            child: Icon(Icons.shield_outlined, color: accentColor, size: 56),
                          ),
                          const SizedBox(height: 24),

                          // Title
                          Text(
                            widget.title,
                            style: context.headlineSmall?.copyWith(
                              fontWeight: FontWeight.w800,
                              color: widget.isDark ? Colors.white : Colors.black,
                              letterSpacing: -0.5,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 12),

                          // Description
                          Text(
                            widget.description,
                            style: context.bodyLarge?.copyWith(
                              fontSize: 15,
                              height: 1.6,
                              color: widget.isDark ? Colors.white.withValues(alpha: 0.7) : Colors.black.withValues(alpha: 0.6),
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 6,
                            overflow: TextOverflow.ellipsis,
                          ),

                          // Conditional buttons or spacing
                          if (widget.showButtons) ...[
                            const SizedBox(height: 28),
                            Row(
                              children: [
                                // Dismiss button (secondary)
                                Expanded(
                                  child: OutlinedButton(
                                    onPressed: _dismiss,
                                    style: OutlinedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(vertical: 16),
                                      side: BorderSide(
                                        color: widget.isDark
                                            ? Colors.white.withValues(alpha: 0.2)
                                            : Colors.black.withValues(alpha: 0.2),
                                        width: 1.5,
                                      ),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                    ),
                                    child: Text(
                                      'Dismiss',
                                      style: context.bodyLarge?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: widget.isDark ? Colors.white : Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),

                                // Understood button (primary)
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: _dismiss,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: accentColor,
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(vertical: 16),
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                    ),
                                    child: Text(
                                      'Understood',
                                      style: context.bodyLarge?.copyWith(fontWeight: FontWeight.w700, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ] else
                            const SizedBox(height: 8),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class GradientBorderPainter extends CustomPainter {
  final BorderRadius radius;
  final double strokeWidth;
  final Gradient gradient;

  GradientBorderPainter({required this.radius, required this.strokeWidth, required this.gradient});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final rrect = radius.toRRect(rect);

    final paint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawRRect(rrect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
