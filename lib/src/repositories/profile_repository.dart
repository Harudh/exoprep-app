import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:root/src/services/user_service.dart';
import 'package:root/src/models/user_model/user_model.dart';
import 'package:root/src/core/exceptions/network_exception.dart';

class ProfileRepository {
  final UserService _userService;

  ProfileRepository({UserService? userService}) : _userService = userService ?? UserService();

  Future<UserModel> getUserProfileDeatils() async {
    try {
      final response = await _userService.getCurrentUser();
      log('User: $response');
      final userJson = (response.data?['user']);

      return UserModel.fromJson(userJson);
    } on DioException catch (e) {
      throw NetworkException.fromDioError(e);
    }
  }
}
