import 'package:flutter/material.dart';
import 'package:root/src/core/common/state/viewmodel_state.dart';
import 'package:root/src/core/logger/logger.dart';
import 'package:root/src/models/question_model/question_model.dart';
import 'package:root/src/repositories/questions_repository.dart';

class ReadPaperViewmodel {
  final QuestionsRepository _questionsRepository = QuestionsRepository();
  final ValueNotifier<ViewModelState> readPaperViewState = ValueNotifier(ViewModelState.idle());

  final ValueNotifier<List<Question>> questionsData = ValueNotifier([]);
  final ValueNotifier<List<SubjectInQuestion>> subjects = ValueNotifier([]);

  Future<void> fetchANDFilterData(String paperID) async {
    readPaperViewState.value = ViewModelState.loading();
    try {
      AppLogs.info('Fetching questions for paperID: $paperID');
      questionsData.value = await fetchQuestions(paperID);
      subjects.value = extractUniqueSubjects(questionsData.value);

      readPaperViewState.value = ViewModelState.success();
    } catch (e) {
      AppLogs.warning('Error fetching questions: $e');
      questionsData.value = [];
      subjects.value = [];
      AppLogs.error(e.toString());
      readPaperViewState.value = ViewModelState.error(error: e.toString());
      rethrow;
    }
  }

  Future<List<Question>> fetchQuestions(String paperID) async {
    final query = 'page=1&pageSize=500&paper_id=$paperID';
    final fetchedQuestions = await _questionsRepository.getQuestions(query: query);
    questionsData.value = fetchedQuestions;
    AppLogs.info('Questions fetched: ${fetchedQuestions.length}');
    return fetchedQuestions;
  }

  List<SubjectInQuestion> extractUniqueSubjects(List<Question> questions, {int? limit}) {
    final List<SubjectInQuestion> uniqueSubjects = [];
    final Set<String> processedSubjectIds = {};

    for (final question in questions) {
      final subject = question.topic.subject;

      if (!processedSubjectIds.contains(subject.id)) {
        uniqueSubjects.add(subject);
        processedSubjectIds.add(subject.id);

        AppLogs.info('✅ Found unique subject: ${subject.name}');

        if (limit != null && uniqueSubjects.length >= limit) {
          break;
        }
      }
    }

    return uniqueSubjects;
  }
}
