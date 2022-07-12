import '../models/todo_item.dart';
import '../interfaces/dao.dart';
import '../services/db_connector.dart';

class TodoDAO implements DAO<TodoItem> {
  TodoDAO() {
    _createTable();
  }

  void _createTable() async {
    final db = await DataBaseConnector.instance.database;
    // await db.execute("DROP TABLE IF EXISTS TodoItem");
    await db.execute(TodoItem.createTableQuery);
  }

  @override
  Future<TodoItem> create(TodoItem todo) async {
    final db = await DataBaseConnector.instance.database;
    final id = await db.insert('TodoItem', todo.toJson());
    return todo.copy(id: id);
  }

  @override
  Future<List<TodoItem>> readAll() async {
    final db = await DataBaseConnector.instance.database;
    List<TodoItem> todos = [];
    List<Map> queryResult =
        await db.query(TodoItem.table, columns: ['id', 'name', 'done']);
    for (int i = 0; i < queryResult.length; i++) {
      todos.add(TodoItem.fromJson(queryResult[i]));
    }
    return todos;
  }

  @override
  Future<int> update(TodoItem todo) async{
    final db = await DataBaseConnector.instance.database;
    return await db.update(
      TodoItem.table,
      todo.toJson(),
      where: 'id = ?',
      whereArgs: [todo.getId],
    );
  }
}
