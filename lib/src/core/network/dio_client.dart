import 'dart:io';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:root/src/core/constants/endpoints.dart';

class DioClient {
  static DioClient? _instance;
  late Dio _dio;

  // Factory constructor for singleton instance
  factory DioClient() {
    _instance ??= DioClient._internal();
    return _instance!;
  }

  // Private internal constructor
  DioClient._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppEndpoints.baseURL,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
      ),
    );

    // Add interceptors
    _dio.interceptors.add(_authInterceptor());
    _dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true, responseHeader: false));
  }

  // Auth interceptor to add Firebase token
  Interceptor _authInterceptor() {
    return InterceptorsWrapper(
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) async {
        try {
          // Get current Firebase user
          final user = FirebaseAuth.instance.currentUser;

          if (user != null) {
            // Get Firebase ID token
            final token = await user.getIdToken();

            if (token != null) {
              options.headers['Authorization'] = 'Bearer $token';
            }
          }

          return handler.next(options);
        } catch (e) {
          return handler.next(options);
        }
      },
      onError: (DioException error, ErrorInterceptorHandler handler) async {
        // Handle 401 Unauthorized - refresh token if needed
        if (error.response?.statusCode == 401) {
          // Check if this is already a retry attempt to prevent infinite loops
          if (error.requestOptions.extra['retried'] == true) {
            return handler.next(error);
          }

          try {
            final user = FirebaseAuth.instance.currentUser;
            if (user != null) {
              // Force refresh the token
              final newToken = await user.getIdToken(true);

              if (newToken != null) {
                // Update the failed request's headers with new token
                error.requestOptions.headers['Authorization'] = 'Bearer $newToken';

                // Mark this request as retried to prevent infinite loops
                error.requestOptions.extra['retried'] = true;

                // Retry the request using dio.fetch() with the original RequestOptions
                final cloneReq = await _dio.fetch<Response<dynamic>>(error.requestOptions);

                return handler.resolve(cloneReq);
              }
            }
          } catch (e) {
            // If token refresh fails, proceed with error
            return handler.next(error);
          }
        }
        return handler.next(error);
      },
    );
  }

  // GET Request
  Future<Response<T>> get<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.get<T>(
        path,
        data: data,
        options: options,
        cancelToken: cancelToken,
        queryParameters: queryParameters,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioException {
      rethrow;
    }
  }

  // POST Request
  Future<Response<T>> post<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.post<T>(
        path,
        data: data,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        queryParameters: queryParameters,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioException {
      rethrow;
    }
  }

  // PUT Request
  Future<Response<T>> put<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.put<T>(
        path,
        data: data,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        queryParameters: queryParameters,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioException {
      rethrow;
    }
  }

  // PATCH Request
  Future<Response<T>> patch<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.patch<T>(
        path,
        data: data,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        queryParameters: queryParameters,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioException {
      rethrow;
    }
  }

  // DELETE Request
  Future<Response<T>> delete<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.delete<T>(
        path,
        data: data,
        options: options,
        cancelToken: cancelToken,
        queryParameters: queryParameters,
      );
      return response;
    } on DioException {
      rethrow;
    }
  }

  // HEAD Request
  Future<Response<T>> head<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.head<T>(
        path,
        data: data,
        options: options,
        cancelToken: cancelToken,
        queryParameters: queryParameters,
      );
      return response;
    } on DioException {
      rethrow;
    }
  }

  // POST Request with FormData (for file uploads)
  Future<Response<T>> postWithFiles<T>(
    String path, {
    required Map<String, dynamic> data,
    List<File>? files,
    String fileFieldName = 'files',
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
  }) async {
    try {
      final formData = FormData.fromMap(data);

      // Add files if provided
      if (files != null && files.isNotEmpty) {
        for (final file in files) {
          final fileName = file.path.split('/').last;
          formData.files.add(MapEntry(fileFieldName, await MultipartFile.fromFile(file.path, filename: fileName)));
        }
      }

      final response = await _dio.post<T>(
        path,
        data: formData,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        queryParameters: queryParameters,
      );
      return response;
    } on DioException {
      rethrow;
    }
  }

  // PUT Request with FormData
  Future<Response<T>> putWithFiles<T>(
    String path, {
    required Map<String, dynamic> data,
    List<File>? files,
    String fileFieldName = 'files',
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
  }) async {
    try {
      final formData = FormData.fromMap(data);

      if (files != null && files.isNotEmpty) {
        for (final file in files) {
          final fileName = file.path.split('/').last;
          formData.files.add(MapEntry(fileFieldName, await MultipartFile.fromFile(file.path, filename: fileName)));
        }
      }

      final response = await _dio.put<T>(
        path,
        data: formData,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        queryParameters: queryParameters,
      );
      return response;
    } on DioException {
      rethrow;
    }
  }

  // PATCH Request with FormData
  Future<Response<T>> patchWithFiles<T>(
    String path, {
    required Map<String, dynamic> data,
    List<File>? files,
    String fileFieldName = 'files',
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
  }) async {
    try {
      final formData = FormData.fromMap(data);

      if (files != null && files.isNotEmpty) {
        for (final file in files) {
          final fileName = file.path.split('/').last;
          formData.files.add(MapEntry(fileFieldName, await MultipartFile.fromFile(file.path, filename: fileName)));
        }
      }

      final response = await _dio.patch<T>(
        path,
        data: formData,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        queryParameters: queryParameters,
      );
      return response;
    } on DioException {
      rethrow;
    }
  }

  // Download file
  Future<Response<dynamic>> download(
    String urlPath,
    dynamic savePath, {
    ProgressCallback? onReceiveProgress,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    bool deleteOnError = true,
    String lengthHeader = Headers.contentLengthHeader,
    Object? data,
    Options? options,
  }) async {
    try {
      final response = await _dio.download(
        urlPath,
        savePath,
        data: data,
        options: options,
        cancelToken: cancelToken,
        lengthHeader: lengthHeader,
        deleteOnError: deleteOnError,
        queryParameters: queryParameters,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioException {
      rethrow;
    }
  }

  // Make HTTP request with options
  Future<Response<T>> request<T>(
    String url, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.request<T>(
        url,
        data: data,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        queryParameters: queryParameters,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioException {
      rethrow;
    }
  }

  // Fetch method - direct access to underlying dio.fetch
  Future<Response<T>> fetch<T>(RequestOptions requestOptions) async {
    try {
      final response = await _dio.fetch<T>(requestOptions);
      return response;
    } on DioException {
      rethrow;
    }
  }

  // Request without authorization header (public endpoints)
  Future<Response<T>> publicGet<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final publicOptions = options ?? Options();
      publicOptions.headers = publicOptions.headers ?? {};
      publicOptions.headers!.remove('Authorization');

      final response = await _dio.get<T>(
        path,
        data: data,
        options: publicOptions,
        cancelToken: cancelToken,
        queryParameters: queryParameters,
      );
      return response;
    } on DioException {
      rethrow;
    }
  }

  Future<Response<T>> publicPost<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final publicOptions = options ?? Options();
      publicOptions.headers = publicOptions.headers ?? {};
      publicOptions.headers!.remove('Authorization');

      final response = await _dio.post<T>(
        path,
        data: data,
        options: publicOptions,
        cancelToken: cancelToken,
        queryParameters: queryParameters,
      );
      return response;
    } on DioException {
      rethrow;
    }
  }

  // Close the Dio client
  void close({bool force = false}) {
    _dio.close(force: force);
  }

  // Get access to the underlying Dio instance if needed
  Dio get dio => _dio;
}
