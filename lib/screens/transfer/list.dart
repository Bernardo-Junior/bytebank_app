import 'package:bytebank/models/transfer.dart';
import 'package:bytebank/screens/transfer/item.dart';
import 'package:flutter/material.dart';

import 'form.dart';

const _titleAppBar = 'Transferências';

class TransferList extends StatefulWidget {
  final List<Transfer> _transfers = List.empty(growable: true);

  @override
  State<StatefulWidget> createState() {
    return TransferListState();
  }
}

class TransferListState extends State<TransferList> {
  final GlobalKey _keyTransferList = GlobalKey();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _keyTransferList,
      appBar: AppBar(
        title: Text(_titleAppBar),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return TransferForm(
                  keyTransferList: _keyTransferList.currentContext!,
                );
              },
            ),
          ).then((transferReceived) {
            if (transferReceived != null) {
              Future.delayed(
                Duration(seconds: 1),
                () {
                  setState(() {
                    widget._transfers.add(transferReceived);
                  });
                },
              );
            }
          });
        },
        child: Icon(Icons.add),
      ),
      body: widget._transfers.isNotEmpty
          ? ListView.builder(
              itemCount: widget._transfers.length,
              itemBuilder: (context, index) {
                final transfer = widget._transfers[index];
                return TransferItem(transfer);
              },
            )
          : Center(
              child: Text('Nenhuma transferência registrada'),
            ),
    );
  }
}
