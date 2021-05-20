import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:thoikhoabieu/database/note.dart';

class SqlLiteHelper {
  static final _databaseName = "Note.db";
  static final _databaseVersion = 1;

  static final table = 'note';

  static final columnId = 'id';
  static final columnTitle = 'title';
  static final columnContent = 'content';
  static final columnDateTime = 'date_time';

  SqlLiteHelper._privateConstructor();
  static final SqlLiteHelper instance = SqlLiteHelper._privateConstructor();

  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    print('Init database....');
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $columnTitle TEXT,
            $columnContent TEXT NOT NULL,
            $columnDateTime TEXT NOT NULL
          )
          ''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    print('start insert....');
    // Database db = await (instance.database as FutureOr<Database>);
    return await _database!.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> queryAllRows(int id) async {
    // Database db = await (instance.database as FutureOr<Database>);
    return await _database!.query(table,
        where: '$columnId = ?',
        whereArgs: [id],
        columns: [columnTitle, columnDateTime]);
  }

  Future<int?> queryRowCount() async {
    // Database db = await (instance.database as FutureOr<Database>);
    return Sqflite.firstIntValue(
        await _database!.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  Future<int> update(Note note) async {
    // Database db = await (instance.database as FutureOr<Database>);

    print('id update = ${note.id}');
    return await _database!.update(table, note.toJson(),
        where: '$columnId = ?', whereArgs: [note.id]);
  }

  Future<int> delete(int? id) async {
    // Database db = await (instance.database as FutureOr<Database>);
    return await _database!
        .delete(table, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> queryRecordByPage(
      int pageIndex, int pageSize) async {
    print(
        'start get data with pageIndex = $pageIndex , pageSize = $pageSize....');
    // Database db = await (instance.database as FutureOr<Database>);
    return await _database!.rawQuery(
        'select $columnId, $columnContent, $columnDateTime, $columnTitle from $table limit $pageSize offset $pageIndex');
  }
}
