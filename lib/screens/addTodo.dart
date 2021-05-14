import 'package:todo/api/api.dart';
import 'package:todo/models/todo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddTodoScreen extends StatefulWidget {
  @override
  _AddTodoScreenState createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  final todoTitleController = TextEditingController();
  final todoDesController = TextEditingController();

  void onAdd() {
    final String textVal = todoTitleController.text;
    final String desVal = todoDesController.text;

    if (textVal.isNotEmpty && desVal.isNotEmpty) {
      final Todo todo = Todo(title: textVal, description: desVal);
      Provider.of<TodoProvider>(context, listen: false).addTodo(todo);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Todo')),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.all(30),
              child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(15)
                    )
                  ),
                  hintText: 'Enter Todo Title',
                  filled: true,
                  fillColor: Colors.white70
                ),
                controller: todoTitleController,
              ),
              SizedBox(height: 30),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 50),
                 decoration: BoxDecoration(
                   border: Border.all(),
                   borderRadius: const BorderRadius.all(const Radius.circular(15))
                 ),
                child: TextField(
                  decoration: InputDecoration(
                  hintText: 'Enter Todo Description',
                ),
                  controller: todoDesController,
                ),
              ),
              ElevatedButton(
                child: Text('Add'),
                  onPressed: () {
                    onAdd(); 
                    Navigator.of(context).pop();
                })
            ],
          ))
        ],
      ),
    );
  }
}
