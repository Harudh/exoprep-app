import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:root/src/core/app/splash.dart';
import 'package:root/src/core/extensions/app_scope_extension.dart';
import 'package:root/src/core/navigation/route_transition.dart';
import 'package:root/src/core/navigation/routes.dart';
import 'package:root/src/features/authentication/authentication_view.dart';

/// Global router configuration for the application
/// This handles all navigation routing and transitions
final router = GoRouter(
  // Initial route when app starts
  initialLocation: AppRoute.splash.path,

  // Route definitions
  routes: [
    // Splash Screen Route
    GoRoute(
      name: AppRoute.splash.name,
      path: AppRoute.splash.path,
      pageBuilder: (context, state) {
        return AppRouteTransition.slideFromBottom(
          child: const Splash(),
          key: state.pageKey,
        );
      },
    ),

    // Authentication Routes Group
    GoRoute(
      name: AppRoute.authentication.name,
      path: AppRoute.authentication.path,
      pageBuilder: (context, state) {
        return AppRouteTransition.slideFromRight(
          child: const AuthenticationView(),
          key: state.pageKey,
        );
      },
    ),

    // Home Screen Route
    GoRoute(
      name: AppRoute.home.name,
      path: AppRoute.home.path,
      pageBuilder: (context, state) {
        return AppRouteTransition.defaultPageTransition(
          child: const HomeScreen(),
          key: state.pageKey,
        );
      },
    ),

    GoRoute(
      name: AppRoute.selectExams.name,
      path: AppRoute.selectExams.path,
      pageBuilder: (context, state) {
        return AppRouteTransition.defaultPageTransition(
          child: const Scaffold(),
          key: state.pageKey,
        );
      },
    ),

    // Profile Routes Group
    /*GoRoute(
      name: AppRoute.profile.name,
      path: AppRoute.profile.path,
      pageBuilder: (context, state) {
        return AppRouteTransition.defaultPageTransition(
          child: const ProfileScreen(),
          key: state.pageKey,
        );
      },
      routes: [
        // Nested route for settings
        GoRoute(
          name: AppRoute.settings.name,
          path: '/settings',
          pageBuilder: (context, state) {
            return AppRouteTransition.slideFromRight(
              child: const SettingsScreen(),
              key: state.pageKey,
            );
          },
        ),
      ],
    ),*/

    /* ADD YOUR FEATURE ROUTES HERE */
    // Example:
    // GoRoute(
    //   name: AppRoute.dashboard.name,
    //   path: AppRoute.dashboard.path,
    //   pageBuilder: (context, state) {
    //     return AppRouteTransition.defaultPageTransition(
    //       child: const DashboardScreen(),
    //       key: state.pageKey,
    //     );
    //   },
    // ),
  ],

  // Error handling
  /*errorPageBuilder: (context, state) {
    return AppRouteTransition.defaultPageTransition(
      child: const ErrorScreen(),
      key: state.pageKey,
    );
  },*/
);

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        actions: [
          IconButton(
            onPressed: () {
              context.authViewModel.logout();
              context.go(AppRoute.authentication.path);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
    );
  }
}
