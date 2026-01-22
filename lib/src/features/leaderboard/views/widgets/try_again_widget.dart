import 'package:flutter/material.dart';
import 'package:root/src/core/extensions/context_extension.dart';

class TryAgainWidget extends StatelessWidget {
  final VoidCallback onRetry;
  final String title;
  final String message;
  final String buttonText;

  const TryAgainWidget({
    super.key,
    required this.onRetry,
    this.title = "Content Unavailable",
    this.message = "We couldn't load the PYQ papers.",
    this.buttonText = "Try Again",
  });

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDarkMode;
    // Twitter 'Dim' or 'Black' background colors
    final Color cardColor = isDark ? const Color(0xFF16181C) : Colors.white;
    final Color textColor = isDark ? Colors.white : Colors.black;
    final Color subtitleColor = isDark ? const Color(0xFF71767B) : Colors.black54;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(24), // High rounding like X
            border: Border.all(color: isDark ? Colors.white12 : Colors.black.withOpacity(0.05)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Error Icon with Red Glow
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(color: Colors.red.withOpacity(0.1), shape: BoxShape.circle),
                    child: const Icon(
                      Icons.error_outline_rounded,
                      color: Color(0xFFF4212E), // Twitter/X Error Red
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),

                  // Text Content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(color: textColor, fontSize: 18, fontWeight: FontWeight.w800, letterSpacing: -0.5),
                        ),
                        const SizedBox(height: 4),
                        Text(message, style: TextStyle(color: subtitleColor, fontSize: 14, height: 1.3)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // The Stadium (Pill) Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onRetry,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // White button for high contrast
                    foregroundColor: Colors.black,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: const StadiumBorder(),
                  ),
                  child: Text(buttonText, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
