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
}
