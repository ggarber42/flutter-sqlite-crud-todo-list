import 'package:flutter/material.dart';

import './screen/todos_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const _appTitle = 'SQLite CRUD';
/*
 1 - arrumar todo_tile
 2 - update function
 3 - delete dialog e function
*/
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _appTitle,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: TodosScreen(title: _appTitle),
    );
  }
}