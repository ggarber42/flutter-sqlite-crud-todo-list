import 'package:flutter/material.dart';

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

  void _submitData() async{
    Navigator.of(context).pop();
    final newTodo = TodoItem(name: _NameController.text);
    await DatabaseHelper.instance.createTodoItem(newTodo);

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

  void fetchTodos() async {
    setState(() => isLoading = true);
    DatabaseHelper.instance.printTodos();
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
        child: Column(children: [
          Text(
            'Todos',
            style: TextStyle(fontSize: 28),
            textAlign: TextAlign.center,
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _openAddModal(context),
      ),
    );
  }
}
