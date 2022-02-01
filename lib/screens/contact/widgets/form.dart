import 'package:bytebank/components/input.dart';
import 'package:bytebank/models/contact.dart';
import 'package:flutter/material.dart';

class ContactForm extends StatefulWidget {
  const ContactForm({Key? key}) : super(key: key);

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerAccount = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Contact'),
      ),
      body: Column(
        children: [
          Input(
            controller: _controllerName,
            typeInput: TextInputType.name,
            label: 'Full name',
            hint: 'Name de Oliveira Name',
            enableBorder: false,
          ),
          Input(
            controller: _controllerAccount,
            typeInput: TextInputType.number,
            label: 'Account Number',
            hint: '000000',
            enableBorder: false,
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 30,
              left: 30,
              right: 30,
              bottom: 8,
            ),
            child: SizedBox(
              width: double.maxFinite,
              height: 40,
              child: ElevatedButton(
                onPressed: () {
                  final String name = _controllerName.text;
                  final int? accountNumber =
                      int.tryParse(_controllerAccount.text);

                  if (name.isNotEmpty && accountNumber != null) {
                    final Contact newContact = Contact(
                        id: 0, name: name, accountNumber: accountNumber);
                    Navigator.of(context).pop(newContact);
                  }
                },
                child: Text('Create'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
