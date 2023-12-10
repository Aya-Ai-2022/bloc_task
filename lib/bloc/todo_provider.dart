import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_todo_bloc/bloc/todo_cubit.dart';




class TodoProvider extends BlocProvider<TodoCubit> {
  TodoProvider({
    Key? key,
    required Widget child,
  }) : super(
          key: key,
          create: (BuildContext context) => TodoCubit(),
          child: child,
        );

  static TodoCubit of(BuildContext context) =>
      BlocProvider.of<TodoCubit>(context);
}

