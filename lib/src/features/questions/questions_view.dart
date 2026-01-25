import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:root/src/core/constants/enums.dart';
import 'package:root/src/core/navigation/routes.dart';
import 'package:root/src/models/paper_model/paper_model.dart';
import 'package:root/src/core/extensions/context_extension.dart';
import 'package:root/src/core/common/state/viewmodel_state.dart';
import 'package:root/src/models/subject_model/subject_model.dart';
import 'package:root/src/models/question_model/question_model.dart';
import 'package:root/src/features/questions/questions_viewmodel.dart';
import 'package:root/src/core/common/ui/widgets/theme_toggle_switch.dart';

part 'widgets/finish_paper_dialog.dart';
part 'widgets/quit_paper_dialog.dart';
part 'widgets/navigation_buttons.dart';
part 'widgets/questions_drawer.dart';
part 'widgets/question_number.dart';
part 'widgets/question_title.dart';
part 'widgets/question_image.dart';
part 'widgets/question_card.dart';
part 'widgets/timer_widget.dart';
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
  Future<bool> _onWillPop() async {
    final bool? shouldQuit = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return _QuitPaperDialog(
          attemptedCount: viewModel.attemptedCount,
          totalQuestions: widget.questions.length,
        );
      },
    );

    return shouldQuit ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;

        final shouldPop = await _onWillPop();
        if (shouldPop && context.mounted) {
          Navigator.of(context).pop();
        }
      },
      child: DefaultTabController(
        length: widget.subjects.length,
        child: GestureDetector(
          onTap: () => context.unfocus(),
          child: Scaffold(
            drawer: QuestionsDrawer(viewModel: viewModel, questions: widget.questions, subjects: widget.subjects),
            appBar: _QuestionsAppBar(
              paperName: widget.paper.name,
              subjects: widget.subjects,
              viewModel: viewModel,
              totalQuestions: widget.questions.length, // Pass the correct total
            ),
            body: _QuestionsBody(
              viewModel: viewModel,
              subjects: widget.subjects,
              questions: widget.questions,
              paper: widget.paper,
            ),
          ),
        ),
      ),
    );
  }
}

class _QuestionsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _QuestionsAppBar({
    required this.paperName,
    required this.subjects,
    required this.viewModel,
    required this.totalQuestions, // Add this parameter
  });

  final String paperName;
  final List<Subject> subjects;
  final QuestionsViewModel viewModel;
  final int totalQuestions; // Add this

  Future<void> _handleQuit(BuildContext context) async {
    final bool? shouldQuit = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return _QuitPaperDialog(
          attemptedCount: viewModel.attemptedCount,
          totalQuestions: totalQuestions, // Use the passed total
        );
      },
    );

    if (shouldQuit == true && context.mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(paperName, style: context.titleMedium),
      actions: [
        _TimerWidget(viewModel: viewModel),
        const SizedBox(width: 8),
        IconButton(
          onPressed: () => _handleQuit(context),
          icon: Icon(Icons.close_rounded),
          tooltip: 'Quit Test',
          style: IconButton.styleFrom(backgroundColor: Colors.red.withValues(alpha: 0.1), foregroundColor: Colors.red),
        ),
        const SizedBox(width: 4),
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
  const _QuestionsBody({required this.paper, required this.viewModel, required this.subjects, required this.questions});

  final QuestionsViewModel viewModel;
  final List<Subject> subjects;
  final List<Question> questions;
  final Paper paper;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ViewModelState>(
      valueListenable: viewModel.questionsState,
      builder: (context, state, _) {
        if (state.status == ViewModelStatus.loading && state.data == QuestionStates.dataLoading) {
          return const _LoadingView();
        }

        if (state.status == ViewModelStatus.error && state.type == QuestionStates.dataLoadingError) {
          return _ErrorView(errorMessage: state.error);
        }

        return _QuestionsTabBarView(subjects: subjects, questions: questions, viewModel: viewModel, paper: paper);
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

class _EmptyQuestionsView extends StatelessWidget {
  const _EmptyQuestionsView({required this.subjectName});

  final String subjectName;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("No questions found for $subjectName", style: TextStyle(color: context.colorScheme.surface)),
    );
  }
}

class _QuestionsTabBarView extends StatelessWidget {
  const _QuestionsTabBarView({required this.paper, required this.subjects, required this.questions, required this.viewModel});

  final Paper paper;
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

        return _QuestionsPageView(
          questions: subjectQuestions,
          allQuestions: questions,
          viewModel: viewModel,
          subjects: subjects,
          subject: subject,
          paper: paper,
        );
      }).toList(),
    );
  }
}

class _QuestionsPageView extends StatefulWidget {
  const _QuestionsPageView({
    required this.paper,
    required this.subject,
    required this.subjects,
    required this.questions,
    required this.viewModel,
    required this.allQuestions,
  });

  final Paper paper;
  final Subject subject;
  final List<Subject> subjects;
  final List<Question> questions;
  final List<Question> allQuestions;
  final QuestionsViewModel viewModel;

  @override
  State<_QuestionsPageView> createState() => _QuestionsPageViewState();
}

class _QuestionsPageViewState extends State<_QuestionsPageView> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final pageController = widget.viewModel.getSubjectPageController(widget.subject.id);
    final questionIndexNotifier = widget.viewModel.getSubjectQuestionIndex(widget.subject.id);

    return ValueListenableBuilder<int>(
      valueListenable: questionIndexNotifier,
      builder: (context, currentIndex, _) {
        return Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: pageController,
                itemCount: widget.questions.length,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (index) => widget.viewModel.setSubjectQuestionIndex(widget.subject.id, index),
                itemBuilder: (context, index) {
                  return SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: _QuestionCard(
                      question: widget.questions[index],
                      questionNumber: index + 1,
                      viewModel: widget.viewModel,
                    ),
                  );
                },
              ),
            ),
            _NavigationButtons(
              viewModel: widget.viewModel,
              subject: widget.subject,
              subjects: widget.subjects,
              currentIndex: currentIndex,
              totalQuestionsInSubject: widget.questions.length,
              currentQuestion: widget.questions[currentIndex],
              allQuestions: widget.allQuestions,
              paper: widget.paper,
            ),
          ],
        );
      },
    );
  }
}
