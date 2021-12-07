import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/data/repository/todo_repository.dart';
import 'package:untitled/providers/todo_provider.dart';

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<TodoProvider>(context, listen: false).getTodos();
  }

  @override
  Widget build(BuildContext context) {
    List _todos = Provider.of<TodoProvider>(context).getTodoList;

    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: <Color>[Color(0xff525252), Color(0xff3d72b4)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter)),
          ),
          title: const Center(
            child: Text(
              'Todos',
              style: TextStyle(
                fontSize: 40,
              ),
            ),
          ),
          elevation: 0,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, "/add");
          },
          child: const Icon(Icons.add),
          backgroundColor: Colors.blue,
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {
            return Dismissible(
              key: UniqueKey(),
              onDismissed: (direction) {
                TodoRepository().removeTodo(_todos[index].id);
                Provider.of<TodoProvider>(context, listen: false).getTodos();
              },
              child: GestureDetector(
                onLongPress: () {
                  Navigator.pushNamed(context, "/edit", arguments: {
                    "id": _todos[index].id,
                    "todo": _todos[index].todo,
                    "description": _todos[index].description
                  });
                },
                child: ListTile(
                  title: Text(_todos[index].todo),
                  subtitle: Text(_todos[index].description),
                  trailing: CircleAvatar(
                    child: Text(
                      _todos[index].id.toString(),
                    ),
                  ),
                ),
              ),
            );
          },
          itemCount: _todos.length,
        ));
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
