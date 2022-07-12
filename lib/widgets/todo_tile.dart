import 'package:flutter/material.dart';
import 'package:sqlite_crud/dao/todo_dao.dart';

import '../models/todo_item.dart';

class TodoTile extends StatefulWidget {
  final TodoItem todo;

  TodoTile(this.todo);

  @override
  _TodoTileState createState() => _TodoTileState();
}

class _TodoTileState extends State<TodoTile> {

  void _updateTodoItem() async {
    await TodoDAO().update(widget.todo);
  }

  int _toggleValue(int value){
    return 1 - value;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Card(
        child: ListTile(
            title: Text(widget.todo.name),
            trailing: Checkbox(
              checkColor: Colors.white,
              fillColor: MaterialStateProperty.resolveWith<Color>((states) {
                if (states.contains(MaterialState.disabled)) {
                  return Colors.grey.withOpacity(.32);
                }
                return Colors.blue;
              }),
              value: widget.todo.done == 0 ? false : true,
              onChanged: (value) {},
            ),
            onTap: () {
              final newValue = _toggleValue(widget.todo.getDone);
              setState(() {
                  widget.todo.setDone = newValue;
                _updateTodoItem();
              });
            }),
      ),
    );
  }
}
