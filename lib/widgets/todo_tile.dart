import 'package:flutter/material.dart';
import '../models/todoItem.dart';

class TodoTile extends StatelessWidget {
  final TodoItem todo;

  TodoTile(this.todo);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Card(
        child: ListTile(
          title: Text(todo.name as String),
          trailing: Checkbox(
            checkColor: Colors.blue,
            fillColor: MaterialStateProperty.resolveWith<Color>((states) {
              if (states.contains(MaterialState.disabled)) {
                return Colors.grey.withOpacity(.32);
              }
              return Colors.white38;
            }),
            value: todo.done as bool? true : false,
            onChanged: (value) {},
          ),
        ),
      ),
    );
  }
}
