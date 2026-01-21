import 'package:root/src/core/common/models/response_model.dart';
import 'package:root/src/core/constants/endpoints.dart';
import 'package:root/src/core/network/dio_client.dart';

class PapersService {
  final DioClient _dioClient = DioClient();

  Future<ResponseModel> getPapers({required String query}) async {
    final response = await _dioClient.get(AppEndpoints.getPapers(query));
    return ResponseModel.fromResponse(response);
  }

  Future<ResponseModel> recentlyAttemptedPapers({required String query}) async {
    final response = await _dioClient.get(AppEndpoints.recentAttempts(query));
    return ResponseModel.fromResponse(response);
  }

  Future<ResponseModel> getPaperDetails({required String paperID}) async {
    final response = await _dioClient.get(AppEndpoints.getPaperDetails(paperID));
    return ResponseModel.fromResponse(response);
  }

  Future<ResponseModel> submitPaper({required Map<String, dynamic> data}) async {
    final response = await _dioClient.post(AppEndpoints.submitPaper, data: data);
    return ResponseModel.fromResponse(response);
  }
}
