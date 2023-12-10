import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_todo_bloc/bloc/todo_provider.dart';
import 'package:simple_todo_bloc/data/todo_model.dart';
import 'package:simple_todo_bloc/bloc/todo_cubit.dart';


class TodoListPage extends StatelessWidget {
  const TodoListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
        centerTitle: true,
      ),
      body: BlocBuilder<TodoCubit, List<Todo>>(
        builder: (context, state) {
          return ListView.builder(
            itemCount: state.length,
            itemBuilder: (context, index) {
              final todo = state[index];
              return Dismissible(
                key: Key(todo.title),
                onDismissed: (direction) {
                  TodoProvider.of(context).remove(index);
                },
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  child: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
                child: ListTile(
                  title: Text(todo.title),
                  subtitle: Text(todo.description),
                  trailing: Checkbox(
                    value: todo.isCompleted,
                    onChanged: (value) {
                      TodoProvider.of(context).toggleTodoCompletion(index);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add_todo');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
