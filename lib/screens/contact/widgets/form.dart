import 'package:bytebank/components/input.dart';
import 'package:bytebank/database/dao/contact.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/screens/contact/contact_controller.dart';
import 'package:flutter/material.dart';

class ContactForm extends StatefulWidget {
  final ContactController contactController;
  final Contact? contact;
  const ContactForm({Key? key, required this.contactController, this.contact})
      : super(key: key);

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerAccount = TextEditingController();
  final ContactDao _contactDao = ContactDao();

  @override
  Widget build(BuildContext context) {
    final isUpdate = widget.contact != null;
    if (isUpdate) {
      _controllerName.text = widget.contact!.name;
      _controllerAccount.text = widget.contact!.accountNumber.toString();
    }
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
                    if (isUpdate) {
                      final Contact newContact = Contact(
                        id: widget.contact!.id,
                        name: name,
                        accountNumber: accountNumber,
                      );
                      _contactDao.update(newContact).then((id) {
                        widget.contactController.loadingContacts();
                        Navigator.of(context).pop();
                      });
                    } else {
                      final Contact newContact =
                          Contact(name: name, accountNumber: accountNumber);
                      _contactDao.save(newContact).then((id) {
                        widget.contactController.loadingContacts();
                        Navigator.of(context).pop();
                      });
                    }
                  }
                },
                child: Text(isUpdate ? 'Update' : 'Create'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
