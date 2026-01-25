import 'package:root/src/models/paper_model/recently_attempted_paper_model.dart';
import '../../models/question_model/question_model.dart';
import 'package:flutter/material.dart';

class RecentlyAttemptedQuestionsView extends StatefulWidget {
  const RecentlyAttemptedQuestionsView({required this.recentlyAttemptedPaper, required this.questions, super.key});

  final RecentlyAttemptedPaper recentlyAttemptedPaper;
  final List<Question> questions;

  @override
  State<RecentlyAttemptedQuestionsView> createState() => _RecentlyAttemptedQuestionsViewState();
}

class _RecentlyAttemptedQuestionsViewState extends State<RecentlyAttemptedQuestionsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
          children: [

          ],
      ),
    );
  }
}
