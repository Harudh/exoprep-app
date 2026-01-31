import 'package:root/src/core/common/ui/overlays/alert_overlay.dart';
import 'package:root/src/features/exam_dashboard/exam_dashboard_viewmodel.dart';
import 'package:root/src/core/common/ui/widgets/background_gradient.dart';
import 'package:root/src/models/streak_heatmap_model/streak_heatmap.dart';
import 'package:root/src/models/paper_model/attempted_paper_model.dart';
import 'package:root/src/core/extensions/app_scope_extension.dart';
import 'package:root/src/core/common/state/viewmodel_state.dart';
import 'package:root/src/core/extensions/context_extension.dart';
import 'package:root/src/models/paper_model/paper_model.dart';
import 'package:root/src/core/navigation/routes.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

part 'widgets/practice_papers_section.dart';
part 'widgets/exam_dashboard_header.dart';
part 'widgets/continue_section.dart';
part 'widgets/recents_section.dart';
part 'widgets/streak_section.dart';
part 'exam_dashboard_mixin.dart';

class ExamDashboardView extends StatefulWidget {
  const ExamDashboardView({required this.examID, required this.examName, super.key});

  final String examID;
  final String examName;

  static const double horizontalPadding = 12;

  @override
  State<ExamDashboardView> createState() => _ExamDashboardViewState();
}

class _ExamDashboardViewState extends State<ExamDashboardView> with ExamDashboardMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundGradient(
        child: DefaultTabController(
          length: 2,
          child: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return [
                ExamDashboardHeader(examName: widget.examName),
                const SliverToBoxAdapter(child: SizedBox(height: 24)),

                StreakSection(viewModel: _examDashboardViewModel),
                const SliverToBoxAdapter(child: SizedBox(height: 24)),

                ContinueSection(viewModel: _examDashboardViewModel),
                const SliverToBoxAdapter(child: SizedBox(height: 24)),

                RecentsSection(viewModel: _examDashboardViewModel),
                const SliverToBoxAdapter(child: SizedBox(height: 24)),

                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: ExamDashboardView.horizontalPadding),
                    child: Text(
                      "Practice Papers",
                      style: context.titleMedium!.copyWith(fontWeight: FontWeight.w700, letterSpacing: -0.5),
                    ),
                  ),
                ),

                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: ExamDashboardView.horizontalPadding, vertical: 8),
                    child: Container(
                      decoration: BoxDecoration(
                        color: context.isDarkMode ? Colors.grey.shade900 : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TabBar(
                        dividerColor: Colors.transparent,
                        labelColor: context.isDarkMode ? Colors.white : Colors.black,
                        unselectedLabelColor: Colors.grey.shade600,
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicator: BoxDecoration(
                          color: context.isDarkMode ? Colors.grey.shade800 : Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelStyle: context.bodyMedium!.copyWith(fontWeight: FontWeight.w600, letterSpacing: -0.3),
                        tabs: const [
                          Tab(text: 'PYQ'),
                          Tab(text: 'Mock Tests'),
                        ],
                      ),
                    ),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 12)),
              ];
            },

            // The body contains the TabBarView
            body: Container(
              // Optional: Match background color to avoid visual glitches during scroll
              color: Colors.transparent,
              child: TabBarView(
                children: [
                  _PYQTab(viewModel: _examDashboardViewModel),
                  _MockTestsTab(viewModel: _examDashboardViewModel),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
