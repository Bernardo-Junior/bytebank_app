import 'package:bytebank/database/app_database.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/screens/contact/widgets/form.dart';
import 'package:bytebank/screens/contact/widgets/item.dart';
import 'package:flutter/material.dart';

class ContactsScreen extends StatelessWidget {
  ContactsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
      ),
      body: FutureBuilder(
        future: findAll(),
        builder: (context, AsyncSnapshot<List<Contact>> snapshot) {
          List<Contact> contacts = List.empty(growable: true);
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data != null) {
            contacts = snapshot.data!;
          }

          return ListView.builder(
            itemCount: contacts.length,
            itemBuilder: (context, index) {
              final Contact contact = contacts[index];
              return ContactItem(contact: contact);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return ContactForm();
              },
            ),
          ).then((newContact) => debugPrint(newContact.toString()));
        },
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}
