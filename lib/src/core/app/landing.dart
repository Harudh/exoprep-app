import 'package:root/src/core/extensions/context_extension.dart';
import 'package:root/src/core/theme/colors.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Landing extends StatelessWidget {
  const Landing({
    required this.navigationShell,
    super.key,
  });

  final StatefulNavigationShell navigationShell;

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBody: true,
      body: navigationShell,
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        child: NavigationBar(
          backgroundColor: isDark ? const Color(0xFF1C1C1E) : const Color(0xFFF2F4F6),
          indicatorColor: isDark ? Colors.grey.shade900 : Colors.grey.shade200,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          overlayColor: WidgetStateProperty.all(Colors.transparent),
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: _goBranch,
          height: 72,
          destinations: const [
            NavigationDestination(
              icon: Icon(CupertinoIcons.house, color: Colors.grey, size: 26),
              selectedIcon: Icon(CupertinoIcons.house_fill, color: AppColors.primaryColor, size: 26),
              label: 'Home',
            ),
            // NavigationDestination(
            //   icon: Icon(Icons.task_alt, color: Colors.grey, size: 26),
            //   selectedIcon: Icon(Icons.task_alt, color: AppColors.primaryColor, size: 26),
            //   label: 'Productivity',
            // ),
            NavigationDestination(
              icon: Icon(Icons.style_outlined, color: Colors.grey, size: 26),
              selectedIcon: Icon(Icons.style, color: AppColors.primaryColor, size: 26),
              label: 'Flashcards',
            ),
            NavigationDestination(
              icon: Icon(Icons.bar_chart_outlined, color: Colors.grey, size: 26),
              selectedIcon: Icon(Icons.bar_chart, color: AppColors.primaryColor, size: 26),
              label: 'Leaderboard',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline, color: Colors.grey, size: 26),
              selectedIcon: Icon(Icons.person, color: AppColors.primaryColor, size: 26),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
