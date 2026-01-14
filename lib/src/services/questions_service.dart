import 'package:root/src/core/common/models/response_model.dart';
import 'package:root/src/core/constants/endpoints.dart';
import 'package:root/src/core/network/dio_client.dart';

class QuestionsService {
  final DioClient _dioClient = DioClient();

  Future<ResponseModel> getQuestions({required String query}) async {
    final response = await _dioClient.get(AppEndpoints.getQuestions(query));
    return ResponseModel.fromResponse(response);
  }
}
