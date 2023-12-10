import 'package:flutter/material.dart';

import 'package:simple_todo_bloc/modules/add_todo_page.dart';
import 'package:simple_todo_bloc/bloc/todo_provider.dart';

import 'package:simple_todo_bloc/modules/todo_list_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TodoProvider(
      child: MaterialApp(
        title: 'Todo App',
     
      theme: ThemeData(
    primarySwatch: Colors.teal,

    appBarTheme:const AppBarTheme(
        iconTheme: IconThemeData(color: Colors.grey),
        color: Colors.teal, 
),
  ),
      debugShowCheckedModeBanner: false,
    
        initialRoute: '/',
        routes: {
          '/': (context) => const TodoListPage(),
          '/add_todo': (context) => const AddTodoPage(),
        },
      ),
    );
  }
}
