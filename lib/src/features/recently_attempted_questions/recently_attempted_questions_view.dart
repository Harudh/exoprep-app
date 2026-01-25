import 'package:root/src/models/paper_model/recently_attempted_paper_model.dart';
import 'package:root/src/models/question_model/question_model.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'dart:convert';
import 'package:flutter_html/flutter_html.dart';

part 'widgets/review_header.dart';
part 'widgets/review_question_card.dart';
part 'widgets/review_option_tile.dart';
part 'widgets/review_navigation.dart';
part 'widgets/answer_status_indicator.dart';
part 'widgets/review_drawer.dart';

class RecentlyAttemptedQuestionsView extends StatefulWidget {
  const RecentlyAttemptedQuestionsView({
    required this.recentlyAttemptedPaper,
    required this.questions,
    super.key,
  });

  final RecentlyAttemptedPaper recentlyAttemptedPaper;
  final List<Question> questions;

  @override
  State<RecentlyAttemptedQuestionsView> createState() => _RecentlyAttemptedQuestionsViewState();
}

class _RecentlyAttemptedQuestionsViewState extends State<RecentlyAttemptedQuestionsView> {
  late PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _jumpToQuestion(int index) {
    _pageController.jumpToPage(index);
    setState(() => _currentIndex = index);
    Navigator.pop(context); // Close drawer
  }

  // Get response for a specific question using responses from recentlyAttemptedPaper
  QuestionResponse? _getResponseForQuestion(String questionId) {
    try {
      return widget.recentlyAttemptedPaper.responses.firstWhere(
            (response) => response.questionId == questionId,
      );
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0F0F0F) : const Color(0xFFF9FAFB),
      appBar: AppBar(
        title: const Text('Review Questions'),
        elevation: 0,
        backgroundColor: isDark ? const Color(0xFF1A1A1A) : Colors.white,
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.grid_view_rounded),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
            ),
          ),
        ],
      ),
      endDrawer: _ReviewDrawer(
        recentlyAttemptedPaper: widget.recentlyAttemptedPaper,
        questions: widget.questions,
        currentIndex: _currentIndex,
        onQuestionTap: _jumpToQuestion,
      ),
      body: Column(
        children: [
          _ReviewHeader(
            recentlyAttemptedPaper: widget.recentlyAttemptedPaper,
            currentQuestionNumber: _currentIndex + 1,
          ),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: widget.questions.length,
              onPageChanged: (index) => setState(() => _currentIndex = index),
              itemBuilder: (context, index) {
                final question = widget.questions[index];
                final response = _getResponseForQuestion(question.id);

                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: _ReviewQuestionCard(
                    question: question,
                    questionNumber: index + 1,
                    response: response,
                  ),
                );
              },
            ),
          ),
          _ReviewNavigation(
            currentIndex: _currentIndex,
            totalQuestions: widget.questions.length,
            onPrevious: () {
              if (_currentIndex > 0) {
                _pageController.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }
            },
            onNext: () {
              if (_currentIndex < widget.questions.length - 1) {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }
            },
            onClose: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
