import 'package:mvc_tasks/data/model/entity.dart';

abstract class EntityFields {
  static const String id = '_id';
}

abstract class TasksFields {
  static final List<String> values = [
    id,
    name,
    difficulty,
    image,
  ];

  static const String id = EntityFields.id;
  static const String name = 'name';
  static const String difficulty = 'difficulty';
  static const String image = 'image';
}

class Tasks extends Entity<Tasks> {
  static const String tableName = 'Tasks';
  String name;
  int difficulty;
  String image;

  Tasks({
    required this.name,
    required this.difficulty,
    required this.image,
  }) : super(id: null);

  Tasks.fromDatabase({
    required super.id,
    required this.name,
    required this.difficulty,
    required this.image,
  });

  @override
  Map<String, Object?> toJson() => {
        TasksFields.id: id,
        TasksFields.name: name,
        TasksFields.difficulty: difficulty,
        TasksFields.image: image,
      };
}
