import 'package:flutter/material.dart';
import 'package:mvc_tasks/screens/tasks_screen.dart';

void main() {
  runApp(const MvcTasksApp());
}

class MvcTasksApp extends StatelessWidget {
  const MvcTasksApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MVC::Tasks',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const TasksScreen(),
    );
  }
}
