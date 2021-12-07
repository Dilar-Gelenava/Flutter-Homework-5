import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:untitled/providers/todo_provider.dart';
import 'package:untitled/screens/home_screen.dart';
import 'package:untitled/screens/add_screen.dart';
import 'package:untitled/screens/edit_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return ChangeNotifierProvider(
      create: (ctx) => TodoProvider(),
      child: MaterialApp(
        title: 'Todos',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const HomeScreen(),
          '/add' : (context) => const AddScreen(),
          '/edit' : (context) => const EditScreen(),
        },
      ),
    );
  }
}
