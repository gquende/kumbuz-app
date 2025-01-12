import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class KixikilaLocalDataSource {
  String _table = "kixikilas";
  Database database;

  KixikilaLocalDataSource({required this.database}) {}

  Future<void> createTables() async {
    await database.execute('''
              create  table $_table( 
              id integer primary key autoincrement, 
              uuid TEXT,
              username TEXT,
              name TEXT,
              surname TEXT,
              password TEXT,
              created_at TEXT,
              updated_at TEXT
              )
        ''');
  }
}
