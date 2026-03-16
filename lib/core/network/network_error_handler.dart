import 'package:dio/dio.dart';

import '../errors/app_errors.dart';

class NetworkErrorHandler {
  static Never handleError(dynamic e){
    if(e is DioException){
      if(e.type == DioExceptionType.connectionTimeout || e.type == DioExceptionType.receiveTimeout
      || e.type == DioExceptionType.unknown)
        {
          throw NetworkError(errorMessage: e.message??'Check Your network connection');
        }
      else
        {
          throw ServerError(errorMessage: e.response?.data['message']?? 'Server Error');
        }
    }
    throw NetworkError(errorMessage: e.message??'An Unexpected Error Occurred');    }
  }