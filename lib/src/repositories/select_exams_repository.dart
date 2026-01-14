import 'package:root/src/core/exceptions/network_exception.dart';
import 'package:root/src/models/exam_model/exam_model.dart';
import 'package:root/src/services/select_exams_service.dart';
import 'package:root/src/services/user_service.dart';
import 'package:dio/dio.dart';
import 'dart:developer';

class SelectExamsRepository {
  final SelectExamsService _selectExamsService;
  final UserService _userService;

  SelectExamsRepository({SelectExamsService? selectExamsService, UserService? userService})
    : _selectExamsService = selectExamsService ?? SelectExamsService(),
      _userService = userService ?? UserService();

  Future<List<Exam>> getExams() async {
    try {
      final response = await _selectExamsService.getExams();
      log('Response: $response');
      final examsJson = (response.data?['exams'] as List<dynamic>?) ?? [];
      return examsJson.map((json) => Exam.fromJson(json as Map<String, dynamic>)).toList();
    } on DioException catch (e) {
      throw NetworkException.fromDioError(e);
    }
  }

  Future<void> updateUserExams({required Map<String, dynamic> data}) async {
    try {
      final response = await _userService.updateUserExams(data: data);
      log('Response: $response');
    } on DioException catch (e) {
      throw NetworkException.fromDioError(e);
    }
  }
}
