import 'package:bytebank/models/contact.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:dio/dio.dart';

Future<List<Transaction>> findAll() async {
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
