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

  final ValueNotifier<ViewModelState<String>> dataState = ValueNotifier(ViewModelState.idle());

  final ValueNotifier<PaperDetail?> paperDetails = ValueNotifier(null);
  final ValueNotifier<List<Subject>> subjectsData = ValueNotifier([]);
  final ValueNotifier<List<Question>> questionsData = ValueNotifier([]);

  /// Fetch all data concurrently (paper details, subjects, and questions)
  Future<void> fetchAllData({required String examID, required String paperID}) async {
    dataState.value = ViewModelState.loading(mode: AttemptPaperStates.fetchingData.toString());

    try {
      AppLogs.info('Fetching all data concurrently for examID: $examID, paperID: $paperID');

      await Future.wait([_fetchPaperDetails(paperID), _fetchSubjects(examID), _fetchQuestions(paperID)], eagerError: false);

      /* if (questionsData.value.isEmpty) {
        throw Exception('No questions available for this paper');
      }*/

      dataState.value = ViewModelState.success(
        data: {'paperDetail': paperDetails.value, 'subjects': subjectsData.value, 'questions': questionsData.value},
        type: AttemptPaperStates.dataFetched.toString(),
      );

      AppLogs.info(
        'All data fetched successfully - '
        'Paper: ${paperDetails.value?.name ?? "N/A"}, '
        'Subjects: ${subjectsData.value.length}, '
        'Questions: ${questionsData.value.length}',
      );
    } catch (e) {
      AppLogs.warning('Error fetching all data: $e');
      dataState.value = ViewModelState.error(error: e.toString(), type: AttemptPaperStates.dataFetchError.toString());
      rethrow;
    }
  }

  /// Fetch paper details
  Future<PaperDetail?> _fetchPaperDetails(String paperID) async {
    try {
      AppLogs.info('Fetching paper details for paperID: $paperID');
      final paperDetail = await _papersRepository.getPaperDetails(paperID: paperID);
      paperDetails.value = paperDetail;
      AppLogs.info('Paper details fetched: ${paperDetail.name}');
      return paperDetail;
    } catch (e) {
      AppLogs.warning('Error fetching paper details: $e');
      paperDetails.value = null;
      // Don't rethrow - allow other requests to complete
      return null;
    }
  }

  /// Fetch subjects
  Future<List<Subject>> _fetchSubjects(String examID) async {
    try {
      AppLogs.info('Fetching subjects for examID: $examID');
      final query = 'page=1&pageSize=50&exam_id=$examID';
      final fetchedSubjects = await _subjectsRepository.getSubjects(query: query);
      subjectsData.value = fetchedSubjects;
      AppLogs.info('Subjects fetched: ${fetchedSubjects.length}');
      return fetchedSubjects;
    } catch (e) {
      AppLogs.warning('Error fetching subjects: $e');
      subjectsData.value = [];
      return [];
    }
  }

  /// Fetch questions
  Future<List<Question>> _fetchQuestions(String paperID) async {
    try {
      AppLogs.info('Fetching questions for paperID: $paperID');
      final query = 'page=1&pageSize=500&paper_id=$paperID';
      final fetchedQuestions = await _questionsRepository.getQuestions(query: query);
      questionsData.value = fetchedQuestions;
      AppLogs.info('Questions fetched: ${fetchedQuestions.length}');
      return fetchedQuestions;
    } catch (e) {
      AppLogs.warning('Error fetching questions: $e');
      questionsData.value = [];
      rethrow;
    }
  }

  Future<void> refreshData({required String examID, required String paperID}) async {
    await fetchAllData(examID: examID, paperID: paperID);
  }

  bool get hasData => questionsData.value.isNotEmpty && dataState.value.status == ViewModelStatus.success;

  bool get hasPaperDetails => paperDetails.value != null;

  void dispose() {
    dataState.dispose();
    paperDetails.dispose();
    subjectsData.dispose();
    questionsData.dispose();
  }
}
