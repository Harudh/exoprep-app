extension StringExtension on String {
  String get extractMessage {
    if (startsWith('Exception: ')) {
      return replaceFirst('Exception: ', '');
    }
    return this;
  }
}
