import 'package:mvc_tasks/data/dao/crud_dao.dart';
import 'package:mvc_tasks/data/model/tasks.dart';

class TaskDao extends CrudDao<Tasks> {
  TaskDao() : super(tableName: Tasks.tableName);

  @override
  List<String> entityFields() {
    return TasksFields.values;
  }

  @override
  Tasks fromJson(Map<String, Object?> map) => Tasks.fromDatabase(
        id: map[TasksFields.id] as int?,
        name: map[TasksFields.name] as String,
        difficulty: map[TasksFields.difficulty] as int,
        image: map[TasksFields.image] as String,
      );
}
