import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:root/src/core/app/splash.dart';
import 'package:root/src/core/app/landing.dart';
import 'package:root/src/core/navigation/routes.dart';
import 'package:root/src/features/flash_cards/subfeatures/cards_list_view/view/cards_list_screen.dart';
import 'package:root/src/features/flash_cards/subfeatures/create_flash_card/view/create_flash_cards_screen.dart';
import 'package:root/src/features/flash_cards/subfeatures/decks_view/view/decks_list_screen.dart';
import 'package:root/src/features/home/home_view.dart';
import 'package:root/src/features/profile/profile_view.dart';
import 'package:root/src/core/navigation/route_transition.dart';
import 'package:root/src/features/leaderboard/leaderboard_view.dart';
import 'package:root/src/features/project_form/project_form_view.dart';
import 'package:root/src/features/select_exams/select_exams_view.dart';
import 'package:root/src/features/authentication/authentication_view.dart';
import 'package:root/src/features/flash_cards/views/flash_cards_collection_screen.dart';

/// Global router configuration for the application
/// This handles all navigation routing and transitions

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorHomeKey = GlobalKey<NavigatorState>(debugLabel: 'home');

final router = GoRouter(
  initialLocation: AppRoute.splash.path,
  navigatorKey: _rootNavigatorKey,
  routes: [
    GoRoute(
      name: AppRoute.splash.name,
      path: AppRoute.splash.path,
      pageBuilder: (context, state) {
        return AppRouteTransition.slideFromBottom(child: const Splash(), key: state.pageKey);
      },
    ),

    // Authentication Routes Group
    GoRoute(
      name: AppRoute.authentication.name,
      path: AppRoute.authentication.path,
      pageBuilder: (context, state) {
        return AppRouteTransition.slideFromRight(child: const AuthenticationView(), key: state.pageKey);
      },
    ),

    GoRoute(
      name: AppRoute.selectExams.name,
      path: AppRoute.selectExams.path,
      pageBuilder: (context, state) {
        return AppRouteTransition.defaultPageTransition(child: const SelectExamsView(), key: state.pageKey);
      },
    ),

    GoRoute(
      name: AppRoute.createProjectForm.name,
      path: AppRoute.createProjectForm.path,
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) {
        return AppRouteTransition.slideFromBottom(child: const ProjectFormView(), key: state.pageKey);
      },
    ),
    GoRoute(
      path: AppRoute.createFlashCardsView.path,
      name: AppRoute.createFlashCardsView.name,
      pageBuilder: (context, state) {
        final data = state.extra as Map<String, dynamic>;

        final decksId = data['id'] as String;
        final deckName = data['name'] as String?;
        return AppRouteTransition.slideFromBottom(
          child: CreateFlashCardsScreen(deckId: decksId, deckName: deckName ?? 'N/A'),
          key: state.pageKey,
        );
      },
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return Landing(navigationShell: navigationShell);
      },
      branches: [
        /* Home */
        StatefulShellBranch(
          navigatorKey: _shellNavigatorHomeKey,
          routes: [
            GoRoute(
              path: AppRoute.home.path,
              pageBuilder: (context, state) => const NoTransitionPage(child: HomeView()),
              routes: [
                GoRoute(
                  path: AppRoute.examDashboard.path,
                  pageBuilder: (context, state) =>
                      AppRouteTransition.slideFromRight(child: const DetailsScreen(), key: state.pageKey),
                ),
              ],
            ),
          ],
        ),

        /* Productivity */
        // StatefulShellBranch(
        //   routes: [
        //     GoRoute(
        //       path: AppRoute.productivity.path,
        //       pageBuilder: (context, state) =>
        //           const NoTransitionPage(child: ProductivityView()),
        //       // routes: [],
        //     ),
        //   ],
        // ),

        /* Flashcards */
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoute.flashcards.path,
              pageBuilder: (context, state) => const NoTransitionPage(child: FlashCardsCollectionScreen()),
            ),
            GoRoute(
              path: AppRoute.decksListView.path,
              name: AppRoute.decksListView.name,
              pageBuilder: (context, state) {
                final data = state.extra as Map<String, dynamic>;

                final id = data['id'] as String;
                final name = data['name'] as String;

                return NoTransitionPage(
                  child: DecksListScreen(collectionId: id, collectionName: name),
                );
              },
            ),
            GoRoute(
              path: AppRoute.cardsListView.path,
              name: AppRoute.cardsListView.name,
              pageBuilder: (context, state) {
                final data = state.extra as Map<String, dynamic>;

                final decksId = data['id'] as String;
                final String name = data['name'] as String;
                return NoTransitionPage(
                  child: CardsListScreen(decksId: decksId, deckName: name),
                );
              },
            ),
          ],
        ),

        /* Leaderboard */
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoute.leaderboard.path,
              pageBuilder: (context, state) => const NoTransitionPage(child: LeaderboardView()),
            ),
          ],
        ),

        /* Profile */
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoute.profile.path,
              pageBuilder: (context, state) => const NoTransitionPage(child: ProfileView()),
            ),
          ],
        ),
      ],
    ),
  ],

  // Error handling
  /*errorPageBuilder: (context, state) {
    return AppRouteTransition.defaultPageTransition(
      child: const ErrorScreen(),
      key: state.pageKey,
    );
  },*/
);

class RootScreen extends StatelessWidget {
  const RootScreen({required this.label, required this.detailsPath, super.key});

  final String label;
  final String detailsPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Root $label'),
            ElevatedButton(
              onPressed: () {
                context.push('/a/details');
              },
              child: const Text('View Details'),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text('Detail Screen')));
  }
}
