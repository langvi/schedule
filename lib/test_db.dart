import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final _databaseName = "ScheduleDatabase.db";
  static final _databaseVersion = 1;

  static final table = 'schedule';

  static final columnId = '_id';
  static final columnTask = 'task';
  static final columnNote = 'note';
  static final columnDateTime = 'date_time';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $columnTask TEXT NOT NULL,
            $columnNote TEXT,
            $columnDateTime TEXT NOT NULL
          )
          ''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> queryAllRows(int id) async {
    Database db = await instance.database;
    return await db.query(table,
        where: '$columnId = ?', whereArgs: [id], columns: [columnTask, columnDateTime]);
  }

  Future<int> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnId];
    return await db.update(table, row, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<void> renameColumn() async {
    Database db = await instance.database;

    print(db.path);

//     await db.execute('ALTER TABLE $table RENAME TO new_table');
//     await db.execute('''
//           CREATE TABLE $table (
//             id INTEGER PRIMARY KEY,
//             task TEXT NOT NULL,
//             note TEXT
//           )
//           ''');
//     await db.execute('''
//           INSERT INTO $table(id, task, note)
// SELECT _id, task, note
// FROM new_table
//           ''');
    // await db.execute('DROP TABLE new_table');

    // print('dsds');
  }
}
