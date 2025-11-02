import 'package:flutter/material.dart';
import 'package:root/src/core/extensions/context_extension.dart';
import 'package:toastification/toastification.dart';

class AppToasts {
  AppToasts._();

  static ToastificationItem? _currentToast;

  static void showError(
    BuildContext context, {
    String? title,
    String? description,
    ToastificationStyle? style,
    AlignmentGeometry? alignment,
  }) {
    _showToast(
      style: style,
      context: context,
      title: title ?? '',
      description: description ?? '',
      type: ToastificationType.error,
      alignment: alignment,
    );
  }

  static void showSuccess(
    BuildContext context, {
    String? title,
    String? description,
    ToastificationStyle? style,
    AlignmentGeometry? alignment,
  }) {
    _showToast(
      style: style,
      context: context,
      title: title ?? '',
      description: description ?? '',
      type: ToastificationType.success,
      alignment: alignment,
    );
  }

  static void showInfo(
    BuildContext context, {
    String? title,
    String? description,
    ToastificationStyle? style,
    AlignmentGeometry? alignment,
  }) {
    _showToast(
      style: style,
      context: context,
      title: title ?? '',
      description: description ?? '',
      type: ToastificationType.info,
      alignment: alignment,
    );
  }

  static void showWarning(
    BuildContext context, {
    String? title,
    String? description,
    ToastificationStyle? style,
    AlignmentGeometry? alignment,
  }) {
    _showToast(
      style: style,
      context: context,
      title: title ?? '',
      description: description ?? '',
      type: ToastificationType.warning,
      alignment: alignment,
    );
  }

  static void _showToast({
    required BuildContext context,
    required String title,
    required String description,
    required ToastificationType type,
    AlignmentGeometry? alignment,
    ToastificationStyle? style,
  }) {
    // Dismiss previous toast
    if (_currentToast case final currentToast?) {
      toastification.dismiss(currentToast);
    }
    final isDark = context.isDarkMode;

    // Show toast
    _currentToast = toastification.show(
      context: context,
      alignment: alignment ?? Alignment.topCenter,
      style: style ?? ToastificationStyle.flat,
      title: Text(
        title,
        style: TextStyle(
          color: context.isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      autoCloseDuration: const Duration(seconds: 3),
      description: Text(
        description,
        style: TextStyle(
          color: context.isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      backgroundColor: isDark
          ? const Color(0xFF000000)
          : const Color(0xFFFFFFFF),
      animationBuilder: (context, animation, alignment, child) {
        return ScaleTransition(scale: animation, child: child);
      },
      borderSide: BorderSide(
        color: isDark ? Colors.grey.shade800 : Colors.grey.shade300,
      ),
      boxShadow: highModeShadow,
      showProgressBar: false,
      dragToClose: true,
      type: type,
    );
  }
}
