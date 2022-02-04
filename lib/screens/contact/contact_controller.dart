import 'package:bytebank/database/app_database.dart';
import 'package:bytebank/models/contact.dart';
import 'package:flutter/material.dart';

class ContactController {
  final contacts = ValueNotifier<List<Contact>>(List.empty(growable: true));
  final loading = ValueNotifier<bool>(false);

  void loadingContacts() async {
    loading.value = true;
    contacts.value = await findAll();
    loading.value = false;
  }
}
