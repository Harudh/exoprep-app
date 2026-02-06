import 'package:flutter/material.dart';
import 'package:root/src/core/extensions/context_extension.dart';
import 'package:root/src/models/question_model/question_model.dart';

class ReadPaperTabBar extends StatelessWidget implements PreferredSizeWidget {
  const ReadPaperTabBar({required this.subjects});

  final List<SubjectInQuestion> subjects;

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: Align(
        alignment: Alignment.centerLeft,
        child: TabBar(
          isScrollable: false,
          tabAlignment: TabAlignment.fill,
          dividerColor: Colors.transparent,
          splashFactory: NoSplash.splashFactory,
          labelColor: context.colorScheme.primary,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorColor: context.colorScheme.primary,
          tabs: subjects.map((s) => Tab(text: s.name)).toList(),
          labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          unselectedLabelColor: context.colorScheme.surface.withValues(alpha: 0.6),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(48);
}
