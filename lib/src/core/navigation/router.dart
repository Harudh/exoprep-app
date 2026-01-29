import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:root/src/core/app/splash.dart';
import 'package:root/src/core/app/landing.dart';
import 'package:root/src/core/navigation/routes.dart';
import 'package:root/src/features/home/home_view.dart';
import 'package:root/src/models/paper_model/paper_model.dart';
import 'package:root/src/core/navigation/route_transition.dart';
import 'package:root/src/features/questions/questions_view.dart';
import 'package:root/src/models/subject_model/subject_model.dart';
import 'package:root/src/features/read_paper/read_paper_view.dart';
import 'package:root/src/models/question_model/question_model.dart';
import 'package:root/src/features/paper_result/paper_result_view.dart';
import 'package:root/src/features/project_form/project_form_view.dart';
import 'package:root/src/features/select_exams/select_exams_view.dart';
import 'package:root/src/features/attempt_paper/attempt_paper_view.dart';
import 'package:root/src/features/authentication/authentication_view.dart';
import 'package:root/src/features/exam_dashboard/exam_dashboard_view.dart';
import 'package:root/src/features/profile/view/screens/profile_screen.dart';
import 'package:root/src/models/paper_model/recently_attempted_paper_model.dart';
import 'package:root/src/features/leaderboard/views/screen/leaderboard_screen.dart';
import 'package:root/src/models/question_model/attempted_question_response_model.dart';
import 'package:root/src/features/flash_cards/views/flash_cards_collection_screen.dart';
import 'package:root/src/features/recently_attempted_paper/recently_attempted_paper_view.dart';
import 'package:root/src/features/flash_cards/subfeatures/decks_view/view/decks_list_screen.dart';
import 'package:root/src/features/recently_attempted_questions/recently_attempted_questions_view.dart';
import 'package:root/src/features/flash_cards/subfeatures/cards_list_view/view/cards_list_screen.dart';
import 'package:root/src/features/flash_cards/subfeatures/create_flash_card/view/create_flash_cards_screen.dart';

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
    /* Papers */
    GoRoute(
      path: AppRoute.readPaper.path,
      name: AppRoute.readPaper.name,
      pageBuilder: (context, state) {
        final paper = state.extra as Paper;

        return AppRouteTransition.slideFromBottom(
          child: ReadPaperView(paper: paper),
          key: state.pageKey,
        );
      },
    ),

    GoRoute(
      path: AppRoute.attemptPaper.path,
      name: AppRoute.attemptPaper.name,
      pageBuilder: (context, state) {
        final paper = state.extra as Paper;

        return AppRouteTransition.slideFromRight(
          child: AttemptPaperView(paper: paper),
          key: state.pageKey,
        );
      },
    ),

    GoRoute(
      path: AppRoute.questions.path,
      name: AppRoute.questions.name,
      pageBuilder: (context, state) {
        final params = state.extra as Map<String, dynamic>;

        final paper = params['paper'] as Paper;
        final subjects = params['subjects'] as List<Subject>;
        final questions = params['questions'] as List<Question>;

        return AppRouteTransition.slideFromRight(
          child: QuestionsView(paper: paper, subjects: subjects, questions: questions),
          key: state.pageKey,
        );
      },
    ),

    GoRoute(
      path: AppRoute.paperResult.path,
      name: AppRoute.paperResult.name,
      pageBuilder: (context, state) {
        final params = state.extra as Map<String, dynamic>;
        final paper = params['paper'] as Paper;
        final subjects = params['subjects'] as List<Subject>;
        final questions = params['questions'] as List<Question>;
        final attemptedQuestions = params['attempted_questions'] as AttemptedQuestionsResponse;

        return AppRouteTransition.slideFromBottom(
          child: PaperResultView(paper: paper, subjects: subjects, questions: questions, attemptedQuestions: attemptedQuestions),
          key: state.pageKey,
        );
      },
    ),

    /* Attempted Papers */
    GoRoute(
      path: AppRoute.recentlyAttemptedPaper.path,
      name: AppRoute.recentlyAttemptedPaper.name,
      pageBuilder: (context, state) {
        final data = state.extra as Map<String, dynamic>;
        final attemptedPaperId = data['attempted_paper_id'] as String;
        final paperId = data['paper_id'] as String;
        return AppRouteTransition.slideFromRight(
          child: RecentlyAttemptedPaperView(recentlyAttemptedPaperId: attemptedPaperId, paperId: paperId),
          key: state.pageKey,
        );
      },
    ),

    GoRoute(
      path: AppRoute.recentlyAttemptedQuestions.path,
      name: AppRoute.recentlyAttemptedQuestions.name,
      pageBuilder: (context, state) {
        final data = state.extra as Map<String, dynamic>;
        final recentlyAttemptedPaper = data['recentlyAttemptedPaper'] as RecentlyAttemptedPaper;
        final questions = data['questions'] as List<Question>;
        return AppRouteTransition.slideFromRight(
          child: RecentlyAttemptedQuestionsView(recentlyAttemptedPaper: recentlyAttemptedPaper, questions: questions),
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
                  pageBuilder: (context, state) {
                    final examId = state.extra as String;
                    return AppRouteTransition.slideFromRight(
                      child: ExamDashboardView(examID: examId),
                      key: state.pageKey,
                    );
                  },
                ),
              ],
            ),
          ],
        ),

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
              pageBuilder: (context, state) => const NoTransitionPage(child: LeaderboardScreen()),
            ),
          ],
        ),

        /* Profile */
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoute.profile.path,
              pageBuilder: (context, state) => const NoTransitionPage(child: ProfileScreen()),
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
