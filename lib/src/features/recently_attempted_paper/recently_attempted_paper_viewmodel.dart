import 'package:root/src/models/paper_model/recently_attempted_paper_model.dart';
import 'package:root/src/repositories/attempted_paper_repository.dart';
import 'package:root/src/core/common/state/viewmodel_state.dart';
import 'package:root/src/repositories/questions_repository.dart';
import 'package:root/src/core/constants/enums.dart';
import 'package:flutter/material.dart';
import '../../models/question_model/question_model.dart';

class RecentlyAttemptedPaperViewModel {
  final RecentlyAttemptedPapersRepository _recentlyAttemptedPapersRepository;
  final QuestionsRepository _questionsRepository;

  RecentlyAttemptedPaperViewModel({
    QuestionsRepository? questionsRepository,
    RecentlyAttemptedPapersRepository? recentlyAttemptedPapersRepository,
  })  : _recentlyAttemptedPapersRepository = recentlyAttemptedPapersRepository ?? RecentlyAttemptedPapersRepository(),
        _questionsRepository = questionsRepository ?? QuestionsRepository();

  final ValueNotifier<ViewModelState> paperState = ValueNotifier(ViewModelState.idle(data: AttemptedPaperStates.idle));

  // Public properties accessible from view
  List<Question> questions = [];
  RecentlyAttemptedPaper? paper;

  Future<void> fetchAllData({required String attemptedPaperId, required String paperId}) async {
    try {
      paperState.value = ViewModelState.loading(mode: AttemptedPaperStates.dataLoading);

      final results = await Future.wait([
        _fetchAttemptedPaper(attemptedPaperId),
        _fetchQuestions(paperId),
      ]);

      paper = results[0] as RecentlyAttemptedPaper;
      questions = results[1] as List<Question>;

      paperState.value = ViewModelState.success(data: paper, type: AttemptedPaperStates.dataLoadedSuccess);
    } catch (e) {
      paperState.value = ViewModelState.error(error: e.toString(), type: AttemptedPaperStates.dataLoadingError);
    }
  }

  Future<RecentlyAttemptedPaper> _fetchAttemptedPaper(String attemptedPaperId) async {
    return await _recentlyAttemptedPapersRepository.getRecentlyAttemptedPaper(attemptedPaperId: attemptedPaperId);
  }

  Future<List<Question>> _fetchQuestions(String paperId) async {
    final query = 'page=1&pageSize=500&paper_id=$paperId';
    return await _questionsRepository.getQuestions(query: query);
  }

  void dispose() {
    paperState.dispose();
  }
}
