import 'package:bytebank/models/transfer.dart';
import 'package:flutter/material.dart';

class TransferItem extends StatelessWidget {
  final Transfer _transfer;
  TransferItem(this._transfer);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.monetization_on),
          ],
        ),
        title: Text(_transfer.account),
        subtitle: Text('R\$ ${_transfer.value}'),
      ),
    );
  }
}
