import 'package:root/src/models/paper_model/recently_attempted_paper_model.dart';
import 'package:root/src/core/exceptions/network_exception.dart';
import 'package:root/src/services/papers_services.dart';
import 'package:dio/dio.dart';

class RecentlyAttemptedPapersRepository {
  final PapersService _papersService;

  RecentlyAttemptedPapersRepository({PapersService? papersService}) : _papersService = papersService ?? PapersService();

  Future<RecentlyAttemptedPaper> getRecentlyAttemptedPaper({required String attemptedPaperId}) async {
    try {
      final response = await _papersService.getRecentlyAttemptedPaper(attemptedPaperId: attemptedPaperId);
      final recentPaperJson = response.data?['attempt'];
      return RecentlyAttemptedPaper.fromJson(recentPaperJson);
    } on DioException catch (e) {
      throw NetworkException.fromDioError(e);
    }
  }
}
