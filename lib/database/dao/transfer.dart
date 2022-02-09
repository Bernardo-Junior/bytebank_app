import 'package:bytebank/database/app_database.dart';
import 'package:bytebank/models/transfer.dart';
import 'package:sqflite/sqlite_api.dart';

class TransferDao {
  static const String _id = 'id';
  static const String _tableName = 'transfers';
  static const String _name = 'name';
  static const String _accountNumber = 'account_number';
  static const String tableSql = 'CREATE TABLE $_tableName('
      '$_id INTEGER PRIMARY KEY AUTOINCREMENT, '
      '$_name TEXT, '
      '$_accountNumber INTEGER)';

  Future<int> save(Transfer transfer) async {
    final Database db = await getDatabase();

    final transferMap = _toMap(transfer);

    return db.insert('$_tableName', transferMap);
  }

  Map<String, dynamic> _toMap(Transfer transfer) {
    return {
      '$_name': transfer.value,
      '$_accountNumber': transfer.account,
    };
  }

  List<Transfer> _toList(List<Map<String, Object?>> result) {
    final List<Transfer> transfers = List.empty(growable: true);

    for (final Map<String, dynamic> row in result) {
      transfers.add(
        Transfer(
          account: row['$_accountNumber'].toString(),
          value: double.tryParse(row['$_name'])!,
        ),
      );
    }

    return transfers;
  }

  Future<List<Transfer>> findAll() async {
    final Database db = await getDatabase();

    final result = await db.query('$_tableName');

    final transfers = _toList(result);

    return transfers;
  }
}
