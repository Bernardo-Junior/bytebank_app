import 'package:bytebank/database/dao/contact.dart';
import 'package:bytebank/models/contact.dart';
import 'package:flutter/material.dart';

import '../contact_controller.dart';
import 'form.dart';

class ContactItem extends StatelessWidget {
  final Contact contact;
  final ContactController contactController;
  final ContactDao contactDao = ContactDao();

  ContactItem({
    Key? key,
    required this.contactController,
    required this.contact,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        minVerticalPadding: 10,
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.contact_phone_sharp,
              color: Colors.green,
            ),
          ],
        ),
        title: Text(
          contact.name,
          style: TextStyle(fontSize: 18),
        ),
        subtitle: Container(
          margin: EdgeInsets.only(top: 10),
          child: Text('${contact.accountNumber}'),
        ),
        trailing: Container(
          width: 100,
          height: 100,
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return ContactForm(
                          contactController: contactController,
                          contact: contact,
                        );
                      },
                    ),
                  );
                },
                icon: Icon(
                  Icons.edit,
                  color: Colors.green,
                ),
              ),
              IconButton(
                onPressed: () async {
                  final id = await contactDao.delete(contact.id!);

                  if (id >= 0) {
                    contactController.loadingContacts();
                  }
                },
                icon: Icon(
                  Icons.highlight_remove_rounded,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
