import 'package:bytebank/models/transaction.dart';
import 'package:bytebank/screens/transaction_feed/transaction_feed_controller.dart';
import 'package:flutter/material.dart';

class TransactionFeedScreen extends StatefulWidget {
  @override
  State<TransactionFeedScreen> createState() => _TransactionFeedScreenState();
}

class _TransactionFeedScreenState extends State<TransactionFeedScreen> {
  final TransactionFeedController transactionFeedController =
      TransactionFeedController();

  @override
  void initState() {
    super.initState();
    transactionFeedController.loadTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transactions Feed'),
      ),
      body: AnimatedBuilder(
        animation: Listenable.merge([
          transactionFeedController.transactions,
          transactionFeedController.loading,
          transactionFeedController.networkError,
        ]),
        builder: (_, __) {
          final transactions = transactionFeedController.transactions.value;
          final loading = transactionFeedController.loading.value;
          final networkError = transactionFeedController.networkError.value;
          return loading
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          bottom: 10,
                        ),
                        width: 30,
                        height: 30,
                        child: CircularProgressIndicator(),
                      ),
                      Text('Carregando..'),
                    ],
                  ),
                )
              : networkError
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Erro de conexão, por favor, tente novamente'),
                          Container(
                            margin: EdgeInsets.only(
                              top: 10,
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                transactionFeedController.loadTransactions();
                              },
                              child: Text(
                                'Tentar novamente',
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  : transactions.isEmpty && !loading
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                              child:
                                  Text('Nenhuma transação online disponível.'),
                            ),
                          ],
                        )
                      : ListView.builder(
                          itemCount: transactions.length,
                          itemBuilder: (context, index) {
                            final Transaction transaction = transactions[index];
                            return Card(
                              child: ListTile(
                                leading: Icon(Icons.monetization_on),
                                title: Text(
                                  transaction.value.toString(),
                                  style: TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  transaction.contact!.accountNumber.toString(),
                                  style: TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                            );
                          },
                        );
        },
      ),
    );
  }
}
