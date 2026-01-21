import 'package:root/src/core/common/ui/widgets/background_gradient.dart';
import 'package:root/src/core/common/ui/widgets/theme_toggle_switch.dart';
import 'package:root/src/core/extensions/context_extension.dart';
import 'package:root/src/core/navigation/routes.dart';
import 'package:root/src/core/theme/colors.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final List<Map<String, dynamic>> myExams = [
    {'name': 'JEE Mains', 'color': const Color(0xFF6366F1), 'icon': Icons.engineering},
    {'name': 'NEET', 'color': const Color(0xFFEC4899), 'icon': Icons.medical_services},
    {'name': 'GATE', 'color': const Color(0xFF8B5CF6), 'icon': Icons.computer},
    {'name': 'CAT', 'color': const Color(0xFF10B981), 'icon': Icons.school},
  ];

  final List<Map<String, dynamic>> popularExams = [
    {'name': 'JEE Main 2026', 'date': 'Apr 2026', 'enrolled': '2.4M'},
    {'name': 'NEET UG 2026', 'date': 'May 2026', 'enrolled': '1.8M'},
    {'name': 'GATE 2026', 'date': 'Feb 2026', 'enrolled': '950K'},
    // {'name': 'CAT 2025', 'date': 'Nov 2025', 'enrolled': '340K'},
    // {'name': 'UPSC CSE 2026', 'date': 'Jun 2026', 'enrolled': '1.1M'},
  ];

  final List<Map<String, dynamic>> todos = [
    {'task': 'Physics: Thermodynamics revision', 'completed': false},
    {'task': 'Chemistry: Practice redox reactions', 'completed': false},
    {'task': 'Math: Complete trigonometry exercises', 'completed': true},
    {'task': 'Take weekly mock test', 'completed': false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const ThemeToggleSwitch(),
      body: BackgroundGradient(
        child: CustomScrollView(
          slivers: [
            // Header
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 64, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome back,",
                          style: context.bodySmall!.copyWith(color: Colors.grey.shade600, letterSpacing: -0.2),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          "Zahaan Mahajan",
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
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text("Exams", style: context.titleMedium!.copyWith(fontWeight: FontWeight.w700, letterSpacing: -0.5)),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 12)),

            SliverToBoxAdapter(
              child: SizedBox(
                height: 225,
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  scrollDirection: Axis.horizontal,
                  itemCount: myExams.length + 1,
                  itemBuilder: (context, index) {
                    final screenWidth = MediaQuery.of(context).size.width;
                    final cardWidth = screenWidth * 0.9;

                    if (index == myExams.length) {
                      return Container(
                        width: cardWidth,
                        margin: const EdgeInsets.only(left: 12),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: context.isDarkMode ? Colors.grey.shade800 : Colors.grey.shade300, width: 1.5),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add_circle_outline, size: 36, color: Colors.grey.shade400),
                              const SizedBox(height: 12),
                              Text(
                                "Add New Exam",
                                style: context.titleMedium!.copyWith(color: Colors.grey.shade600, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    const totalPapers = 60;
                    final exam = myExams[index];
                    final papersGiven = 28 + (index * 4);
                    final accuracy = 85 - (index * 3);
                    final rank = 980 - (index * 120);
                    final streak = 15 + (index * 2);
                    final progress = papersGiven / totalPapers;

                    return GestureDetector(
                      onTap: () {
                        AppRoute.examDashboard.pushNested(context, AppRoute.home);
                      },
                      child: Container(
                        width: cardWidth,
                        margin: const EdgeInsets.only(right: 12),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: context.isDarkMode ? Colors.grey.shade900 : Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: context.isDarkMode ? Colors.grey.shade800 : Colors.grey.shade300),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  exam['name'] as String,
                                  style: context.headlineSmall!.copyWith(fontWeight: FontWeight.w800, letterSpacing: -0.5),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: context.isDarkMode ? Colors.grey.shade900 : Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: context.isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(Icons.trending_up, size: 12, color: Colors.grey.shade600),
                                      const SizedBox(width: 4),
                                      Text(
                                        "#$rank",
                                        style: context.bodySmall!.copyWith(fontWeight: FontWeight.w700, fontSize: 11),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Competitive Engineering Examination",
                              style: context.bodySmall!.copyWith(color: Colors.grey.shade600, fontSize: 12),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Progress", style: context.bodySmall!.copyWith(fontWeight: FontWeight.w600, fontSize: 12)),
                                Text(
                                  "$papersGiven/$totalPapers papers",
                                  style: context.bodySmall!.copyWith(fontWeight: FontWeight.w700, fontSize: 12),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: LinearProgressIndicator(
                                value: progress,
                                backgroundColor: context.isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200,
                                // color: context.isDarkMode ? Colors.white : Colors.black,
                                color: AppColors.primaryColor,
                                minHeight: 6,
                              ),
                            ),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: context.isDarkMode ? Colors.grey.shade900 : Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: context.isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.check_circle_outline, size: 34, color: Colors.green),
                                      const SizedBox(width: 6),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("$accuracy%", style: context.bodyLarge!.copyWith(fontWeight: FontWeight.w800)),
                                          Text(
                                            "Accuracy",
                                            style: context.bodySmall!.copyWith(color: Colors.grey.shade600, fontSize: 10),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Container(
                                    width: 1,
                                    height: 30,
                                    color: context.isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(Icons.local_fire_department, size: 34, color: Colors.orange),
                                      const SizedBox(width: 6),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("$streak", style: context.bodyLarge!.copyWith(fontWeight: FontWeight.w800)),
                                          Text(
                                            "Day Streak",
                                            style: context.bodySmall!.copyWith(color: Colors.grey.shade600, fontSize: 10),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
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
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final exam = popularExams[index];
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
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
                              exam['name'] as String,
                              style: context.bodyLarge!.copyWith(fontWeight: FontWeight.w600, letterSpacing: -0.3),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "${exam['date']} • ${exam['enrolled']} students",
                              style: context.bodySmall!.copyWith(color: Colors.grey.shade600, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      Icon(Icons.chevron_right, color: Colors.grey.shade400),
                    ],
                  ),
                );
              }, childCount: popularExams.length),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
          ],
        ),
      ),
    );
  }
}
