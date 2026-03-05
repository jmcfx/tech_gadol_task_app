import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class DioClient {
  static final logger = Logger();

  static Dio createDio() {
    final dio = Dio(
      BaseOptions(
        contentType: 'application/json',
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    );

    dio.interceptors.add(
      LogInterceptor(requestBody: true, responseBody: true, error: true),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onError: (error, handler) {
          logger.e(
            ' API Error',
            error: error.message,
            stackTrace: error.stackTrace,
          );
          return handler.next(error);
        },
      ),
    );

    return dio;
  }
}
