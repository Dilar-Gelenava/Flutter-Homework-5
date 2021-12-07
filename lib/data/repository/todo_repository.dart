import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:untitled/data/models/todo.dart';

class TodoRepository {
  List<TodoModel>? todoList = [];
  Dio dio = Dio();

  static const domain = 'http://10.0.2.2:8080';

  Future<List<TodoModel>?>? fetchTodos() async {
    final response = await dio.get('$domain/todos');
    if (response.statusCode == 200) {
      var loadedTodo = <TodoModel>[];
      response.data.forEach((todo) {
        TodoModel todoModel = TodoModel.fromJson(todo);
        loadedTodo.add(todoModel);
        todoList = loadedTodo;
        return todoList;
      });
    }
    return todoList;
  }

  Future getTodo(int id) async {
    final response = await dio.post('$domain/todo/$id');

    if (response.statusCode == 200) {
      response.data;
    } else {
      return null;
    }
  }

  Future createTodo(int id, String todo, String description) async {
    var params = {"id": id, "todo": todo, "description": description};

    final response = await dio.post(
      '$domain/add-todo',
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      }),
      data: jsonEncode(params),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future removeTodo(int id) async {
    final response = await dio.delete(
      '$domain/delete-todo/$id',
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future editTodo(int id, String todo, String description) async {
    var params = {"id": id, "todo": todo, "description": description};

    final response = await dio.put(
      '$domain/update-todo',
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      }),
      data: jsonEncode(params),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
