import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mvc_tasks/data/task_inherited.dart';
import 'package:mvc_tasks/screens/form_validate/difficulty_range_form_validate.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({Key? key, required this.taskContext}) : super(key: key);

  final BuildContext taskContext;

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController difficultyController = TextEditingController();
  TextEditingController imageController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Nova Tarefa'),
        ),
        body: Center(
          child: Container(
            height: 650,
            width: 375,
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 3),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (String? value) {
                      if (isNotNullOrEmpty(value)) {
                        return 'Insira o nome da Tarefa';
                      }
                      return null;
                    },
                    controller: nameController,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Nome',
                      fillColor: Colors.white70,
                      filled: true,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (value) =>
                        DifficultyRangeInputFormValidate().validator(value),
                    keyboardType: TextInputType.number,
                    controller: difficultyController,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Dificuldade',
                      fillColor: Colors.white70,
                      filled: true,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    onChanged: (text) {
                      setState(() {});
                    },
                    validator: (value) {
                      if (isNotNullOrEmpty(value)) {
                        return 'Insira um URL de Imagem!';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.url,
                    controller: imageController,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Imagem',
                      fillColor: Colors.white70,
                      filled: true,
                    ),
                  ),
                ),
                Container(
                  height: 100,
                  width: 72,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 2, color: Colors.blue),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      imageController.text,
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace? stackTrace) {
                        return Image.asset('assets/images/nophoto.png');
                      },
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (kDebugMode) {
                        print(nameController.text);
                        print(difficultyController.text);
                        print(imageController.text);
                      }
                      TaskInherited.of(widget.taskContext).newTask(
                        nameController.text,
                        imageController.text,
                        int.parse(difficultyController.text),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Tarefa adicionada'),
                        ),
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Adicionar!'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Validar se o campo do formulários está preenchido
  bool isNotNullOrEmpty(String? value) => value != null && value.isEmpty;
}
