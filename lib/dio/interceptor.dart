import 'package:dio/dio.dart';

class DioInterceptor {
  static Dio init() {
    final dio = Dio(
      BaseOptions(
        receiveTimeout: Duration(seconds: 5000),
        connectTimeout: Duration(seconds: 5000),
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          LogInterceptor();
          return handler.next(options);
        },
      ),
    );

    dio.interceptors.add(LogInterceptor());

    return dio;
  }
}
