// ignore_for_file: body_might_complete_normally_catch_error

import 'package:bytebank/components/response_dialog.dart';
import 'package:bytebank/components/transaction_auth_dialog.dart';
import 'package:bytebank/dio/web_client/transaction_web_client.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class TransactionOnlineForm extends StatefulWidget {
  final Contact contact;

  TransactionOnlineForm(this.contact);

  @override
  _TransactionOnlineFormState createState() => _TransactionOnlineFormState();
}

class _TransactionOnlineFormState extends State<TransactionOnlineForm> {
  final TextEditingController _valueController = TextEditingController();
  final TransactionWebClient _webClient = TransactionWebClient();
  final String transactionId = Uuid().v4();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    print(transactionId);
    return Scaffold(
      appBar: AppBar(
        title: Text('New transaction'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.contact.name,
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  widget.contact.accountNumber.toString(),
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: TextField(
                  controller: _valueController,
                  style: TextStyle(fontSize: 24.0),
                  decoration: InputDecoration(labelText: 'Value'),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    child: !loading
                        ? Text('Transfer')
                        : Container(
                            width: 15,
                            height: 15,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ),
                    onPressed: !loading
                        ? () async {
                            final double? value =
                                double.tryParse(_valueController.text);
                            if (value != null) {
                              final transactionCreated = Transaction(
                                transactionId,
                                value,
                                widget.contact,
                              );
                              await showDialog(
                                context: context,
                                builder: (ctx) => TransactionAuthDialog(
                                  onConfirm: (code) async {
                                    await save(transactionCreated, code);
                                  },
                                ),
                              );
                            }
                          }
                        : null,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> save(
    Transaction transactionCreated,
    String code,
  ) async {
    setState(() {
      loading = true;
    });
    final Transaction? transaction =
        await _webClient.save(transactionCreated, code).catchError(
      (e) async {
        if (e.response != null &&
            _webClient.statusCodeResponses.containsKey(
              [e.response.statusCode],
            )) {
          await _showMessage(
              _webClient.statusCodeResponses[e.response.statusCode]!);
        } else {
          await _showMessage('Unknown error');
        }
      },
    ).whenComplete(() {
      setState(() {
        loading = false;
      });
    });

    if (transaction != null) {
      await showDialog(
        context: context,
        builder: (ctx) => SuccessDialog(
          'Sucessfull transaction',
        ),
      );

      Navigator.pop(context);
    }
  }

  Future<dynamic> _showMessage(String responseError) {
    return showDialog(
      context: context,
      builder: (ctx) => FailureDialog(
        responseError,
      ),
    );
  }
}
