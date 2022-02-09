import 'package:bytebank/database/dao/contact.dart';
import 'package:bytebank/database/dao/transfer.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  final String dbPath = await getDatabasesPath();
  final String path = join(dbPath, 'bytebank.db');

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
  );
}
