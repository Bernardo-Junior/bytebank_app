import 'package:bytebank/models/contact.dart';
import 'package:bytebank/screens/contact/contact_controller.dart';
import 'package:bytebank/screens/contact/widgets/form.dart';
import 'package:bytebank/screens/contact/widgets/item.dart';
import 'package:flutter/material.dart';

class ContactsScreen extends StatelessWidget {
  ContactsScreen({Key? key}) : super(key: key);
  final ContactController _contactController = ContactController();

  Widget message(String text, bool isLoading) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (isLoading)
            Container(
              margin: EdgeInsets.only(bottom: 5),
              width: 30,
              height: 30,
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            ),
          Text(text),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _contactController.loadingContacts();
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
      ),
      body: AnimatedBuilder(
        animation: Listenable.merge(
          [_contactController.contacts, _contactController.loading],
        ),
        builder: (_, __) {
          if (_contactController.loading.value) {
            return message('Loading', true);
          }

          if (_contactController.contacts.value.isEmpty) {
            return message('Nenhum contato adicionado', false);
          }

          return ListView.builder(
            itemCount: _contactController.contacts.value.length,
            itemBuilder: (context, index) {
              final Contact contact = _contactController.contacts.value[index];
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
                return ContactForm(
                  contactController: _contactController,
                );
              },
            ),
          );
        },
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}
