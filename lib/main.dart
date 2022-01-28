import 'package:flutter/material.dart';

void main() => runApp(BytebankApp());

class BytebankApp extends StatelessWidget {
  const BytebankApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          // Colors from buttons
          secondary: Colors.blueAccent.shade700,
          // Color from text
          onPrimary: Colors.white,
          // Colors from icons
          onSecondary: Colors.white,
          // Colors from containers
          primary: Colors.green.shade900,
        ),
      ),
      home: TransferList(),
    );
  }
}

class TransferForm extends StatefulWidget {
  final BuildContext keyTransferList;

  TransferForm({required this.keyTransferList});

  @override
  State<TransferForm> createState() => _TransferFormState();
}

class _TransferFormState extends State<TransferForm> {
  final TextEditingController _controllerAccount = TextEditingController();

  final TextEditingController _controllerValue = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void submitTransfer() {
      final String? accountNumber = _controllerAccount.text;
      final double? value = double.tryParse(_controllerValue.text);

      if (![accountNumber, value].contains(null)) {
        final createdTransfer = Transfer(accountNumber!, value!);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    '$createdTransfer',
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      ScaffoldMessenger.of(widget.keyTransferList)
                          .hideCurrentSnackBar();
                    },
                    child: Text(
                      'Fechar',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
            backgroundColor: Colors.blueAccent,
          ),
        );
        Navigator.pop(context, createdTransfer);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Criando Transferência'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Editor(
              controller: _controllerAccount,
              label: 'Número da conta',
              hint: '00000-0',
              icon: Icons.account_balance,
            ),
            Editor(
              controller: _controllerValue,
              label: 'Valor depositado',
              hint: 'R\$ 00.00',
              icon: Icons.monetization_on,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Container(
                width: 200,
                height: 40,
                child: ElevatedButton(
                  child: Text('Confirmar'),
                  onPressed: () => submitTransfer(),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}

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
    // TODO: implement initState
    super.initState();
    widget._transfers.add(Transfer('asdasd', 22));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _keyTransferList,
      appBar: AppBar(
        title: Text('Transferências'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final Future<Transfer?> transferCreated = Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return TransferForm(
                  keyTransferList: _keyTransferList.currentContext!,
                );
              },
            ),
          );
          transferCreated.then((transferReceived) {
            debugPrint('CHEGOU NO THEN');
            debugPrint('$transferReceived');
            if (transferReceived != null) {
              Future.delayed(Duration(seconds: 5), () {
                setState(() {
                  widget._transfers.add(transferReceived);
                });
              });
            }
          });
        },
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: widget._transfers.length,
        itemBuilder: (context, index) {
          final transfer = widget._transfers[index];
          return TransferItem(transfer);
        },
      ),
    );
  }
}

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

class Editor extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData? icon;

  const Editor({
    Key? key,
    required this.controller,
    required this.label,
    required this.hint,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 13, left: 30, right: 30, bottom: 8),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: icon != null ? Icon(icon) : null,
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        style: TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }
}

class Transfer {
  final double value;
  final String account;

  Transfer(this.account, this.value);

  @override
  String toString() => 'Transfer(value: $value, account: $account)';
}
