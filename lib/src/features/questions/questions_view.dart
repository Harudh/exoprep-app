import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:root/src/core/common/ui/widgets/theme_toggle_switch.dart';
import 'package:root/src/models/paper_model/paper_model.dart';
import 'package:root/src/core/extensions/context_extension.dart';
import 'package:root/src/core/common/state/viewmodel_state.dart';
import 'package:root/src/models/subject_model/subject_model.dart';
import 'package:root/src/models/question_model/question_model.dart';
import 'package:root/src/features/questions/questions_viewmodel.dart';

part 'widgets/navigation_buttons.dart';
part 'widgets/question_number.dart';
part 'widgets/question_title.dart';
part 'widgets/question_image.dart';
part 'widgets/question_card.dart';
part 'widgets/option_tile.dart';
part 'questions_mixin.dart';

class QuestionsView extends StatefulWidget {
  const QuestionsView({super.key, required this.paper, required this.subjects, required this.questions});

  final Paper paper;
  final List<Subject> subjects;
  final List<Question> questions;

  @override
  State<QuestionsView> createState() => _QuestionsViewState();
}

class _QuestionsViewState extends State<QuestionsView> with QuestionsMixin {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.subjects.length,
      child: Scaffold(
        appBar: _QuestionsAppBar(paperName: widget.paper.name, subjects: widget.subjects),
        drawer: const Drawer(),
        body: _QuestionsBody(viewModel: viewModel, subjects: widget.subjects, questions: widget.questions),
      ),
    );
  }
}

class _QuestionsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _QuestionsAppBar({required this.paperName, required this.subjects});

  final String paperName;
  final List<Subject> subjects;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(paperName, style: context.titleMedium),
      actions: [
        IconButton(onPressed: () => context.pop(), icon: const Icon(Icons.close)),
        ThemeToggleSwitch(),
      ],
      bottom: _QuestionsTabBar(subjects: subjects),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 48);
}

class _QuestionsTabBar extends StatelessWidget implements PreferredSizeWidget {
  const _QuestionsTabBar({required this.subjects});

  final List<Subject> subjects;

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

class _QuestionsBody extends StatelessWidget {
  const _QuestionsBody({required this.viewModel, required this.subjects, required this.questions});

  final QuestionsViewModel viewModel;
  final List<Subject> subjects;
  final List<Question> questions;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ViewModelState>(
      valueListenable: viewModel.questionsState,
      builder: (context, state, _) {
        if (state.status == ViewModelStatus.loading) {
          return const _LoadingView();
        }

        if (state.status == ViewModelStatus.error) {
          return _ErrorView(errorMessage: state.error);
        }

        return _QuestionsTabBarView(subjects: subjects, questions: questions, viewModel: viewModel);
      },
    );
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.errorMessage});

  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(errorMessage ?? 'An error occurred', style: TextStyle(color: context.colorScheme.error)),
    );
  }
}

class _QuestionsTabBarView extends StatelessWidget {
  const _QuestionsTabBarView({required this.subjects, required this.questions, required this.viewModel});

  final List<Subject> subjects;
  final List<Question> questions;
  final QuestionsViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: subjects.map((subject) {
        final subjectQuestions = questions.where((q) => q.topic.subject.id == subject.id).toList();

        if (subjectQuestions.isEmpty) {
          return _EmptyQuestionsView(subjectName: subject.name);
        }

        return _QuestionsPageView(questions: subjectQuestions, viewModel: viewModel);
      }).toList(),
    );
  }
}

class _EmptyQuestionsView extends StatelessWidget {
  const _EmptyQuestionsView({required this.subjectName});

  final String subjectName;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("No questions found for $subjectName", style: TextStyle(color: context.colorScheme.onSurface)),
    );
  }
}

class _QuestionsPageView extends StatelessWidget {
  const _QuestionsPageView({required this.questions, required this.viewModel});

  final List<Question> questions;
  final QuestionsViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: viewModel.currentQuestionIndex,
      builder: (context, currentIndex, _) {
        return Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: viewModel.pageController,
                itemCount: questions.length,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (index) => viewModel.setCurrentQuestionIndex(index),
                itemBuilder: (context, index) {
                  return SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: _QuestionCard(question: questions[index], questionNumber: index + 1, viewModel: viewModel),
                  );
                },
              ),
            ),
            _NavigationButtons(
              viewModel: viewModel,
              currentIndex: currentIndex,
              totalQuestions: questions.length,
              currentQuestion: questions[currentIndex],
            ),
          ],
        );
      },
    );
  }
}
