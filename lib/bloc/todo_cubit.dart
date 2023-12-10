import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:simple_todo_bloc/data/todo_model.dart';


class TodoCubit extends Cubit<List<Todo>> {
  TodoCubit() : super([]);

  void add(Todo todo) {
    emit([...state, todo]);
  }

  void remove(int index) {
    final List<Todo> newState = List.from(state);
    newState.removeAt(index);
    emit(newState);
  }

  Future<void> addAndPersist(Todo todo) async {
    emit([...state, todo]);

    final prefs = await SharedPreferences.getInstance();
    final todoStrings =
        state.map((todo) => '${todo.title}:${todo.description}:${todo.isCompleted}');
    prefs.setStringList('todos', todoStrings.toList());
  }

  void update(int index, Todo todo) {
    final List<Todo> newState = List.from(state);
    newState[index] = todo;
    emit(newState);
  }

  Future<void> saveTodos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final todoStrings =
        state.map((todo) => '${todo.title}:${todo.description}:${todo.isCompleted}');
    prefs.setStringList('todos', todoStrings.toList());
  }

  Future<void> loadTodos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? todoStrings = prefs.getStringList('todos');

    if (todoStrings != null) {
      List<Todo> todos = todoStrings.map((str) {
        final parts = str.split(':');
        return Todo(
          title: parts[0],
          description: parts[1],
          isCompleted: parts[2] == 'true',
        );
      }).toList();
      emit(todos);
    }
  }

  void toggleTodoCompletion(int index) {
    List<Todo> todos = List.from(state);
    todos[index] = Todo(
      title: todos[index].title,
      description: todos[index].description,
      isCompleted: !todos[index].isCompleted,
    );
    emit(todos);
  }
}


