import 'package:flutter/material.dart';

void main() => runApp(BytebankApp());

class BytebankApp extends StatelessWidget {
  const BytebankApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: TransferList(),
      ),
    );
  }
}

class TransferForm extends StatelessWidget {
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
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
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
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Criando Transferência'),
      ),
      body: Column(
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return TransferForm();
              },
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class TransferList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transferências'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return TransferForm();
              },
            ),
          );
        },
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
          TransferItem(
            Transfer('12551-2', 100.00),
          ),
        ],
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
