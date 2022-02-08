import 'package:bytebank/models/contact.dart';
import 'package:sqflite/sqflite.dart';

import '../app_database.dart';

class ContactDao {
  static const String tableSql = 'CREATE TABLE contacts('
      'id INTEGER PRIMARY KEY, '
      'name TEXT, '
      'account_number INTEGER)';

  Future<int> save(Contact contact) async {
    final Database db = await getDatabase();

    final contactMap = _toMap(contact);

    return db.insert('contacts', contactMap);
  }

  Map<String, dynamic> _toMap(Contact contact) {
    return {
      'name': contact.name,
      'account_number': contact.accountNumber,
    };
  }

  List<Contact> _toList({required List<Map<String, dynamic>> result}) {
    final List<Contact> contacts = List.empty(growable: true);
    for (Map<String, dynamic> row in result) {
      final Contact contact = Contact(
        id: row['id'],
        name: row['name'],
        accountNumber: row['account_number'],
      );

      contacts.add(contact);
    }

    return contacts;
  }

  Future<List<Contact>> findAll() async {
    final Database db = await getDatabase();

    final List<Map<String, dynamic>> result = await db.query('contacts');
    final contacts = _toList(result: result);
    return contacts;
  }
}
