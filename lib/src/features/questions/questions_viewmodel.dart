import 'package:root/src/models/question_model/attempted_question_response_model.dart';
import 'package:root/src/models/question_model/paper_submission.dart';
import 'package:root/src/models/question_model/question_model.dart';
import 'package:root/src/core/common/state/viewmodel_state.dart';
import 'package:root/src/repositories/papers_repository.dart';
import 'package:root/src/core/constants/enums.dart';
import 'package:flutter/material.dart';
import 'dart:developer';
import 'dart:convert';
import 'dart:async';

class QuestionsViewModel {
  final PapersRepository _papersRepository;

  // ==================== DEBUG CONFIGURATION ====================
  // Set to true for testing with shorter timer
  static const bool _debugMode = false;

  // Alternatively, use different test durations:
  static const int _debugTimerSeconds = 30;
  // static const int _debugTimerSeconds = 60;
  // static const int _debugTimerSeconds = 300;
  // ============================================================

  QuestionsViewModel({PapersRepository? papersRepository}) : _papersRepository = papersRepository ?? PapersRepository();

  final ValueNotifier<ViewModelState> questionsState = ValueNotifier(ViewModelState.idle(data: QuestionStates.idle));
  final ValueNotifier<int> currentQuestionIndex = ValueNotifier(0);
  final ValueNotifier<Map<String, List<int>>> selectedAnswers = ValueNotifier({});
  final ValueNotifier<Map<String, String>> numericalAnswers = ValueNotifier({});
  final ValueNotifier<Set<String>> markedForLater = ValueNotifier({});

  // Timer related
  final ValueNotifier<int> remainingSeconds = ValueNotifier(0);
  DateTime? testStartTime;
  Timer? _countdownTimer;
  VoidCallback? onTimerEnd;

  final Map<String, PageController> _subjectPageControllers = {};
  final Map<String, ValueNotifier<int>> _subjectQuestionIndices = {};

  PageController getSubjectPageController(String subjectId) {
    return _subjectPageControllers.putIfAbsent(subjectId, () => PageController());
  }

  ValueNotifier<int> getSubjectQuestionIndex(String subjectId) {
    return _subjectQuestionIndices.putIfAbsent(subjectId, () => ValueNotifier(0));
  }

  void initializeQuestions(List<Question> questions, int durationInMinutes) {
    if (questions.isEmpty) {
      questionsState.value = ViewModelState.error(error: 'No questions available', type: QuestionStates.dataLoadingError);
      return;
    }

    testStartTime = DateTime.now();

    if (_debugMode) {
      remainingSeconds.value = _debugTimerSeconds;
      debugPrint('⚠️ DEBUG MODE ACTIVE ⚠️');
      debugPrint('Timer set to $_debugTimerSeconds seconds for testing');
      debugPrint('Set _debugMode = false for production');
    } else {
      remainingSeconds.value = durationInMinutes * 60;
      debugPrint('Timer set to $durationInMinutes minutes (${durationInMinutes * 60} seconds)');
    }

    _startCountdown();

    questionsState.value = ViewModelState.success(data: questions, type: QuestionStates.dataLoadedSuccess);
  }

  void _startCountdown() {
    _countdownTimer?.cancel();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds.value > 0) {
        remainingSeconds.value--;

        if (_debugMode && remainingSeconds.value <= 10) {
          debugPrint('⏱️ Timer: ${remainingSeconds.value} seconds remaining');
        }
      } else {
        timer.cancel();
        debugPrint('⏰ Timer ended - triggering auto-submit');

        if (onTimerEnd != null) {
          onTimerEnd!();
        }
      }
    });
  }

  String getFormattedTime() {
    final hours = remainingSeconds.value ~/ 3600;
    final minutes = (remainingSeconds.value % 3600) ~/ 60;
    final seconds = remainingSeconds.value % 60;

    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:'
          '${minutes.toString().padLeft(2, '0')}:'
          '${seconds.toString().padLeft(2, '0')}';
    }
    return '${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}';
  }

  bool get isTimerCritical {
    if (_debugMode && _debugTimerSeconds <= 30) {
      return remainingSeconds.value <= 5;
    }
    // In production, last 5 minutes (300 seconds) is critical
    return remainingSeconds.value <= 300;
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

  AttemptedQuestionsResponse prepareSubmissionData(String paperId, List<Question> allQuestions) {
    final List<AttemptedQuestion> attemptedQuestions = allQuestions.map((question) {
      if (question.answer != null && question.answer!.isNotEmpty) {
        return AttemptedQuestion(
          questionId: question.id,
          correctAnswer: question.answer,
          attemptedAnswer: numericalAnswers.value[question.id],
          correctOptionIndexes: null,
          attemptedOptionIndexes: null,
        );
      } else {
        return AttemptedQuestion(
          questionId: question.id,
          correctAnswer: null,
          attemptedAnswer: null,
          correctOptionIndexes: question.correctOptionIndexes,
          attemptedOptionIndexes: selectedAnswers.value[question.id],
        );
      }
    }).toList();

    return AttemptedQuestionsResponse(paperId: paperId, questions: attemptedQuestions);
  }

  PaperSubmission prepareApiSubmissionData(String paperId, List<Question> allQuestions) {
    final responses = allQuestions
        .map((question) {
          if (question.answer != null && question.answer!.isNotEmpty) {
            final attemptedAnswer = numericalAnswers.value[question.id];
            if (attemptedAnswer != null && attemptedAnswer.isNotEmpty) {
              return QuestionResponse(questionId: question.id, attemptedAnswer: attemptedAnswer);
            }
          } else {
            final attemptedOptions = selectedAnswers.value[question.id];
            if (attemptedOptions != null && attemptedOptions.isNotEmpty) {
              return QuestionResponse(questionId: question.id, attemptedOptionIndexes: attemptedOptions);
            }
          }
          return null;
        })
        .whereType<QuestionResponse>()
        .toList();

    return PaperSubmission(
      paperId: paperId,
      startedAt: testStartTime ?? DateTime.now(),
      completedAt: DateTime.now(),
      responses: responses,
    );
  }

  AttemptedQuestionsResponse prepareLocalResultData(String paperId, List<Question> allQuestions) {
    final attemptedQuestions = allQuestions.map((question) {
      if (question.answer != null && question.answer!.isNotEmpty) {
        return AttemptedQuestion(
          questionId: question.id,
          correctAnswer: question.answer,
          attemptedAnswer: numericalAnswers.value[question.id],
          correctOptionIndexes: null,
          attemptedOptionIndexes: null,
        );
      } else {
        return AttemptedQuestion(
          questionId: question.id,
          correctAnswer: null,
          attemptedAnswer: null,
          correctOptionIndexes: question.correctOptionIndexes,
          attemptedOptionIndexes: selectedAnswers.value[question.id],
        );
      }
    }).toList();

    return AttemptedQuestionsResponse(paperId: paperId, questions: attemptedQuestions);
  }

  Future<void> submitPaper(String paperId, List<Question> allQuestions) async {
    try {
      questionsState.value = ViewModelState.loading(mode: QuestionStates.submissionLoading);
      final data = prepareApiSubmissionData(paperId, allQuestions);

      if (_debugMode) {
        log('📤 DEBUG: API Submission Data: ${jsonEncode(data.toJson())}');
      }

      await _papersRepository.submitPaper(data: data.toJson());
      questionsState.value = ViewModelState.success(data: 'Submitted', type: QuestionStates.submissionSuccess);

      debugPrint('✅ Paper submitted successfully');
    } catch (e) {
      debugPrint('❌ Error submitting paper: $e');
      questionsState.value = ViewModelState.error(
        error: 'Failed to submit paper: ${e.toString()}',
        type: QuestionStates.submissionError,
      );
      rethrow;
    }
  }

  void dispose() {
    _countdownTimer?.cancel();
    questionsState.dispose();
    currentQuestionIndex.dispose();
    selectedAnswers.dispose();
    numericalAnswers.dispose();
    markedForLater.dispose();
    remainingSeconds.dispose();

    for (var controller in _subjectPageControllers.values) {
      controller.dispose();
    }
    for (var notifier in _subjectQuestionIndices.values) {
      notifier.dispose();
    }
    _subjectPageControllers.clear();
    _subjectQuestionIndices.clear();

    debugPrint('QuestionsViewModel disposed');
  }
}
