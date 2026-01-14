import 'package:flutter/material.dart';
import 'package:root/src/models/paper_model/paper_model.dart';
import 'package:root/src/models/question_model/question_model.dart';
import 'package:root/src/models/subject_model/subject_model.dart';

class QuestionsView extends StatefulWidget {
  const QuestionsView({super.key, required this.paper, required this.subjects, required this.questions});

  final Paper paper;
  final List<Subject> subjects;
  final List<Question> questions;

  @override
  State<QuestionsView> createState() => _QuestionsViewState();
}

class _QuestionsViewState extends State<QuestionsView> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: widget.subjects.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Filter questions by subject
  List<Question> _getQuestionsForSubject(String subjectId) {
    return widget.questions.where((question) {
      return question.topic.subject.id == subjectId;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.paper.name),
        centerTitle: true,
        bottom: widget.subjects.isEmpty
            ? null
            : TabBar(
                controller: _tabController,
                isScrollable: true,
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: widget.subjects.map((subject) {
                  final questionCount = _getQuestionsForSubject(subject.id).length;
                  return Tab(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(subject.name),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '$questionCount',
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
      ),
      body: widget.subjects.isEmpty
          ? const Center(child: Text('No subjects available'))
          : TabBarView(
              controller: _tabController,
              children: widget.subjects.map((subject) {
                final subjectQuestions = _getQuestionsForSubject(subject.id);

                if (subjectQuestions.isEmpty) {
                  return Center(child: Text('No questions available for ${subject.name}'));
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: subjectQuestions.length,
                  itemBuilder: (context, index) {
                    final question = subjectQuestions[index];
                    return _QuestionCard(question: question, questionNumber: index + 1);
                  },
                );
              }).toList(),
            ),
    );
  }
}

class _QuestionCard extends StatelessWidget {
  final Question question;
  final int questionNumber;

  const _QuestionCard({required this.question, required this.questionNumber});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(8)),
                  child: Text(
                    'Q$questionNumber',
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(question.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, height: 1.4)),
                ),
              ],
            ),
            if (question.topic.name.isNotEmpty) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(6)),
                child: Text(
                  question.topic.name,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade700, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
