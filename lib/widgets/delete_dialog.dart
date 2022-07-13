import 'package:flutter/material.dart';

import 'package:sqlite_crud/dao/todo_dao.dart';

class DeleteDialog extends StatefulWidget {
  final int todoId;
  final Function fetchTodos;

  DeleteDialog(this.todoId, this.fetchTodos);

  @override
  _DeleteDialogState createState() => _DeleteDialogState();
}

class _DeleteDialogState extends State<DeleteDialog> {
  void _deleteTodoItem() async {
    Navigator.of(context).pop();
    await TodoDAO().delete(widget.todoId);
    setState(() {
      widget.fetchTodos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Are you sure to delete?',
        style: TextStyle(color: Colors.red),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context, 'No');
          },
          child: const Text(
            'No',
            style: TextStyle(color: Colors.red),
          ),
        ),
        TextButton(
          onPressed: () => _deleteTodoItem(),
          child: const Text(
            'Yes',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    );
  }
}
