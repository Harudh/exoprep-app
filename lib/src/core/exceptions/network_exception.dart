import 'package:dio/dio.dart';
import 'package:root/src/core/common/models/response_model.dart';

/// A unified network exception class to handle Dio errors consistently.
class NetworkException implements Exception {
  late final String message;
  final int? statusCode;
  final dynamic data;

  NetworkException._(this.message, {this.statusCode, this.data});

  /// Factory constructor that maps DioException to a readable message.
  factory NetworkException.fromDioError(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.cancel:
        return NetworkException._("Request to the API server was cancelled.");

      case DioExceptionType.connectionTimeout:
        return NetworkException._("Connection timeout with the API server.");

      case DioExceptionType.sendTimeout:
        return NetworkException._("Send timeout in connection with the API server.");

      case DioExceptionType.receiveTimeout:
        return NetworkException._("Receive timeout in connection with the API server.");

      case DioExceptionType.badCertificate:
        return NetworkException._("The API server's SSL certificate is invalid or untrusted.");

      case DioExceptionType.connectionError:
        return NetworkException._("Connection failed. Please check your internet or the server might be unreachable.");

      case DioExceptionType.badResponse:
        // Handle HTTP response errors like 400, 401, 404, 500 etc.
        final response = ResponseModel.fromResponse(dioException.response!); //
        final statusCode = dioException.response?.statusCode;
        final serverMessage = response.message;
        final data = response.data;

        return NetworkException._(serverMessage.toString(), statusCode: statusCode, data: data);

      case DioExceptionType.unknown:
        return NetworkException._("Unexpected error occurred. Please check your internet connection.");
    }
  }

  @override
  String toString() => message;
}
