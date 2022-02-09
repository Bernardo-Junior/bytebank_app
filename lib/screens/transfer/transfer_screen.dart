import 'package:bytebank/database/dao/transfer.dart';
import 'package:bytebank/models/transfer.dart';
import 'package:bytebank/screens/transfer/widgets/item.dart';
import 'package:flutter/material.dart';

import 'widgets/form.dart';

const _titleAppBar = 'Transferências';

class TransferScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TransferScreenState();
  }
}

class TransferScreenState extends State<TransferScreen> {
  List<Transfer> _transfers = List.empty(growable: true);
  final GlobalKey _keyTransferList = GlobalKey();

  final TransferDao transferDao = TransferDao();

  @override
  void initState() {
    super.initState();
    initAsync();
  }

  void initAsync() async {
    final transfers = await transferDao.findAll();
    setState(() {
      _transfers = transfers;
    });
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
                () async {
                  final id = await transferDao.save(transferReceived);

                  if (id >= 0) {
                    initAsync();
                  }
                },
              );
            }
          });
        },
        child: Icon(Icons.add),
      ),
      body: _transfers.isNotEmpty
          ? ListView.builder(
              itemCount: _transfers.length,
              itemBuilder: (context, index) {
                final transfer = _transfers[index];

                return TransferItem(transfer);
              },
            )
          : Center(
              child: Text('Nenhuma transferência registrada'),
            ),
    );
  }
}
