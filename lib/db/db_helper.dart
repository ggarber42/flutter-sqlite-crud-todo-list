import 'dart:ffi';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/todoItem.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('app_database.db');
    return _database!;
  }

   Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDataBase);
  }

  void _createDataBase(Database db, int version) async{
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final boolType = 'BOOLEAN NOT NULL';

    await db.execute('''

    CREATE TABLE TodoItem ( 
      _id $idType,
      name $textType,
      done $boolType
    )
    ''');
  }

  Future<TodoItem> createTodoItem(TodoItem todo) async{
    final db = await instance.database;
    await db.insert('TodoItem', todo.toJson());
    final result = await db.query('TodoItem');
    print('vai printar');
    result.forEach((todo) => print(todo));
    return todo;
  }

  void printTodos() async {
    final db = await instance.database;
    final result = await db.query('TodoItem');
    result.forEach((todo) => print(todo));
  }

}
