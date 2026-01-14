import 'package:go_router/go_router.dart';
import 'package:root/src/core/extensions/context_extension.dart';
import 'package:root/src/core/navigation/routes.dart';
import 'package:root/src/models/paper_model/paper_model.dart';
import 'package:root/src/core/theme/colors.dart';
import 'package:flutter/material.dart';

class InstructionsView extends StatelessWidget {
  const InstructionsView({required this.paper, super.key});

  final Paper paper;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Instructions')),
      body: Column(children: [Center(child: Text('Content'))]),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 36),
        child: GestureDetector(
          onTap: () => context.pushReplacement(AppRoute.attemptPaper.path, extra: paper),
          child: Container(
            height: 56,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(color: AppColors.primaryColor, borderRadius: BorderRadius.circular(30)),
            child: Center(
              child: Text(
                "Continue",
                style: context.titleMedium!.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
