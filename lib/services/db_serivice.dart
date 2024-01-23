import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../constants/create_dotos_table.dart';

class DBService {
  Database? _database;

  Future<Database>? get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await initialize();
    return _database!;
  }

  Future<Database> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();

    final database = openDatabase(
      join(await getDatabasesPath(), 'todolist.db'),
      onCreate: (db, version) async {
        return db.execute(Constants.CREATE_TODOS_TABLE);
      },
      version: 1,
    );

    return database;
  }
}
