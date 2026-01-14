import 'package:flutter/foundation.dart';
import 'package:root/src/core/logger/logger.dart';
import 'package:root/src/core/constants/enums.dart';
import 'package:root/src/models/question_model/question_model.dart';
import 'package:root/src/models/subject_model/subject_model.dart';
import 'package:root/src/repositories/subjects_repository.dart';
import 'package:root/src/repositories/questions_repository.dart';
import 'package:root/src/core/common/state/viewmodel_state.dart';

class AttemptPaperViewModel {
  final SubjectsRepository _subjectsRepository;
  final QuestionsRepository _questionsRepository;

  AttemptPaperViewModel({SubjectsRepository? subjectsRepository, QuestionsRepository? questionsRepository})
    : _subjectsRepository = subjectsRepository ?? SubjectsRepository(),
      _questionsRepository = questionsRepository ?? QuestionsRepository();

  // Single state notifier for the entire data fetch
  final ValueNotifier<ViewModelState<String>> paperDataState = ValueNotifier(ViewModelState.idle());

  // Data notifiers
  final ValueNotifier<List<Subject>> subjectsData = ValueNotifier([]);
  final ValueNotifier<List<Question>> questionsData = ValueNotifier([]);

  /// Fetch all paper data concurrently
  Future<void> fetchPaperData({required String examID, required String paperID}) async {
    paperDataState.value = ViewModelState.loading(mode: AttemptPaperStates.fetchingData.toString());

    try {
      AppLogs.info('Fetching paper data for examID: $examID, paperID: $paperID');

      // Execute all API calls in parallel using Future.wait
      await Future.wait([_fetchSubjects(examID), _fetchQuestions(paperID)], eagerError: false);

      paperDataState.value = ViewModelState.success(
        data: {'subjects': subjectsData.value, 'questions': questionsData.value},
        type: AttemptPaperStates.dataFetched.toString(),
      );

      AppLogs.info('All paper data fetched successfully');
    } catch (e) {
      AppLogs.warning("Error fetching paper data: $e");
      paperDataState.value = ViewModelState.error(error: e.toString(), type: AttemptPaperStates.dataFetchError.toString());
    }
  }

  Future<void> _fetchSubjects(String examID) async {
    try {
      AppLogs.info('Fetching subjects for examID: $examID');
      final query = 'page=1&pageSize=10&exam_id=$examID';
      final fetchedSubjects = await _subjectsRepository.getSubjects(query: query);
      subjectsData.value = fetchedSubjects;
      AppLogs.info('Subjects fetched: ${fetchedSubjects.length}');
    } catch (e) {
      AppLogs.warning('Error fetching subjects: $e');
      subjectsData.value = [];
      rethrow;
    }
  }

  Future<void> _fetchQuestions(String paperID) async {
    try {
      AppLogs.info('Fetching questions for paperID: $paperID');
      final query = 'page=1&pageSize=500&paper_id=$paperID';
      final fetchedQuestions = await _questionsRepository.getQuestions(query: query);
      questionsData.value = fetchedQuestions;
      AppLogs.info('Questions fetched: ${fetchedQuestions.length}');
    } catch (e) {
      AppLogs.warning('Error fetching questions: $e');
      questionsData.value = [];
      rethrow;
    }
  }

  /// Refresh paper data
  Future<void> refreshPaperData({required String examID, required String paperID}) async {
    await fetchPaperData(examID: examID, paperID: paperID);
  }

  void dispose() {
    paperDataState.dispose();
    subjectsData.dispose();
    questionsData.dispose();
  }
}
