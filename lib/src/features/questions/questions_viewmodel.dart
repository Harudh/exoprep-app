import 'package:root/src/models/question_model/attempted_question_model.dart';
import 'package:root/src/models/question_model/question_model.dart';
import 'package:root/src/core/common/state/viewmodel_state.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class QuestionsViewModel {
  QuestionsViewModel();

  final ValueNotifier<ViewModelState> questionsState = ValueNotifier(ViewModelState.idle());

  final ValueNotifier<int> currentQuestionIndex = ValueNotifier(0);

  final ValueNotifier<Map<String, List<int>>> selectedAnswers = ValueNotifier({});

  final ValueNotifier<Map<String, String>> numericalAnswers = ValueNotifier({});

  final ValueNotifier<Set<String>> markedForLater = ValueNotifier({});

  final Map<String, PageController> _subjectPageControllers = {};
  final Map<String, ValueNotifier<int>> _subjectQuestionIndices = {};

  PageController getSubjectPageController(String subjectId) {
    return _subjectPageControllers.putIfAbsent(subjectId, () => PageController());
  }

  ValueNotifier<int> getSubjectQuestionIndex(String subjectId) {
    return _subjectQuestionIndices.putIfAbsent(subjectId, () => ValueNotifier(0));
  }

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

  void setSubjectQuestionIndex(String subjectId, int index) {
    final notifier = getSubjectQuestionIndex(subjectId);
    notifier.value = index;
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

    if (questionSelections.isEmpty) {
      currentSelections.remove(questionId);
    } else {
      currentSelections[questionId] = questionSelections;
    }

    selectedAnswers.value = currentSelections;
  }

  void setNumericalAnswer(String questionId, String answer) {
    final currentAnswers = Map<String, String>.from(numericalAnswers.value);

    if (answer.trim().isEmpty) {
      currentAnswers.remove(questionId);
    } else {
      currentAnswers[questionId] = answer.trim();
    }

    numericalAnswers.value = currentAnswers;
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

  int get attemptedCount => selectedAnswers.value.length + numericalAnswers.value.length;

  int get markedCount => markedForLater.value.length;

  int getUnattemptedCount(int totalQuestions) {
    return totalQuestions - attemptedCount;
  }

  void nextQuestion(String subjectId) {
    final controller = getSubjectPageController(subjectId);
    if (controller.hasClients) {
      controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  void previousQuestion(String subjectId) {
    final controller = getSubjectPageController(subjectId);
    if (controller.hasClients) {
      controller.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  void jumpToQuestionInSubject(String subjectId, int index) {
    final controller = getSubjectPageController(subjectId);
    if (controller.hasClients) {
      controller.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  AttemptedQuestions prepareSubmissionData(String paperId, List<Question> allQuestions) {
    final List<AttemptedQuestion> attemptedQuestions = allQuestions.map((question) {
      // Check if it's a numerical question
      if (question.answer != null && question.answer!.isNotEmpty) {
        return AttemptedQuestion(
          questionId: question.id,
          correctAnswer: question.answer,
          attemptedAnswer: numericalAnswers.value[question.id],
          correctOptionIndexes: null,
          attemptedOptionIndexes: null,
        );
      } else {
        // MCQ question
        return AttemptedQuestion(
          questionId: question.id,
          correctAnswer: null,
          attemptedAnswer: null,
          correctOptionIndexes: question.correctOptionIndexes,
          attemptedOptionIndexes: selectedAnswers.value[question.id],
        );
      }
    }).toList();

    return AttemptedQuestions(paperId: paperId, questions: attemptedQuestions);
  }

  Future<void> submitQuiz(String paperId, List<Question> allQuestions) async {
    try {
      setLoading();

      final submissionData = prepareSubmissionData(paperId, allQuestions);

      debugPrint('Submission Data: ${jsonEncode(submissionData.toJson())}');

      // TODO: Replace with your actual API call
      // final response = await http.post(
      //   Uri.parse('YOUR_API_ENDPOINT'),
      //   headers: {'Content-Type': 'application/json'},
      //   body: jsonEncode(submissionData.toJson()),
      // );

      // if (response.statusCode == 200) {
      //   debugPrint('Quiz submitted successfully');
      //   questionsState.value = ViewModelState.success(data: 'Submitted');
      // } else {
      //   throw Exception('Failed to submit quiz');
      // }

      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      questionsState.value = ViewModelState.success(data: 'Submitted');
    } catch (e) {
      debugPrint('Error submitting quiz: $e');
      setError('Failed to submit quiz: $e');
    }
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
    numericalAnswers.dispose();
    markedForLater.dispose();

    for (var controller in _subjectPageControllers.values) {
      controller.dispose();
    }
    for (var notifier in _subjectQuestionIndices.values) {
      notifier.dispose();
    }
    _subjectPageControllers.clear();
    _subjectQuestionIndices.clear();
  }
}
