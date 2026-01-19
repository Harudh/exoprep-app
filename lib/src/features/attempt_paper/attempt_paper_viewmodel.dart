import 'package:root/src/models/paper_model/paper_details_model.dart';
import 'package:root/src/models/question_model/question_model.dart';
import 'package:root/src/models/subject_model/subject_model.dart';
import 'package:root/src/repositories/questions_repository.dart';
import 'package:root/src/core/common/state/viewmodel_state.dart';
import 'package:root/src/repositories/subjects_repository.dart';
import 'package:root/src/repositories/papers_repository.dart';
import 'package:root/src/core/constants/enums.dart';
import 'package:root/src/core/logger/logger.dart';
import 'package:flutter/foundation.dart';

class AttemptPaperViewModel {
  final SubjectsRepository _subjectsRepository;
  final PapersRepository _papersRepository;
  final QuestionsRepository _questionsRepository;

  AttemptPaperViewModel({
    SubjectsRepository? subjectsRepository,
    PapersRepository? papersRepository,
    QuestionsRepository? questionsRepository,
  }) : _subjectsRepository = subjectsRepository ?? SubjectsRepository(),
       _papersRepository = papersRepository ?? PapersRepository(),
       _questionsRepository = questionsRepository ?? QuestionsRepository();

  // State notifiers
  final ValueNotifier<ViewModelState<String>> paperDetailsState = ValueNotifier(ViewModelState.idle());
  final ValueNotifier<ViewModelState<String>> paperDataState = ValueNotifier(ViewModelState.idle());

  // Data notifiers
  final ValueNotifier<PaperDetail?> paperDetails = ValueNotifier(null);
  final ValueNotifier<List<Subject>> subjectsData = ValueNotifier([]);
  final ValueNotifier<List<Question>> questionsData = ValueNotifier([]);

  /// Fetch paper details only
  Future<void> fetchPaperDetails(String paperID) async {
    paperDetailsState.value = ViewModelState.loading(mode: AttemptPaperStates.fetchingData.toString());

    try {
      AppLogs.info('Fetching paper details for paperID: $paperID');

      final paperDetail = await _papersRepository.getPaperDetails(paperID: paperID);
      paperDetails.value = paperDetail;

      paperDetailsState.value = ViewModelState.success(data: paperDetail, type: AttemptPaperStates.dataFetched.toString());

      AppLogs.info('Paper Details fetched successfully: ${paperDetail.name}');
    } catch (e) {
      AppLogs.warning('Error fetching paper details: $e');
      paperDetails.value = null;
      paperDetailsState.value = ViewModelState.error(error: e.toString(), type: AttemptPaperStates.dataFetchError.toString());
      rethrow;
    }
  }

  /// Fetch all paper data (subjects and questions) concurrently
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
    paperDetailsState.dispose();
    paperDataState.dispose();
    paperDetails.dispose();
    subjectsData.dispose();
    questionsData.dispose();
  }
}
