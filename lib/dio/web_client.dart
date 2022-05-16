import 'dart:developer';

import 'package:dio/dio.dart';

void findAll() async {
  final dio = Dio();

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        LogInterceptor();
        return handler.next(options);
      },
    ),
  );

  dio.interceptors.add(LogInterceptor());

  final response = await dio.get('http://192.168.1.12:8080/transactions');

  inspect(response.data);
}
