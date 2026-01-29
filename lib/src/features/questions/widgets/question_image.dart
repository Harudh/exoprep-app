part of '../questions_view.dart';

class _QuestionImage extends StatelessWidget {
  const _QuestionImage({required this.base64Image});

  final String base64Image;

  Uint8List? _decodeBase64() {
    try {
      String cleanBase64 = base64Image;
      if (base64Image.contains(',')) {
        cleanBase64 = base64Image.split(',').last;
      }
      return base64Decode(cleanBase64);
    } catch (e) {
      debugPrint('Error decoding base64 image: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final imageBytes = _decodeBase64();
    final brightness = Theme.of(context).brightness;

    if (imageBytes == null) {
      return const _ErrorImagePlaceholder();
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.3), width: 1),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.memory(
          imageBytes,

          // 🔥 THIS IS THE IMPORTANT PART
          key: ValueKey(brightness),

          fit: BoxFit.contain,
          gaplessPlayback: false,

          // Optional: if you want tinting in dark mode
          color: brightness == Brightness.dark ? Colors.white : null,
          colorBlendMode: brightness == Brightness.dark ? BlendMode.srcIn : null,

          errorBuilder: (context, error, stackTrace) {
            debugPrint('Error loading image: $error');
            return const _ErrorImagePlaceholder();
          },
        ),
      ),
    );
  }
}

class _ErrorImagePlaceholder extends StatelessWidget {
  const _ErrorImagePlaceholder();

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final colorScheme = context.colorScheme;

    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: isDark ? colorScheme.surfaceContainerHighest : colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorScheme.outline.withValues(alpha: 0.2), width: 1),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.broken_image_outlined, size: 48, color: colorScheme.onSurfaceVariant),
            const SizedBox(height: 8),
            Text(
              'Image unavailable',
              style: TextStyle(fontSize: 12, color: colorScheme.onSurfaceVariant, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}
