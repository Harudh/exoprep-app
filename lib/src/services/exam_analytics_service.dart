import 'package:root/src/core/common/models/response_model.dart';
import 'package:root/src/core/constants/endpoints.dart';
import 'package:root/src/core/network/dio_client.dart';

class ExamAnalyticsService {
  final DioClient _dioClient = DioClient();

  Future<ResponseModel> getExamAnalytics(String examId) async {
    final response = await _dioClient.get(AppEndpoints.getExamAnalytics(examId));
    return ResponseModel.fromResponse(response);
  }
}
