import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:mvc_tasks/data/model/tasks.dart';
import 'package:sqflite/utils/utils.dart';

class TasksDatabase {
  static final TasksDatabase instance = TasksDatabase._init();
  static Database? _database;
  TasksDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('tasks.db');
    return _database!;
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }

  Future<bool> tableExists(DatabaseExecutor db, String tableName) async {
    var count = firstIntValue(await db.query('sqlite_master',
        columns: ['COUNT(*)'],
        where: 'type = ? AND name = ?',
        whereArgs: ['table', tableName]));
    return count == null ? false : count > 0;
  }

  Future<List<String>> getTablesName(DatabaseExecutor db) async {
    List<String> tableNames = (await db.query(
      'sqlite_master',
      where: 'type = ?',
      whereArgs: ['table'],
    ))
        .map((row) => row['name'] as String)
        .toList(growable: false)
      ..sort();
    return tableNames;
  }

  Future<Database> _initDB(
    String filePath,
  ) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(
    Database db,
    int version,
  ) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const integerNotNullType = 'INTEGER NOT NULL';
    const textType = 'TEXT NOT NULL';

    const String createTableTasks = '''
    CREATE TABLE ${Tasks.tableName} (
      ${TasksFields.id} $idType,
      ${TasksFields.name} $textType,
      ${TasksFields.difficulty} $integerNotNullType DEFAULT 1,
      ${TasksFields.image} $textType
    )
    ''';

    const List<String> createTables = [createTableTasks];
    for (var table in createTables) {
      await db.execute(table);
    }
  }
}
