import 'package:bytebank/models/contact.dart';
import 'package:flutter/material.dart';

class ContactItem extends StatelessWidget {
  final Contact contact;

  const ContactItem({
    Key? key,
    required this.contact,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.contact_phone_sharp),
          ],
        ),
        title: Text(
          contact.name,
          style: TextStyle(fontSize: 18),
        ),
        subtitle: Text('${contact.accountNumber}'),
      ),
    );
  }
}
