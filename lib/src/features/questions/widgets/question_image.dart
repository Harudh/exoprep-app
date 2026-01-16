// widgets/question_image.dart
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
    final isDark = context.isDarkMode;
    final imageBytes = _decodeBase64();

    if (imageBytes == null) {
      return _ErrorImagePlaceholder(isDark: isDark);
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: (isDark ? const Color(0xFF2A2A2A) : const Color(0xFFE5E7EB)).withValues(alpha: 0.5), width: 1),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.memory(
          imageBytes,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            debugPrint('Error loading image: $error');
            return _ErrorImagePlaceholder(isDark: isDark);
          },
        ),
      ),
    );
  }
}

class _ErrorImagePlaceholder extends StatelessWidget {
  const _ErrorImagePlaceholder({required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2A2A2A) : const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Icon(Icons.broken_image_outlined, size: 48, color: isDark ? const Color(0xFF6B7280) : const Color(0xFF9CA3AF)),
      ),
    );
  }
}
