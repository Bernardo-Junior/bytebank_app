import 'package:bytebank/dio/web_client.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionFeedController {
  final transactions = ValueNotifier<List<Transaction>>(
    List.empty(growable: true),
  );

  final loading = ValueNotifier<bool>(false);
  final networkError = ValueNotifier<bool>(false);

  void loadTransactions() async {
    loading.value = true;
    try {
      transactions.value = await findAll();
      networkError.value = false;
    } catch (error) {
      networkError.value = true;
    }
    loading.value = false;
  }
}
