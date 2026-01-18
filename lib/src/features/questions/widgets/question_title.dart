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
    final textColor = isDark ? const Color(0xFFE5E5E5) : const Color(0xFF1F2937);
    print('Text: $title');

    if (_isHtml(title)) {
      return Html(
        data: title,
        style: {
          "body": Style(
            margin: Margins.zero,
            fontSize: FontSize(17),
            padding: HtmlPaddings.zero,
            fontWeight: FontWeight.w500,
            lineHeight: LineHeight(1.6),
            display: Display.inline,
            color: textColor,
          ),
          "p": Style(
            margin: Margins.zero,
            fontSize: FontSize(17),
            padding: HtmlPaddings.zero,
            fontWeight: FontWeight.w500,
            lineHeight: LineHeight(1.6),
            display: Display.inline,
            color: textColor,
          ),
          "h1": Style(
            margin: Margins.zero,
            padding: HtmlPaddings.zero,
            fontSize: FontSize(20),
            fontWeight: FontWeight.w600,
            lineHeight: LineHeight(1.6),
            color: textColor,
          ),
          "h2": Style(
            margin: Margins.zero,
            padding: HtmlPaddings.zero,
            fontSize: FontSize(19),
            fontWeight: FontWeight.w600,
            lineHeight: LineHeight(1.6),
            color: textColor,
          ),
          "h3": Style(
            margin: Margins.zero,
            padding: HtmlPaddings.zero,
            fontSize: FontSize(18),
            fontWeight: FontWeight.w600,
            lineHeight: LineHeight(1.6),
            color: textColor,
          ),
          "h4": Style(
            margin: Margins.zero,
            padding: HtmlPaddings.zero,
            fontSize: FontSize(17),
            fontWeight: FontWeight.w600,
            lineHeight: LineHeight(1.6),
            color: textColor,
          ),
          "h5": Style(
            margin: Margins.zero,
            padding: HtmlPaddings.zero,
            fontSize: FontSize(16),
            fontWeight: FontWeight.w600,
            lineHeight: LineHeight(1.6),
            color: textColor,
          ),
          "h6": Style(
            margin: Margins.zero,
            padding: HtmlPaddings.zero,
            fontSize: FontSize(15),
            fontWeight: FontWeight.w600,
            lineHeight: LineHeight(1.6),
            color: textColor,
          ),
          "span": Style(),
          "strong": Style(fontWeight: FontWeight.bold),
          "b": Style(fontWeight: FontWeight.bold),
          "em": Style(fontStyle: FontStyle.italic),
          "i": Style(fontStyle: FontStyle.italic),
          "u": Style(textDecoration: TextDecoration.underline),
          "sup": Style(fontSize: FontSize(14), verticalAlign: VerticalAlign.sup),
          "sub": Style(fontSize: FontSize(14), verticalAlign: VerticalAlign.sub),
          "div": Style(margin: Margins.zero, padding: HtmlPaddings.zero),
          "a": Style(color: context.colorScheme.primary, textDecoration: TextDecoration.underline),
          "code": Style(
            backgroundColor: isDark ? const Color(0xFF2A2A2A) : const Color(0xFFF3F4F6),
            color: textColor,
            fontFamily: 'monospace',
          ),
          "pre": Style(
            margin: Margins.zero,
            padding: HtmlPaddings.all(8),
            backgroundColor: isDark ? const Color(0xFF2A2A2A) : const Color(0xFFF3F4F6),
            fontFamily: 'monospace',
            color: textColor,
          ),
          "mark": Style(backgroundColor: isDark ? const Color(0xFF4B5563) : const Color(0xFFFEF3C7), color: textColor),
          "ul": Style(margin: Margins.zero, padding: HtmlPaddings.zero),
          "ol": Style(margin: Margins.zero, padding: HtmlPaddings.zero),
          "li": Style(margin: Margins.zero),
        },
      );
    }

    return Text(
      title,
      style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: textColor, height: 1.6, letterSpacing: 0.1),
    );
  }
}
