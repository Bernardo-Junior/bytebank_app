import 'package:bytebank/database/dao/contact.dart';
import 'package:bytebank/models/contact.dart';
import 'package:flutter/material.dart';

class ContactController {
  final contacts = ValueNotifier<List<Contact>>(List.empty(growable: true));
  final loading = ValueNotifier<bool>(false);
  final ContactDao _contactDao = ContactDao();

  void loadingContacts() async {
    loading.value = true;
    contacts.value = await _contactDao.findAll();
    loading.value = false;
  }
}
