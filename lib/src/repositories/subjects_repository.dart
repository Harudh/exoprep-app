import 'package:root/src/models/subject_model/subject_model.dart';
import 'package:root/src/core/exceptions/network_exception.dart';
import 'package:root/src/services/subjects_service.dart';
import 'package:dio/dio.dart';
import 'dart:developer';

class SubjectsRepository {
  final SubjectsService _subjectsService;

  SubjectsRepository({SubjectsService? subjectsService}) : _subjectsService = subjectsService ?? SubjectsService();

  Future<List<Subject>> getSubjects({required String query}) async {
    try {
      final response = await _subjectsService.getSubjects(query: query);
      log('Response: $response');
      final subjectsJson = (response.data?['subjects'] as List<dynamic>?) ?? [];
      return subjectsJson.map((json) => Subject.fromJson(json as Map<String, dynamic>)).toList();
    } on DioException catch (e) {
      throw NetworkException.fromDioError(e);
    }
  }
}
