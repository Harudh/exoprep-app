import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:root/src/core/app/app_di.dart';
import 'package:root/src/core/navigation/router.dart';
import 'package:root/src/core/theme/theme.dart';
import 'package:toastification/toastification.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key, this.savedThemeMode});

  final AdaptiveThemeMode? savedThemeMode;

  @override
  Widget build(BuildContext context) {
    return AppDI(
      child: AdaptiveTheme(
        light: AppTheme.lightTheme,
        dark: AppTheme.darkTheme,
        initial: savedThemeMode ?? AdaptiveThemeMode.system,
        builder: (theme, darkTheme) => ToastificationWrapper(
          child: _AppWithSystemUI(
            theme: theme,
            darkTheme: darkTheme,
          ),
        ),
      ),
    );
  }
}

class _AppWithSystemUI extends StatelessWidget {
  const _AppWithSystemUI({
    required this.theme,
    required this.darkTheme,
  });

  final ThemeData theme;
  final ThemeData darkTheme;

  @override
  Widget build(BuildContext context) {
    final isDark = theme.brightness == Brightness.dark;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        systemNavigationBarColor: isDark ? const Color(0xFF1C1C1E) : const Color(0xFFF2F4F6),
        systemNavigationBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
      ),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: router,
        darkTheme: darkTheme,
        theme: theme,
      ),
    );
  }
}