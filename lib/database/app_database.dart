import 'package:bytebank/database/dao/contact.dart';
import 'package:bytebank/database/dao/transfer.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  final String dbPath = await getDatabasesPath();
  final String path = join(dbPath, 'bytebank.db');

  Future _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(
        ContactDao.tableSql,
      );
      db.execute(
        TransferDao.tableSql,
      );
    },
    version: 16,
    onDowngrade: onDatabaseDowngradeDelete,
    onConfigure: _onConfigure,
  );
}
