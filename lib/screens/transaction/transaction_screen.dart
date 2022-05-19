import 'package:bytebank/models/contact.dart';
import 'package:bytebank/screens/transaction/transaction_controller.dart';
import 'package:bytebank/screens/transaction/transaction_online_form.dart';
import 'package:bytebank/screens/transaction/widgets/form.dart';
import 'package:bytebank/screens/transaction/widgets/item.dart';
import 'package:flutter/material.dart';

class TransactionScreen extends StatelessWidget {
  TransactionScreen({Key? key}) : super(key: key);
  final TransactionController _transactionController = TransactionController();

  Widget message(String text, bool isLoading) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (isLoading)
            Container(
              margin: EdgeInsets.only(bottom: 5),
              width: 30,
              height: 30,
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            ),
          Text(text),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _transactionController.loadingContacts();
    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction online'),
      ),
      body: AnimatedBuilder(
        animation: Listenable.merge(
          [
            _transactionController.contacts,
            _transactionController.loading,
          ],
        ),
        builder: (_, __) {
          if (_transactionController.loading.value) {
            return message('Loading', true);
          }

          if (_transactionController.contacts.value.isEmpty) {
            return message('Nenhum contato adicionado', false);
          }

          return ListView.builder(
            itemCount: _transactionController.contacts.value.length,
            itemBuilder: (context, index) {
              final Contact contact =
                  _transactionController.contacts.value[index];
              return TransactionItem(
                contact: contact,
                transactionController: _transactionController,
                onClick: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => TransactionOnlineForm(
                        contact,
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return TransactionForm(
                  transactionController: _transactionController,
                );
              },
            ),
          );
        },
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}
