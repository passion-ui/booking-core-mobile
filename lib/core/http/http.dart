import 'package:booking/core/core.dart';
import 'package:booking/presentation/presentation.dart';
import 'package:dio/dio.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';

class HTTPClient {
  late Dio _dio;

  HTTPClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: '${Application.domain}/api',
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        responseType: ResponseType.json,
      ),
    );

    ///Interceptors
    _dio.interceptors.add(
      QueuedInterceptorsWrapper(
        onRequest: (options, handler) {
          Map<String, dynamic> headers = {};
          final auth = sl<AuthenticationBloc>().state;
          if (auth is AuthenticationSuccess) {
            headers['Authorization'] = 'Bearer ${auth.user.token}';
          }
          options.headers.addAll(headers);
          printRequest(options);
          return handler.next(options);
        },
        onError: (DioException error, handler) async {
          return handler.next(error);
        },
      ),
    );
  }

  set baseUrl(String domain) {
    _dio.options.baseUrl = '$domain/api';
  }

  /// Post method
  Future<dynamic> post({
    required String url,
    Map<String, dynamic>? data,
    Options? options,
    bool loading = false,
  }) async {
    try {
      if (loading) {
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.gradient);
        SVProgressHUD.show();
      }
      final response = await _dio.post(
        url,
        data: data,
        options: options,
      );
      return response.data;
    } on DioException catch (error) {
      return errorHandle(error);
    } finally {
      if (loading) {
        SVProgressHUD.dismiss();
      }
    }
  }

  ///Get method
  Future<dynamic> get({
    required String url,
    Map<String, dynamic>? params,
    Options? options,
    bool loading = false,
  }) async {
    try {
      final response = await _dio.get(
        url,
        queryParameters: params,
        options: options,
      );
      return response.data;
    } on DioException catch (error) {
      return errorHandle(error);
    }
  }

  ///Print request info
  void printRequest(RequestOptions options) {
    Logger.log("BEFORE REQUEST ====================================");
    Logger.log("${options.method} URL ${options.path}");
    Logger.log("HEADERS", options.headers);
    if (options.method == 'GET') {
      Logger.log("PARAMS", options.queryParameters);
    } else {
      Logger.log("DATA", options.data);
    }
    Logger.log("BEFORE REQUEST ====================================");
  }

  ///Error common handle
  Map<String, dynamic> errorHandle(DioException error) {
    String message = "unknown_error";

    switch (error.type) {
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        message = "request_time_out";
        break;

      default:
        message = "cannot_connect_server";
        break;
    }

    throw Exception(message);
  }
}
