import 'package:booking/core/core.dart';
import 'package:dio/dio.dart';

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
          final regName = RegExp('[^A-Za-z0-9 ]');
          Map<String, dynamic> headers = {};
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

  /// Post method
  Future<dynamic> post({
    required String url,
    Map<String, dynamic>? data,
    Options? options,
    bool external = false,
  }) async {
    try {
      final response = await _dio.post(
        url,
        data: data,
        options: options,
      );
      return response.data;
    } on DioException catch (error) {
      return errorHandle(error);
    }
  }

  ///Get method
  Future<dynamic> get({
    required String url,
    Map<String, dynamic>? params,
    Options? options,
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
    Map<String, dynamic> data = {};

    switch (error.type) {
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        message = "request_time_out";
        break;

      default:
        message = "cannot_connect_server";
        break;
    }

    return {
      "status": 0,
      "message": message,
      "data": data,
    };
  }
}
