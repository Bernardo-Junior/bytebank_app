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

  Future<Transaction?> save(Transaction transaction) async {
    final transactionJson = jsonEncode(transaction.toJson());
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

    return response.data != null ? Transaction.fromJson(response.data) : null;
  }
}
