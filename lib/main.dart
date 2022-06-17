import 'package:flutter/material.dart';

import './screen/todos_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const _appTitle = 'SQLite CRUD';

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