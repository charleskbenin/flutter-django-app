import 'package:todo/api/api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screens/addTodo.dart';

void main() {
  runApp(MyApp());
}
//codecindy
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TodoProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity, 
        ),
        home: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final todoP = Provider.of<TodoProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo App'),
        centerTitle: true,
        actions: [
          CircleAvatar(
            backgroundColor: Colors.white,
            child: IconButton(
              icon: Icon(Icons.add), 
              color: Colors.blue,
              onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (ctx) => AddTodoScreen()));
            }),
          ),
          
        ],
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: todoP.todos.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
                      child: ListTile(
                trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      todoP.deleteTodo(todoP.todos[index]);
                    }),
                title: Text(
                  todoP.todos[index].title,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  todoP.todos[index].description,
                  style: TextStyle(fontSize: 15, color: Colors.black),
                )),
          );
        },
      ),
      // floatingActionButton: FloatingActionButton(  
      //     child: Icon(
      //       Icons.add,
      //       size: 30,
      //     ),
      //     onPressed: () {
      //       Navigator.of(context)
      //           .push(MaterialPageRoute(builder: (ctx) => AddTodoScreen()));
      //     }),
    );
  }
}
