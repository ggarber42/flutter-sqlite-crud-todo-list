import 'package:flutter/material.dart';

import 'package:sqlite_crud/models/todo_item.dart';

class EditDialog extends StatefulWidget {
  final TodoItem todo;
  final Function updateTodo;

  EditDialog(this.todo, this.updateTodo);

  @override
  _EditDialogState createState() => _EditDialogState();
}

class _EditDialogState extends State<EditDialog> {
  var _nameController = TextEditingController();
  
  void _handleSubmit(){
    Navigator.of(context).pop();
    final newName = _nameController.text;
    _nameController.text = '';
    widget.todo.setName = newName;
    widget.updateTodo();
  }

  @override
  Widget build(BuildContext context) {
    _nameController.text = widget.todo.getName;
    return AlertDialog(
      title: const Text('Edit Todo'),
      content: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(5),
          child: Column(children: [
            TextField(
              decoration: InputDecoration(labelText: 'Name'),
              controller: _nameController,
              onSubmitted: (_) => _handleSubmit(),
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
          onPressed: () => _handleSubmit(),
          child: const Text('Edit'),
        ),
      ],
    );
  }
}
