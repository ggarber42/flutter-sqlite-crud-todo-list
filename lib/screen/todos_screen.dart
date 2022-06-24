import 'package:flutter/material.dart';
import 'package:sqlite_crud/widgets/todo_tile.dart';

import '../db/db_helper.dart';
import '../models/todoItem.dart';

class TodosScreen extends StatefulWidget {
  final String title;
  TodosScreen({Key? key, required this.title}) : super(key: key);
  @override
  _TodosScreenState createState() => _TodosScreenState();
}

class _TodosScreenState extends State<TodosScreen> {
  late List<TodoItem> todos;
  final _NameController = TextEditingController();
  var isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchTodos();
  }

  void _submitData() async {
    Navigator.of(context).pop();
    final newTodo = TodoItem(name: _NameController.text);
    await DatabaseHelper.instance.addTodoItem(newTodo);
  }

  Future<void> _openAddModal(BuildContext ctx) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('AlertDialog Title'),
            content: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(5),
                child: Column(children: [
                  TextField(
                    decoration: InputDecoration(labelText: 'Title'),
                    controller: _NameController,
                    onSubmitted: (_) => _submitData(),
                  ),
                ]),
              ),
            ),
          );
        });
  }

  Future<List<TodoItem>> fetchTodos() async {
    setState(() => isLoading = true);
    var todos = await DatabaseHelper.instance.getTodos();
    todos.forEach((todo) => print(todo.toString()));
    return todos;
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
