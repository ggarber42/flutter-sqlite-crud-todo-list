import 'package:sqflite/sqflite.dart';

import '../models/todo_item.dart';
import '../interfaces/dao.dart';
import '../services/db_connector.dart';

class TodoDAO implements DAO<TodoItem> {
  TodoDAO() {
    _createTable();
  }

  void _createTable() async {
    final db = await DataBaseConnector.instance.database;
    await db.execute(TodoItem.createTableQuery);
  }

  @override
  void create(TodoItem todo) async {
    final db = await DataBaseConnector.instance.database;
    await db.insert('TodoItem', todo.toJson());
  }

  @override
  Future<List<TodoItem>> readAll() async {
    final db = await DataBaseConnector.instance.database;
    List<TodoItem> todos = [];
    List<Map> queryResult =
        await db.query(TodoItem.table, columns: ['_id', 'name', 'done']);
    for (int i = 0; i < queryResult.length; i++) {
      todos.add(TodoItem.fromJson(queryResult[i]));
    }
    return todos;
  }
}
