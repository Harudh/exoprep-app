import 'package:root/src/core/common/models/response_model.dart';
import 'package:root/src/core/constants/endpoints.dart';
import 'package:root/src/core/network/dio_client.dart';

class HomeService {
  final DioClient _dioClient = DioClient();

  Future<ResponseModel> getUserExams() async {
    final response = await _dioClient.get(AppEndpoints.getUserExams);
    return ResponseModel.fromResponse(response);
  }

  Future<ResponseModel> getLeafExams() async {
    final response = await _dioClient.get(AppEndpoints.getLeafExams());
    return ResponseModel.fromResponse(response);
  }
}
