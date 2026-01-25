import 'package:root/src/core/common/models/response_model.dart';
import 'package:root/src/core/constants/endpoints.dart';
import 'package:root/src/core/network/dio_client.dart';

class UserService {
  final DioClient _dioClient = DioClient();

  Future<ResponseModel> createUser({required Map<String, dynamic> data}) async {
    final response = await _dioClient.post(AppEndpoints.user, data: data);
    return ResponseModel.fromResponse(response);
  }

  Future<ResponseModel> updateUserExams({required Map<String, dynamic> data}) async {
    final response = await _dioClient.put(AppEndpoints.user, data: data);
    return ResponseModel.fromResponse(response);
  }

  Future<ResponseModel> getCurrentUser() async {
    final response = await _dioClient.get(AppEndpoints.getUser);
    return ResponseModel.fromResponse(response);
  }
}
