import 'package:flutter/material.dart';

/// Extension on [BuildContext] to provide convenient access to size, theme, and media query properties
/// This reduces boilerplate code and provides a cleaner API for common operations
extension ContextExtension on BuildContext {
  /*------------ Screen Dimensions ------------*/

  /// Get the screen size
  Size get screenSize => MediaQuery.of(this).size;

  /// Get the screen width
  double get screenWidth => screenSize.width;

  /// Get the screen height
  double get screenHeight => screenSize.height;

  /// Get responsive width based on screen percentage (0.0 to 1.0)
  double responsiveWidth(double percent) => screenWidth * percent;

  /// Get responsive height based on screen percentage (0.0 to 1.0)
  double responsiveHeight(double percent) => screenHeight * percent;

  /*------------ Device Information ------------*/

  /// Check if the current theme is dark mode
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  /// Check if the device is in landscape orientation
  bool get isLandscape =>
      MediaQuery.of(this).orientation == Orientation.landscape;

  /// Check if the device is a tablet (based on shortest side >= 600dp)
  bool get isTablet => screenSize.shortestSide >= 600;

  /// Check if the device is a phone
  bool get isPhone => !isTablet;

  /*------------ Safe Area and Padding ------------*/

  /// Get the screen padding (safe area)
  EdgeInsets get screenPadding => MediaQuery.of(this).padding;

  /// Get the screen viewInsets (keyboard area)
  EdgeInsets get viewInsets => MediaQuery.of(this).viewInsets;

  /// Get the status bar height
  double get statusBarHeight => screenPadding.top;

  /// Get the bottom navigation bar height (or bottom safe area on notched devices)
  double get bottomNavBarHeight => screenPadding.bottom;

  /// Check if the keyboard is visible
  bool get isKeyboardVisible => viewInsets.bottom > 0;

  /// Get available screen height excluding keyboard
  double get availableHeight => screenHeight - viewInsets.bottom;

  /*------------ Theme Shortcuts ------------*/

  /// Get the current theme
  ThemeData get theme => Theme.of(this);

  /// Get the current color scheme
  ColorScheme get colorScheme => theme.colorScheme;

  /// Get the current text theme
  TextTheme get textTheme => theme.textTheme;

  /// Quick access to primary color
  Color get primaryColor => colorScheme.primary;

  /// Quick access to secondary color
  Color get secondaryColor => colorScheme.secondary;

  /// Quick access to background color
  Color get backgroundColor => colorScheme.surface;

  /// Quick access to surface color
  Color get surfaceColor => colorScheme.surface;

  /// Quick access to error color
  Color get errorColor => colorScheme.error;

  /*------------ Text Style Shortcuts ------------*/

  /// Display large text style
  TextStyle? get displayLarge => textTheme.displayLarge;

  /// Display medium text style
  TextStyle? get displayMedium => textTheme.displayMedium;

  /// Display small text style
  TextStyle? get displaySmall => textTheme.displaySmall;

  /// Headline large text style
  TextStyle? get headlineLarge => textTheme.headlineLarge;

  /// Headline medium text style
  TextStyle? get headlineMedium => textTheme.headlineMedium;

  /// Headline small text style
  TextStyle? get headlineSmall => textTheme.headlineSmall;

  /// Title large text style
  TextStyle? get titleLarge => textTheme.titleLarge;

  /// Title medium text style
  TextStyle? get titleMedium => textTheme.titleMedium;

  /// Title small text style
  TextStyle? get titleSmall => textTheme.titleSmall;

  /// Body large text style
  TextStyle? get bodyLarge => textTheme.bodyLarge;

  /// Body medium text style
  TextStyle? get bodyMedium => textTheme.bodyMedium;

  /// Body small text style
  TextStyle? get bodySmall => textTheme.bodySmall;

  /// Label large text style
  TextStyle? get labelLarge => textTheme.labelLarge;

  /// Label medium text style
  TextStyle? get labelMedium => textTheme.labelMedium;

  /// Label small text style
  TextStyle? get labelSmall => textTheme.labelSmall;

  /*------------ Responsive Breakpoints ------------*/

  /// Check if screen width is extra small (< 576px)
  bool get isXs => screenWidth < 576;

  /// Check if screen width is small (>= 576px and < 768px)
  bool get isSm => screenWidth >= 576 && screenWidth < 768;

  /// Check if screen width is medium (>= 768px and < 992px)
  bool get isMd => screenWidth >= 768 && screenWidth < 992;

  /// Check if screen width is large (>= 992px and < 1200px)
  bool get isLg => screenWidth >= 992 && screenWidth < 1200;

  /// Check if screen width is extra large (>= 1200px)
  bool get isXl => screenWidth >= 1200;

  /*------------ Navigation Shortcuts ------------*/

  /// Pop the current route
  void pop<T extends Object?>([T? result]) => Navigator.of(this).pop(result);

  /// Check if can pop the current route
  bool get canPop => Navigator.of(this).canPop();

  /*------------ Utility Methods ------------*/

  /// Show a snack bar with the given message
  void showSnackBar(String message, {Duration? duration}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration ?? const Duration(seconds: 3),
      ),
    );
  }

  /// Hide the current snack bar
  void hideSnackBar() => ScaffoldMessenger.of(this).hideCurrentSnackBar();

  /// Focus on the next focusable widget
  void nextFocus() => FocusScope.of(this).nextFocus();

  /// Remove focus from the current widget
  void unfocus() => FocusScope.of(this).unfocus();

  /// Get the current locale
  // Locale get locale => Localizations.of(this);

  /// Get the current text direction
  TextDirection get textDirection => Directionality.of(this);

  /// Check if the current locale is right-to-left
  bool get isRtl => textDirection == TextDirection.rtl;
}
