import 'package:flutter/material.dart';
import '../models/todoItem.dart';

class TodoTile extends StatelessWidget {
  final TodoItem todo;

  TodoTile(this.todo);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: ListTile(
        title: Text(todo.name as String)
      ),
    );
  }
}