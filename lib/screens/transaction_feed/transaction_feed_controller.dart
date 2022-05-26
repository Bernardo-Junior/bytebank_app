import 'package:bytebank/dio/web_client/transaction_web_client.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionFeedController {
  final transactions = ValueNotifier<List<Transaction>>(
    List.empty(growable: true),
  );

  final loading = ValueNotifier<bool>(false);
  final networkError = ValueNotifier<bool>(false);

  void loadTransactions() async {
    final TransactionWebClient _webClient = TransactionWebClient();
    loading.value = true;
    try {
      transactions.value = await _webClient.findAll();
      networkError.value = false;
    } catch (error) {
      networkError.value = true;
    }
    loading.value = false;
  }
}
