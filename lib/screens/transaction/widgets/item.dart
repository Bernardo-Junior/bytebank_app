import 'package:bytebank/database/dao/contact.dart';
import 'package:bytebank/models/contact.dart';
import 'package:flutter/material.dart';

import '../transaction_controller.dart';
import 'form.dart';

class TransactionItem extends StatelessWidget {
  final Contact contact;
  final TransactionController transactionController;
  final ContactDao contactDao = ContactDao();
  final Function? onClick;

  TransactionItem({
    Key? key,
    required this.transactionController,
    required this.contact,
    @required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () => onClick != null ? onClick!() : null,
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
                        return TransactionForm(
                          transactionController: transactionController,
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
                    transactionController.loadingContacts();
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
