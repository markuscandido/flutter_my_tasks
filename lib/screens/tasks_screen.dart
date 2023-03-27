//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mvc_tasks/components/loading.dart';
import 'package:mvc_tasks/components/task.dart';
import 'package:mvc_tasks/data/dao/task_dao.dart';
//import 'package:mvc_tasks/data/dao/task_dao.dart';
import 'package:mvc_tasks/data/database.dart';
import 'package:mvc_tasks/data/model/tasks.dart';
//import 'package:mvc_tasks/data/model/tasks.dart';
//import 'package:mvc_tasks/data/task_inherited.dart';
import 'package:mvc_tasks/screens/form_screen.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksScreen> {
  @override
  void initState() {
    super.initState();
    //testes();
  }

  // Future testes() async {
  //   Tasks nova = await TaskDao().create(
  //     Tasks(
  //       name: 'Minha Taks',
  //       difficulty: 5,
  //       image:
  //           'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTIqGeoReWvsm6-sFgQIGGf19RtgqkAuNggBIVY6LBta7NCuymsxvg9gfpx24YAC1Cb4xE&usqp=CAU',
  //     ),
  //   );
  //   if (kDebugMode) {
  //     print(nova);
  //   }
  //   var tasks = await TaskDao().findAll();
  //   if (kDebugMode) {
  //     print(tasks.length);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {});
            },
            icon: const Icon(Icons.refresh_outlined),
          ),
        ],
        title: const Text('MVC::Tasks'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 72.0),
        child: FutureBuilder<List<Tasks>>(
          future: TaskDao().findAll(),
          builder: (context, snapshot) {
            List<Tasks>? items = snapshot.data;
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return const Loading();
              case ConnectionState.waiting:
                return const Loading();
              case ConnectionState.active:
                return const Loading();
              case ConnectionState.done:
                if (snapshot.hasData && items != null) {
                  if (items.isNotEmpty) {
                    return ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (BuildContext context, index) {
                          final Tasks tarefa = items[index];
                          final Task itemScreen = Task(
                              id: tarefa.id ?? 0,
                              name: tarefa.name,
                              srcPhoto: tarefa.image,
                              difficultyLevel: tarefa.difficulty);
                          return itemScreen;
                        });
                  }
                  return const Center(
                    child: Column(
                      children: [
                        Icon(Icons.error_outline, size: 128),
                        Text(
                          'Não há nenhuma tarefa',
                          style: TextStyle(fontSize: 32),
                        ),
                      ],
                    ),
                  );
                }
                return const Text('Erro ao carregar Tarefas');
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (contextNew) => FormScreen(
                taskContext: context,
              ),
            ),
          ).then((value) => setState(
                () {},
              ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    TasksDatabase.instance.close();
    super.dispose();
  }
}
