import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/todo.dart';
import 'package:http/http.dart' as http;

class TodoProvider with ChangeNotifier {
  TodoProvider() {
    this.fetchTasks();
  }

  List<Todo> _todos = [];

  List<Todo> get todos {
    return [..._todos];
  }

  void addTodo(Todo todo) async {
    String url  = 'http://apisamp.herokuapp.com/apis/v1/';
    final response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: json.encode(todo));
    if (response.statusCode == 201) {
      todo.id = json.decode(response.body)['id'];
      _todos.add(todo);
      notifyListeners();
    }
  }

  void deleteTodo(Todo todo) async {
    String url = 'http://apisamp.herokuapp.com/apis/v1/${todo.id}/';
    final response =
        await http.delete(Uri.parse(url));
    if (response.statusCode == 204) {
      _todos.remove(todo);
      notifyListeners();
    }
  }

  fetchTasks() async {
    final url = 'http://apisamp.herokuapp.com/apis/v1/?format=json';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = json.decode(response.body) as List;
      _todos = data.map<Todo>((json) => Todo.fromJson(json)).toList();
      notifyListeners();
    }
  }
}
