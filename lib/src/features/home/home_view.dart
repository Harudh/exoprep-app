import 'package:root/src/core/common/ui/widgets/background_gradient.dart';
import 'package:root/src/core/extensions/app_scope_extension.dart';
import 'package:root/src/core/common/state/viewmodel_state.dart';
import 'package:root/src/core/extensions/context_extension.dart';
import 'package:root/src/features/home/empty_userexams_container.dart';
import 'package:root/src/features/home/user_exms_shimmer.dart';
import 'package:root/src/features/home/user_exam_container.dart';
import 'package:root/src/features/home/home_viewmodel.dart';
import 'package:root/src/models/exam_model/exam_model.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:flutter/material.dart';

part 'home_mixin.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with HomeMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundGradient(
        child: CustomScrollView(
          slivers: [
            // Header
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 64, 12, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /*
                        Text(
                          "Welcome back,",
                          style: context.bodySmall!.copyWith(color: Colors.grey.shade600, letterSpacing: -0.2),
                        ),
                        const SizedBox(height: 2),
                        */
                        Text(
                          "Welcome back",
                          style: context.headlineSmall!.copyWith(fontWeight: FontWeight.w800, letterSpacing: -0.5),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 44,
                        width: 44,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: context.isDarkMode ? Colors.grey.shade800 : Colors.grey.shade100,
                          border: Border.all(color: context.isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300),
                        ),
                        child: const Icon(IonIcons.notifications, size: 22),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),

            // My Exams Section
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text("Exams", style: context.titleMedium!.copyWith(fontWeight: FontWeight.w700, letterSpacing: -0.5)),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 12)),

            SliverToBoxAdapter(
              child: SizedBox(
                height: 225,
                child: ValueListenableBuilder(
                  valueListenable: _homeViewmodel.homeViewState,
                  builder: (context, value, child) {
                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      scrollDirection: Axis.horizontal,
                      itemCount: _homeViewmodel.userExams.value.length + 1,
                      itemBuilder: (context, index) {
                        final screenWidth = context.screenWidth;
                        final cardWidth = screenWidth * 0.9;

                        if (value.status == ViewModelStatus.loading) {
                          return Row(
                            children: [
                              ExamCardShimmer(width: cardWidth),
                              EmptyUserExamContainer(homeViewmodel: _homeViewmodel, cardWidth: cardWidth),
                            ],
                          );
                        } else if (_homeViewmodel.userExams.value.isEmpty || index == _homeViewmodel.userExams.value.length) {
                          return EmptyUserExamContainer(homeViewmodel: _homeViewmodel, cardWidth: cardWidth);
                        }

                        return UserExamContainer(
                          cardWidth: cardWidth,
                          exam: _homeViewmodel.userExams.value[index],
                          viewModel: _homeViewmodel,
                        );
                      },
                    );
                  },
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 28)),

            // Popular Exams Section
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Popular Exams", style: context.titleMedium!.copyWith(fontWeight: FontWeight.w700, letterSpacing: -0.5)),
                    Text(
                      "View all",
                      style: context.bodySmall!.copyWith(
                        decorationColor: Colors.grey.shade400,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w700,
                        decorationThickness: 1.2,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 12)),

            // Popular Exams List
            ValueListenableBuilder(
              valueListenable: _homeViewmodel.homeViewState,
              builder: (context, value, child) {
                if (_homeViewmodel.popularExams.value.isEmpty) {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => const PopularExamShimmer(),
                      childCount: 5, // Show 5 skeleton rows
                    ),
                  );
                }
                return SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final List<Exam> exam = _homeViewmodel.popularExams.value;
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: context.isDarkMode ? Colors.grey.shade900 : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: context.isDarkMode ? Colors.grey.shade800 : Colors.grey.shade300),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  exam[index].name,
                                  style: context.bodyLarge!.copyWith(fontWeight: FontWeight.w600, letterSpacing: -0.3),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "June • 1.5M students",
                                  style: context.bodySmall!.copyWith(color: Colors.grey.shade600, fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          Icon(Icons.chevron_right, color: Colors.grey.shade400),
                        ],
                      ),
                    );
                  }, childCount: _homeViewmodel.popularExams.value.length),
                );
              },
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
          ],
        ),
      ),
    );
  }
}
