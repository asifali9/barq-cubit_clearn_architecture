import 'package:dio/dio.dart';

import 'network_error_handler.dart';

class DioClient {
  late Dio _dio;

  DioClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.barq.com/v1/',
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        responseType: ResponseType.json,
      ),
    );
    _dio.interceptors.add(LogInterceptor(responseBody: true));
  }

  // GET Request
  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get(url, queryParameters: queryParameters);
      return response;
    } catch (e) {
      NetworkErrorHandler.handleError(e);
    }
  }

  // POST Request (Used for your OTP/Login)
  Future<Response> post(String url, {dynamic data}) async {
    try {
      final response = await _dio.post(url, data: data);
      return response;
    } catch (e) {
      NetworkErrorHandler.handleError(e);
    }
  }
}
