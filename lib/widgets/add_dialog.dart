import 'package:flutter/material.dart';
import 'package:sqlite_crud/dao/todo_dao.dart';
import 'package:sqlite_crud/models/todo_item.dart';

class AddDialog extends StatefulWidget {
  final Function fetchTodos;

  AddDialog(this.fetchTodos);

  @override
  _AddDialogState createState() => _AddDialogState();
}

class _AddDialogState extends State<AddDialog> {
  final _nameController = TextEditingController();

  void _submitData() {
    print('kkkk');
    Navigator.of(context).pop();
    final newTodo = TodoItem(name: _nameController.text);
    final todoDao = new TodoDAO();
    _nameController.text = '';
    todoDao.create(newTodo);
    setState(() {
      widget.fetchTodos();
    });
  }

  @override
  Widget build(BuildContext context) {
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
      actions: [
        TextButton(
          onPressed: () {
            _nameController.text = '';
            Navigator.pop(context, 'Cancel');
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => _submitData(),
          child: const Text('Add'),
        ),
      ],
    );
    ;
  }
}
