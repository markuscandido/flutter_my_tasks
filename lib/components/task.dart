import 'package:flutter/material.dart';
import 'package:mvc_tasks/components/difficulty.dart';

class Task extends StatefulWidget {
  final String name;
  final String srcPhoto;
  final int nivelDificuldade;

  const Task(
      {super.key,
      required this.name,
      required this.srcPhoto,
      required this.nivelDificuldade});

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  static const int nivelMinimo = 0;
  static const int nivelMaximo = 10;

  int nivel = 0;

  bool showBtnNivelUp = false;
  bool showBtnNivelDown = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Container(
            height: 140,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.blue,
            ),
          ),
          Column(
            children: [
              Container(
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 72,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.black26,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.asset(
                            widget.srcPhoto,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 180,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.name,
                            style: const TextStyle(
                              fontSize: 20,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Difficulty(
                            difficultyLevel: widget.nivelDificuldade,
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              if (nivel >= nivelMaximo) {
                                return;
                              }
                              nivel++;
                              //showBtnNivelUp = nivel < nivelMaximo;
                              //showBtnNivelDown = nivel > nivelMinimo;
                            });
                          },
                          child: const Icon(Icons.arrow_drop_up),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              if (nivel <= nivelMinimo) {
                                return;
                              }
                              nivel--;
                              //showBtnNivelUp = nivel < nivelMaximo;
                              //showBtnNivelDown = nivel > nivelMinimo;
                            });
                          },
                          child: const Icon(Icons.arrow_drop_down),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 200,
                      child: LinearProgressIndicator(
                        value: widget.nivelDificuldade > 0
                            ? (nivel / widget.nivelDificuldade) / nivelMaximo
                            : 1,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Nível: $nivel',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
