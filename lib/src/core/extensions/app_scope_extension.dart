import 'package:flutter/material.dart';
import 'package:root/src/core/app/app_scope.dart';
import 'package:root/src/features/authentication/authentication_viewmodel.dart';
import 'package:root/src/features/exam_dashboard/exam_dashboard_viewmodel.dart';
import 'package:root/src/features/home/home_viewmodel.dart';
import 'package:root/src/features/productivity/productivity_viewmodel.dart';

extension AppScopeExtension on BuildContext {
  AuthenticationViewModel get authViewModel => AppScope.of(this).authViewModel;
  ProductivityViewModel get productivityViewModel => AppScope.of(this).productivityViewModel;
  ExamDashboardViewModel get examDashboardViewModel => AppScope.of(this).examDashboardViewModel;
  HomeViewmodel get homeViewModel => AppScope.of(this).homeViewModel;
  // ProfileViewModel get profileViewModel => AppScope.of(this).profileViewModel;
  // Add more accessors here when you add more viewmodels to the scope
}
