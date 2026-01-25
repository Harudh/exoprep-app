import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Enum defining all application routes
/// This centralizes route management and makes navigation type-safe
enum AppRoute {
  /* Onboarding Navigation */
  splash('/'),
  authentication('/authentication'),
  selectExams('/selectExams'),

  /* Main Navigation */
  home('/home'),
  productivity('/productivity'),
  flashcards('/flashcards'),
  leaderboard('/leaderboard'),
  profile('/profile'),
  createFlashCardsView('/createFlashCardsView'),

  /* Nested Navigation */
  examDashboard('examDashboard'),
  decksListView('/decksListView'),
  cardsListView('/cardsListView'),

  /* Paper */
  readPaper('/readPaper'),
  attemptPaper('/attemptPaper'),
  questions('/questions'),
  paperResult('/paperResult'),

  /* Recently Attempted Paper */
  recentlyAttemptedPaper('/recentlyAttemptedPaper'),
  recentlyAttemptedQuestions('/recentlyAttemptedQuestions'),

  /* Productivity */
  createProjectForm('/createProjectForm');

  const AppRoute(this.path);

  final String path;
}

/// Extension to provide convenient navigation methods
extension AppRouteNavigation on AppRoute {
  /// Navigate to this route, replacing current route
  void go(BuildContext context, {Object? extra}) => context.go(path, extra: extra);

  /// Push this route onto the navigation stack
  void push(BuildContext context, {Object? extra}) => context.push(path, extra: extra);

  /// Push nested route from parent
  void pushNested(BuildContext context, AppRoute parent, {Object? extra}) {
    context.push('${parent.path}/$path', extra: extra);
  }

  /// Push this route and remove all routes behind it
  void pushAndClearStack(BuildContext context, {Object? extra}) {
    context.pushReplacement(path, extra: extra);
  }
}
