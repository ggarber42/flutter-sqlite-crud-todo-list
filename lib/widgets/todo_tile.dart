import 'package:flutter/material.dart';
import 'package:sqlite_crud/dao/todo_dao.dart';
import 'package:sqlite_crud/widgets/delete_dialog.dart';
import 'package:sqlite_crud/widgets/edit_dialog.dart';

import '../models/todo_item.dart';

class TodoTile extends StatefulWidget {
  final TodoItem todo;
  final Function fetchTodos;

  TodoTile(this.todo, this.fetchTodos);

  @override
  _TodoTileState createState() => _TodoTileState();
}

class _TodoTileState extends State<TodoTile> {
  void updateTodoItem() {
    setState(() {
      TodoDAO().update(widget.todo);
    });
  }

  int _toggleDoneValue(int value) {
    return 1 - value;
  }

  Future<void> _openDeleteModal(BuildContext ctx) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: true, // user must tap button!
        builder: (BuildContext context) {
          return DeleteDialog(widget.todo.getId, widget.fetchTodos);
        });
  }

  Future<void> _openEditModal(BuildContext ctx){
    return showDialog(context: context,barrierDismissible: true, builder: (BuildContext context){
      return EditDialog(widget.todo, updateTodoItem);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Container(
        child: Card(
          child: Column(
            children: [
              ListTile(
                  title: Text(widget.todo.name),
                  trailing: Checkbox(
                    checkColor: Colors.white,
                    fillColor:
                        MaterialStateProperty.resolveWith<Color>((states) {
                      if (states.contains(MaterialState.disabled)) {
                        return Colors.grey.withOpacity(.32);
                      }
                      return Colors.blue;
                    }),
                    value: widget.todo.done == 0 ? false : true,
                    onChanged: (value) {},
                  ),
                  onTap: () {
                    final newValue = _toggleDoneValue(widget.todo.getDone);
                    widget.todo.setDone = newValue;
                    updateTodoItem();
                  }),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      TextButton(
                        onPressed: () => _openEditModal(context),
                        child: Icon(Icons.edit),
                      ),
                      TextButton(
                        onPressed: () => _openDeleteModal(context),
                        child: Icon(Icons.delete),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
