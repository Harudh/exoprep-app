import 'package:flutter/material.dart';
import 'package:root/src/features/authentication/authentication_viewmodel.dart';
import 'package:root/src/features/exam_dashboard/exam_dashboard_viewmodel.dart';
import 'package:root/src/features/productivity/productivity_viewmodel.dart';

class AppScope extends InheritedWidget {
  final AuthenticationViewModel authViewModel;
  final ProductivityViewModel productivityViewModel;
  final ExamDashboardViewModel examDashboardViewModel;

  // Add more view models and services here as needed

  const AppScope({
    required super.child,
    required this.authViewModel,
    required this.productivityViewModel,
    required this.examDashboardViewModel,
    super.key,
  });

  static AppScope of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<AppScope>();
    assert(result != null, 'DependencyScope not found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(covariant AppScope oldWidget) {
    // Only notify if any of the viewmodels and services change
    return authViewModel != oldWidget.authViewModel ||
        productivityViewModel != oldWidget.productivityViewModel ||
        examDashboardViewModel != oldWidget.examDashboardViewModel;

    /*
    return profileViewModel != oldWidget.profileViewModel 
    || otherViewModel != oldWidget.otherViewModel;
    */
  }
}
