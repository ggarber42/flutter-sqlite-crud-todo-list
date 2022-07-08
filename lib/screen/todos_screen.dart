import 'package:flutter/material.dart';
import 'package:sqlite_crud/dao/todo_dao.dart';
import 'package:sqlite_crud/widgets/todo_tile.dart';

import '../services/db_connector.dart';
import '../models/todo_item.dart';

class TodosScreen extends StatefulWidget {
  final String title;
  TodosScreen({Key? key, required this.title}) : super(key: key);
  @override
  _TodosScreenState createState() => _TodosScreenState();
}

class _TodosScreenState extends State<TodosScreen> {
  TodoDAO todoDao = new TodoDAO();
  late List<TodoItem> todos;
  final _nameController = TextEditingController();
  var isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchTodos();
  }

  void _submitData() {
    Navigator.of(context).pop();
    final newTodo = TodoItem(name: _nameController.text);
    todoDao.create(newTodo);
    setState(() {
      fetchTodos();
    });
  }

  Future<List<TodoItem>> fetchTodos() async {
    setState(() => isLoading = true);
    var todos = await todoDao.readAll();
    todos.forEach((todo) => print(todo.toString()));
    return todos;
  }

  Future<void> _openAddModal(BuildContext ctx) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('New Todo'),
            content: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(5),
                child: Column(children: [
                  TextField(
                    decoration: InputDecoration(labelText: 'Name'),
                    controller: _nameController,
                    onSubmitted: (_) => _submitData(),
                  ),
                ]),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(widget.title)),
      ),
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.all(10),
        child: FutureBuilder(
          future: fetchTodos(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<TodoItem> todos = snapshot.data as List<TodoItem>;
              return ListView.builder(
                itemCount: todos.length,
                itemBuilder: (ctx, index) => TodoTile(todos[index]),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _openAddModal(context),
      ),
    );
  }
}
