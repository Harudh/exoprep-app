import 'package:root/src/models/question_model/question_model.dart';
import 'package:root/src/core/exceptions/network_exception.dart';
import 'package:root/src/services/questions_service.dart';
import 'package:dio/dio.dart';
import 'dart:developer';

class QuestionsRepository {
  final QuestionsService _questionsService;

  QuestionsRepository({QuestionsService? questionsService}) : _questionsService = questionsService ?? QuestionsService();

  Future<List<Question>> getQuestions({required String query}) async {
    try {
      final response = await _questionsService.getQuestions(query: query);
      log('Questions: $response');
      final papersJson = (response.data?['questions'] as List<dynamic>?) ?? [];
      return papersJson.map((json) => Question.fromJson(json as Map<String, dynamic>)).toList();
    } on DioException catch (e) {
      throw NetworkException.fromDioError(e);
    }
  }
}
