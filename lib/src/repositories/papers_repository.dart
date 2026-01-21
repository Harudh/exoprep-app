import 'package:root/src/models/paper_model/attempted_paper_model.dart';
import 'package:root/src/models/paper_model/paper_details_model.dart';
import 'package:root/src/core/exceptions/network_exception.dart';
import 'package:root/src/models/paper_model/paper_model.dart';
import 'package:root/src/services/papers_services.dart';
import 'package:dio/dio.dart';
import 'dart:developer';

class PapersRepository {
  final PapersService _papersService;

  PapersRepository({PapersService? papersService}) : _papersService = papersService ?? PapersService();

  Future<List<Paper>> getPapers({required String query}) async {
    try {
      final response = await _papersService.getPapers(query: query);
      log('Response: $response');
      final papersJson = (response.data?['papers'] as List<dynamic>?) ?? [];
      return papersJson.map((json) => Paper.fromJson(json as Map<String, dynamic>)).toList();
    } on DioException catch (e) {
      throw NetworkException.fromDioError(e);
    }
  }

  Future<List<AttemptedPaper>> recentlyAttemptedPapers({required String query}) async {
    try {
      final response = await _papersService.recentlyAttemptedPapers(query: query);
      log('Response: $response');
      final papersJson = (response.data?['attempts'] as List<dynamic>?) ?? [];
      return papersJson.map((json) => AttemptedPaper.fromJson(json as Map<String, dynamic>)).toList();
    } on DioException catch (e) {
      throw NetworkException.fromDioError(e);
    }
  }

  Future<PaperDetail> getPaperDetails({required String paperID}) async {
    try {
      final response = await _papersService.getPaperDetails(paperID: paperID);
      final paperJson = response.data?['paper'];
      return PaperDetail.fromJson(paperJson);
    } on DioException catch (e) {
      throw NetworkException.fromDioError(e);
    }
  }

  Future<void> submitPaper({required Map<String, dynamic> data}) async {
    try {
      final response = await _papersService.submitPaper(data: data);
      log('Paper Submit Response: $response');
    } on DioException catch (e) {
      throw NetworkException.fromDioError(e);
    }
  }
}
