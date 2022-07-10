import 'package:flutter/material.dart';
import 'package:sqlite_crud/dao/todo_dao.dart';

import '../models/todo_item.dart';

class TodoTile extends StatelessWidget {
  final TodoItem todo;
  final TodoDAO todoDAO = new TodoDAO();

  TodoTile(this.todo);

  void _updateTodoItem() async{
    todo.setDone = todo.getDone ==  0 ? 1 : 0;
    var res = await todoDAO.update(todo);
    print(res);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Card(
        child: ListTile(
          title: Text(todo.name),
          trailing: Checkbox(
            checkColor: Colors.white,
            fillColor: MaterialStateProperty.resolveWith<Color>((states) {
              if (states.contains(MaterialState.disabled)) {
                return Colors.grey.withOpacity(.32);
              }
              return Colors.blue;
            }),
            value: todo.done== 0 ? false : true,
            onChanged: (value) {},
          ),
          onTap: () => _updateTodoItem()
        ),
      ),
    );
  }
}
