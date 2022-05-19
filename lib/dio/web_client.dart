import 'dart:convert';

import 'package:bytebank/models/contact.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:dio/dio.dart';

const String baseUrl = 'http://192.168.1.12:8080/transactions';

Dio initDio() {
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

  return dio;
}

Future<List<Transaction>> findAll() async {
  final dio = initDio();

  final response = await dio.get(baseUrl);

  final List<dynamic> data = response.data;

  final List<Transaction> transactions = List.empty(
    growable: true,
  );

  for (Map<String, dynamic> row in data) {
    transactions.add(
      Transaction(
        row['value'],
        Contact(
          accountNumber: row['contact']['accountNumber'],
          name: row['contact']['name'],
        ),
      ),
    );
  }

  return transactions;
}

Future<Transaction?> save(Transaction transaction) async {
  final dio = initDio();

  final Map<String, dynamic> transactionMap = {
    'value': transaction.value,
    'contact': {
      'name': transaction.contact.name,
      'accountNumber': transaction.contact.accountNumber,
    }
  };

  final transactionJson = jsonEncode(transactionMap);
  final response = await dio.post(
    baseUrl,
    options: Options(
      headers: {
        'Contenxt-type': 'application/json',
        'password': '1000',
      },
    ),
    data: transactionJson,
  );

  return response.data != null
      ? Transaction(
          response.data['value'],
          Contact(
            accountNumber: response.data['contact']['accountNumber'],
            name: response.data['contact']['name'],
          ),
        )
      : null;
}
