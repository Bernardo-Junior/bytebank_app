import 'package:bytebank/models/contact.dart';
import 'package:sqflite/sqflite.dart';

import '../app_database.dart';

class ContactDao {
  static const String _id = 'id';
  static const String _tableName = 'contacts';
  static const String _name = 'name';
  static const String _accountNumber = 'account_number';
  static const String tableSql = 'CREATE TABLE $_tableName('
      '$_id INTEGER PRIMARY KEY, '
      '$_name TEXT, '
      '$_accountNumber INTEGER)';

  Future<int> save(Contact contact) async {
    final Database db = await getDatabase();

    final contactMap = _toMap(contact);

    return db.insert('$_tableName', contactMap);
  }

  Map<String, dynamic> _toMap(Contact contact) {
    return {
      '$_name': contact.name,
      '$_accountNumber': contact.accountNumber,
    };
  }

  List<Contact> _toList({required List<Map<String, dynamic>> result}) {
    final List<Contact> contacts = List.empty(growable: true);
    for (Map<String, dynamic> row in result) {
      final Contact contact = Contact(
        id: row['$_id'],
        name: row['$_name'],
        accountNumber: row['$_accountNumber'],
      );

      contacts.add(contact);
    }

    return contacts;
  }

  Future<List<Contact>> findAll() async {
    final Database db = await getDatabase();

    final List<Map<String, dynamic>> result = await db.query('$_tableName');
    final contacts = _toList(result: result);
    return contacts;
  }

  Future<int> update(Contact todo) async {
    final Database db = await getDatabase();
    return await db.update('$_tableName', _toMap(todo),
        where: '$_id = ?', whereArgs: [todo.id]);
  }

  Future<int> delete(int id) async {
    final Database db = await getDatabase();
    return await db.delete('$_tableName', where: '$_id = ?', whereArgs: [id]);
  }
}
