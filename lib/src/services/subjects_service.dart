import 'package:root/src/core/common/models/response_model.dart';
import 'package:root/src/core/constants/endpoints.dart';
import 'package:root/src/core/network/dio_client.dart';

class SubjectsService {
  final DioClient _dioClient = DioClient();

  Future<ResponseModel> getSubjects({required String query}) async {
    final response = await _dioClient.get(AppEndpoints.getSubjects(query));
    return ResponseModel.fromResponse(response);
  }
}
