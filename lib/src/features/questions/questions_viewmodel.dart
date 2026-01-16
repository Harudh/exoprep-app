import 'package:root/src/core/common/state/viewmodel_state.dart';
import 'package:flutter/material.dart';
import 'package:root/src/models/question_model/question_model.dart';

class QuestionsViewModel {
  QuestionsViewModel();

  final ValueNotifier<ViewModelState> questionsState = ValueNotifier(ViewModelState.idle());

  final ValueNotifier<int> currentQuestionIndex = ValueNotifier(0);

  final ValueNotifier<Map<String, List<int>>> selectedAnswers = ValueNotifier({});

  final ValueNotifier<Set<String>> markedForLater = ValueNotifier({});

  final PageController pageController = PageController();

  void initializeQuestions(List<Question> questions) {
    if (questions.isEmpty) {
      questionsState.value = ViewModelState.error(error: 'No questions available');
      return;
    }

    questionsState.value = ViewModelState.success(data: questions);
  }

  void setCurrentQuestionIndex(int index) {
    currentQuestionIndex.value = index;
  }

  void toggleOption(String questionId, int optionIndex, bool isMultipleChoice) {
    final currentSelections = Map<String, List<int>>.from(selectedAnswers.value);
    final questionSelections = List<int>.from(currentSelections[questionId] ?? []);

    if (isMultipleChoice) {
      if (questionSelections.contains(optionIndex)) {
        questionSelections.remove(optionIndex);
      } else {
        questionSelections.add(optionIndex);
      }
    } else {
      if (questionSelections.contains(optionIndex)) {
        questionSelections.clear();
      } else {
        questionSelections.clear();
        questionSelections.add(optionIndex);
      }
    }

    currentSelections[questionId] = questionSelections;
    selectedAnswers.value = currentSelections;
  }

  void markForLater(String questionId) {
    final marked = Set<String>.from(markedForLater.value);
    if (marked.contains(questionId)) {
      marked.remove(questionId);
    } else {
      marked.add(questionId);
    }
    markedForLater.value = marked;
  }

  void nextQuestion() {
    if (pageController.hasClients) {
      pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  void previousQuestion() {
    if (pageController.hasClients) {
      pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  void jumpToQuestion(int index) {
    if (pageController.hasClients) {
      pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  void finishQuiz() {
    // Handle quiz completion
    debugPrint('Quiz finished!');
    debugPrint('Selected answers: ${selectedAnswers.value}');
    debugPrint('Marked for later: ${markedForLater.value}');
  }

  void setLoading() {
    questionsState.value = ViewModelState.loading();
  }

  void setError(String error) {
    questionsState.value = ViewModelState.error(error: error);
  }

  void dispose() {
    questionsState.dispose();
    currentQuestionIndex.dispose();
    selectedAnswers.dispose();
    markedForLater.dispose();
    pageController.dispose();
  }
}
