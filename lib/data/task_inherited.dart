import 'package:flutter/material.dart';

import '../components/task.dart';

class TaskInherited extends InheritedWidget {
  TaskInherited({
    Key? key,
    required Widget child,
  }) : super(
          key: key,
          child: child,
        );

  final List<Task> taskList = [
    Task(
      name: 'Aprender Flutter',
      srcPhoto: 'assets/images/dash.png',
      difficultyLevel: 3,
    ),
    Task(
      name: 'Andar de Bike',
      srcPhoto: 'assets/images/bike.webp',
      difficultyLevel: 2,
    ),
    Task(
      name: 'Meditar',
      srcPhoto: 'assets/images/meditar.jpeg',
      difficultyLevel: 5,
    ),
    Task(
      name: 'Ler',
      srcPhoto: 'assets/images/livro.jpg',
      difficultyLevel: 4,
    ),
    Task(
      name: 'Jogar',
      srcPhoto: 'assets/images/jogar.jpg',
      difficultyLevel: 1,
    ),
  ];

  void newTask(String name, String srcPhoto, int difficultyLevel) {
    taskList.add(Task(
      name: name,
      srcPhoto: srcPhoto,
      difficultyLevel: difficultyLevel,
    ));
  }

  static TaskInherited of(BuildContext context) {
    final TaskInherited? result =
        context.dependOnInheritedWidgetOfExactType<TaskInherited>();
    assert(result != null, 'No TaskInherited found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(TaskInherited oldWidget) {
    return oldWidget.taskList.length != taskList.length;
  }
}
