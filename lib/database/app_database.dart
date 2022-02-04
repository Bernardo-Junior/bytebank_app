import 'package:bytebank/models/contact.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  final String dbPath = await getDatabasesPath();
  final String path = join(dbPath, 'bytebank.db');

  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(
        'CREATE TABLE contacts('
        'id INTEGER PRIMARY KEY, '
        'name TEXT, '
        'account_number INTEGER)',
      );
    },
    version: 1,
    // onDowngrade: onDatabaseDowngradeDelete,
  );
  // return getDatabasesPath().then((dbPath) {
  //   final String path = join(dbPath, 'bytebank.db');
  //   return openDatabase(
  //     path,
  //     onCreate: (db, version) {
  //       db.execute(
  //         'CREATE TABLE contacts('
  //         'id INTEGER PRIMARY KEY, '
  //         'name TEXT, '
  //         'account_number INTEGER)',
  //       );
  //     },
  //     version: 1,
  //     onDowngrade: onDatabaseDowngradeDelete,
  //   );
  // });
}

Future<int> save(Contact contact) async {
  // return getDatabase().then((db) {
  //   Map<String, dynamic> contactMap = Map();

  //   contactMap = {
  //     'name': contact.name,
  //     'account_number': contact.accountNumber,
  //   };

  //   return db.insert('contacts', contactMap);
  // });

  final Database db = await getDatabase();

  Map<String, dynamic> contactMap = Map();

  contactMap = {
    'name': contact.name,
    'account_number': contact.accountNumber,
  };

  return db.insert('contacts', contactMap);
}

Future<List<Contact>> findAll() async {
  final Database db = await getDatabase();

  final List<Map<String, dynamic>> result = await db.query('contacts');

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

  // return getDatabase().then((db) {
  //   return db.query('contacts').then((maps) {
  //     final List<Contact> contacts = List.empty(growable: true);

  //     for (Map<String, dynamic> map in maps) {
  //       final Contact contact = Contact(
  //         id: map['id'],
  //         name: map['name'],
  //         accountNumber: map['account_number'],
  //       );

  //       contacts.add(contact);
  //     }

  //     return contacts;
  //   });
  // });
}
