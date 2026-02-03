import 'package:flutter/material.dart';
import 'package:root/src/core/extensions/context_extension.dart';
import 'package:root/src/core/navigation/router.dart';
import 'package:root/src/core/navigation/routes.dart';
import 'package:root/src/features/home/home_viewmodel.dart';

class EmptyUserExamContainer extends StatelessWidget {
  const EmptyUserExamContainer({super.key, required HomeViewmodel homeViewmodel, required this.cardWidth})
    : _homeViewmodel = homeViewmodel;

  final HomeViewmodel _homeViewmodel;
  final double cardWidth;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await router.push(AppRoute.selectExams.path);
        await _homeViewmodel.fetchDashboardData();
      },
      child: Container(
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
      ),
    );
  }
}
