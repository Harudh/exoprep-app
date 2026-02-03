import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:root/src/services/exam_analytics_service.dart';
import 'package:root/src/core/exceptions/network_exception.dart';
import 'package:root/src/models/exam_analytics_model/exam_analytics_model.dart';

class ExamAnalyticsRepository {
  final ExamAnalyticsService _examAnalyticsService;

  ExamAnalyticsRepository({ExamAnalyticsService? examAnalyticsService})
    : _examAnalyticsService = examAnalyticsService ?? ExamAnalyticsService();

  Future<ExamAnalyticsModel> getExamAnalytics(String examId) async {
    try {
      final response = await _examAnalyticsService.getExamAnalytics(examId);
      log('Response: $response');
      final json = response.data;
      ExamAnalyticsModel analyticsModel = ExamAnalyticsModel.fromJson(json);
      return analyticsModel;
    } on DioException catch (e) {
      throw NetworkException.fromDioError(e);
    }
  }
}
