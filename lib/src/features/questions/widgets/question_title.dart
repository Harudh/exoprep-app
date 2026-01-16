part of '../questions_view.dart';

class _QuestionTitle extends StatelessWidget {
  const _QuestionTitle({required this.title});

  final String title;

  bool _isHtml(String text) {
    return text.trim().startsWith('<') && text.trim().contains('>');
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    if (_isHtml(title)) {
      // If you have flutter_html package installed
      // return Html(
      //   data: title,
      //   style: {
      //     "body": Style(
      //       margin: Margins.zero,
      //       padding: HtmlPaddings.zero,
      //       fontSize: FontSize(17),
      //       fontWeight: FontWeight.w500,
      //       lineHeight: LineHeight(1.6),
      //       color: isDark ? const Color(0xFFE5E5E5) : const Color(0xFF1F2937),
      //     ),
      //   },
      // );

      // Fallback: Display HTML as text
      return Text(
        title,
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w500,
          color: isDark ? const Color(0xFFE5E5E5) : const Color(0xFF1F2937),
          height: 1.6,
          letterSpacing: 0.1,
        ),
      );
    }

    return Text(
      title,
      style: TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w500,
        color: isDark ? const Color(0xFFE5E5E5) : const Color(0xFF1F2937),
        height: 1.6,
        letterSpacing: 0.1,
      ),
    );
  }
}
