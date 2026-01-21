import 'package:root/src/core/common/ui/widgets/background_gradient.dart';
import 'package:root/src/features/exam_dashboard/exam_dashboard_viewmodel.dart';
import 'package:root/src/core/extensions/app_scope_extension.dart';
import 'package:root/src/core/common/state/viewmodel_state.dart';
import 'package:root/src/core/extensions/context_extension.dart';
import 'package:root/src/models/paper_model/attempted_paper_model.dart';
import 'package:root/src/models/paper_model/paper_model.dart';
import 'package:root/src/core/navigation/routes.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

part 'widgets/practice_papers_section.dart';
part 'widgets/exam_dashboard_header.dart';
part 'widgets/continue_section.dart';
part 'widgets/recents_section.dart';
part 'widgets/streak_section.dart';
part 'exam_dashboard_mixin.dart';

class ExamDashboardView extends StatefulWidget {
  const ExamDashboardView({this.examID = 'cmjrion9f0000s0z704q22aqf', super.key});

  final String examID;

  static const double horizontalPadding = 12;

  @override
  State<ExamDashboardView> createState() => _ExamDashboardViewState();
}

class _ExamDashboardViewState extends State<ExamDashboardView> with ExamDashboardMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundGradient(
        child: CustomScrollView(
          slivers: [
            const ExamDashboardHeader(examName: "JEE Mains"),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),

            StreakSection(viewModel: _examDashboardViewModel),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),

            ContinueSection(viewModel: _examDashboardViewModel),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),

            RecentsSection(viewModel: _examDashboardViewModel),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),

            PracticePapersSection(viewModel: _examDashboardViewModel),
            const SliverToBoxAdapter(child: SizedBox(height: 40)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.quiz),
        label: const Text('Quick Quiz'),
        onPressed: () async {
          final user = FirebaseAuth.instance.currentUser!;
          final token = await user.getIdToken();

          // This function splits the token into chunks of 800 characters
          // so the console doesn't truncate (cut off) the long string.
          void printFullToken(String text) {
            final pattern = RegExp('.{1,800}');
            pattern.allMatches(text).forEach((match) => print(match.group(0)));
          }

          print('--- START TOKEN ---');
          printFullToken(token!);
          print('--- END TOKEN ---');
        },
        backgroundColor: context.isDarkMode ? Colors.grey.shade800 : Colors.black,
        foregroundColor: Colors.white,
      ),
    );
  }
}
