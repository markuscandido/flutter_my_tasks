import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mvc_tasks/components/task.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksScreen> {
  bool showList = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: const Text('MVC::Tasks'),
        backgroundColor: Colors.blue,
      ),
      body: AnimatedOpacity(
        opacity: showList ? 1 : 0,
        duration: const Duration(milliseconds: 500),
        child: ListView(
          children: const [
            Task(
              name: 'Formação Flutter',
              srcPhoto: 'assets/images/dash.png',
              nivelDificuldade: 1,
            ),
            Task(
              name: 'Andar de bike',
              srcPhoto: 'assets/images/bike.webp',
              nivelDificuldade: 2,
            ),
            Task(
              name: 'Ler um livro',
              srcPhoto: 'assets/images/livro.jpg',
              nivelDificuldade: 3,
            ),
            Task(
              name: 'Meditar',
              srcPhoto: 'assets/images/meditar.jpeg',
              nivelDificuldade: 4,
            ),
            Task(
              name: 'Jogar',
              srcPhoto: 'assets/images/jogar.jpg',
              nivelDificuldade: 5,
            ),
            SizedBox(
              height: 75,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            showList = !showList;
            if (kDebugMode) {
              //print('object');
            }
          });
        },
        child: Icon(showList ? Icons.lock : Icons.lock_open),
      ),
    );
  }
}
