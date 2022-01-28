import 'package:bytebank/components/editor.dart';
import 'package:bytebank/models/transfer.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const _titleAppBar = 'Criando Transferência';
const _labelAccount = 'Número da conta';
const _hintAccount = '000000';
const _labelValue = 'Valor depositado';
const _hintValue = 'R\$ 00.00';
const _textButton = 'Confirmar';

class TransferForm extends StatefulWidget {
  final BuildContext keyTransferList;

  TransferForm({required this.keyTransferList});

  @override
  State<TransferForm> createState() => _TransferFormState();
}

class _TransferFormState extends State<TransferForm> {
  final TextEditingController _controllerAccount = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final CurrencyTextInputFormatter formatterValue =
        CurrencyTextInputFormatter(
      locale: 'pt',
      decimalDigits: 2,
      symbol: 'R\$ ',
    );

    void submitTransfer() {
      final String? accountNumber = _controllerAccount.text;
      final double? value =
          double.tryParse(formatterValue.getUnformattedValue().toString());

      if (![accountNumber, value].contains(null) && accountNumber!.isNotEmpty) {
        final createdTransfer = Transfer(accountNumber, value!);

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
        title: Text(_titleAppBar),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Editor(
              controller: _controllerAccount,
              label: _labelAccount,
              hint: _hintAccount,
              icon: Icons.account_balance,
              typeInput: TextInputType.number,
            ),
            Editor(
              label: _labelValue,
              hint: _hintValue,
              icon: Icons.monetization_on,
              formatter: <TextInputFormatter>[formatterValue],
              typeInput: TextInputType.number,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Container(
                width: 200,
                height: 40,
                child: ElevatedButton(
                  child: Text(_textButton),
                  onPressed: () => submitTransfer(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
