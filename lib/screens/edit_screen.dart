import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/providers/todo_provider.dart';
import 'package:untitled/widgets/main_button.dart';
import 'package:untitled/data/repository/todo_repository.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({Key? key}) : super(key: key);

  @override
  State<EditScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<EditScreen> {
  late final TextEditingController _todoController = TextEditingController();
  late final TextEditingController _descriptionController =
  TextEditingController();



  @override
  Widget build(BuildContext context) {
    Map _routeArgs = ModalRoute.of(context)!.settings.arguments as Map;

    _todoController.text = _routeArgs['todo'];
    _descriptionController.text = _routeArgs['description'];

    return Scaffold(
        appBar: AppBar(
          title: const Text('Todo App'),
        ),
        body: Column(
          children: [
            TextField(
              controller: _todoController,
              textAlignVertical: TextAlignVertical.center,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 25,
              ),
              decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                  ),
                  hintText: 'Please enter Todo'),
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 15)),
            TextField(
              controller: _descriptionController,
              textAlignVertical: TextAlignVertical.center,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 25,
              ),
              decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                  ),
                  hintText: 'Please enter Description'),
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 15)),
            MainButton(
                action: () async => {
                  if (_todoController.text == "" ||
                      _descriptionController.text == "")
                    {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please enter valid data'),
                        ),
                      )
                    }
                  else
                    {
                      TodoRepository().editTodo(_routeArgs['id'], _todoController.text, _descriptionController.text).then((value) => {
                        if (value)
                          {
                            Provider.of<TodoProvider>(context,
                                listen: false)
                                .getTodos(),
                            Navigator.of(context).pop()
                          }
                        else
                          {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('error'),
                              ),
                            )
                          }
                      }),
                    }
                },
                text: 'UPDATE'),
          ],
        ));
  }
}
