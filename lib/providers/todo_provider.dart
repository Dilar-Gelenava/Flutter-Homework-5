import 'package:flutter/cupertino.dart';
import 'package:untitled/data/models/todo.dart';
import 'package:untitled/data/repository/todo_repository.dart';

class TodoProvider extends ChangeNotifier {
  List<TodoModel> _todos = [];

  void getTodos() async {
    _todos = (await TodoRepository().fetchTodos())!;
    notifyListeners();
  }

  void getTodo(id) async {
    _todos = (await TodoRepository().fetchTodos())!;
    notifyListeners();
  }

  List get getTodoList => _todos;

  void addTodo(todo) {
    notifyListeners();
  }
}
