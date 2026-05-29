import 'dart:convert';
import 'package:dio/dio.dart';

import '../../features/root/root_bloc.dart';
import '../constant.dart';
import '../utils/secure_storage_util.dart';
import '../utils/util_helper.dart';

class LoggingInterceptors extends Interceptor {
  final Dio dio;

  bool _isRefreshingToken = false;

  LoggingInterceptors({
    required this.dio,
  });

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers['Accept'] = 'application/json';

    // final token = await UserStorageWrapper().getField(Constant.APP_TOKEN);
    // if (token != null && token.isNotEmpty) {
    //   options.headers['Authorization'] = 'Bearer $token';
    // }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final statusCode = err.response?.statusCode ?? 0;

    // ===== HANDLE 401 =====
    if (statusCode == 401 &&
        err.requestOptions.extra['retry'] != true &&
        !_isRefreshingToken) {
      _isRefreshingToken = true;

      UtilsHelper.rootBloc.add(
        ShowSnackBarEvent("Session expired, silakan login ulang"),
      );

      try {
        _isRefreshingToken = false;

        // if (success) {
          // final newToken = await UserStorageWrapper().getField(Constant.APP_TOKEN);
          //
          // err.requestOptions.headers['Authorization'] = 'Bearer $newToken';
          // err.requestOptions.extra['retry'] = true;
          //
          // final response = await _retry(err.requestOptions);

        //   return handler.resolve(response);
        // } else {
        //   await clearUserSession();
        //   return handler.reject(err);
        // }
      } catch (e) {
        UtilsHelper.rootBloc.add(
          ShowSnackBarEvent("Terjadi kesalahan autentikasi"),
        );
        _isRefreshingToken = false;
        await clearUserSession();
        return handler.reject(err);
      }
    }
    else if (statusCode == 500) {
      UtilsHelper.rootBloc.add(
        ShowSnackBarEvent("Server error, coba lagi nanti"),
      );
    } else if (err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.unknown) {
      UtilsHelper.rootBloc.add(
        ShowSnackBarEvent("Tidak ada koneksi internet"),
      );
    }else{
      UtilsHelper.rootBloc.add(
          ShowSnackBarEvent(err.response?.statusMessage ??""),);
    }

    super.onError(err, handler);
  }

  Future<Response> _retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
      responseType: requestOptions.responseType,
      contentType: requestOptions.contentType,
      validateStatus: requestOptions.validateStatus,
    );

    return dio.request(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }

  Future<void> clearUserSession() async {
    await UserSecureStorage.deleteAllField();
  }
}
