import 'package:dio/dio.dart';

String mapDioError(DioException e) {
  if (e.type == DioExceptionType.connectionTimeout) {
    return "Connection timeout";
  }
  if (e.response != null) {
    return e.response?.data['message'] ?? "Server error";
  }
  return "Network error";
}
