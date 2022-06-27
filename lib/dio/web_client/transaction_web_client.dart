import 'dart:convert';

import 'package:bytebank/dio/web_client.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:dio/dio.dart';

class TransactionWebClient {
  Future<List<Transaction>> findAll() async {
    final response = await dio.get(baseUrl);

    final List<dynamic> data = response.data;

    final List<Transaction> transactions = List.empty(
      growable: true,
    );

    for (Map<String, dynamic> row in data) {
      transactions.add(
        Transaction.fromJson(row),
      );
    }

    return transactions;
  }

  final Map<int, String> statusCodeResponses = {
    400: 'There was an error submitting transaction',
    401: 'authentication failed',
    409: 'transaction always exists'
  };

  Future<Transaction?> save(Transaction transaction, String code) async {
    final transactionJson = jsonEncode(transaction.toJson());

    final response = await dio.post(
      baseUrl,
      options: Options(
        headers: {
          'Contenxt-type': 'application/json',
          'password': code,
        },
      ),
      data: transactionJson,
    );

    print(Transaction.fromJson(response.data));

    return response.data != null ? Transaction.fromJson(response.data) : null;
  }
}
