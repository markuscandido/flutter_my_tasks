import 'package:mvc_tasks/data/database.dart';
import 'package:mvc_tasks/data/model/entity.dart';

/// Representação de operações básicas de um banco de dados
abstract class CrudDao<T extends Entity> {
  final String _defaultWhereById = '_id = ?';
  final String _tableName;

  CrudDao({
    required String tableName,
  }) : _tableName = tableName;

  /// Cada entidade precisa saber como converter um map em propriedades
  T fromJson(Map<String, Object?> map);

  /// Informar todas as colunas da tabela
  List<String> entityFields();

  /// Salvar um novo registro
  Future<T> create(T entity) async {
    final db = await TasksDatabase.instance.database;
    final id = await db.insert(_tableName, entity.toJson());
    return findById(id);
  }

  /// Listar todos os registros
  Future<List<T>> findAll() async {
    final db = await TasksDatabase.instance.database;
    final result = await db.query(_tableName);
    return result.map((json) => fromJson(json)).toList();
  }

  /// Buscar pela chave primária
  Future<T> findById(int id) async {
    final db = await TasksDatabase.instance.database;
    final result = await db.query(
      _tableName,
      columns: entityFields(),
      where: _defaultWhereById,
      whereArgs: [id],
    );
    if (result.isEmpty) throw Exception('Id $id não encontrado');
    return fromJson(result.first);
  }

  /// Atualizar um registro
  Future<int> update(T entity) async {
    final db = await TasksDatabase.instance.database;

    return db.update(
      _tableName,
      entity.toJson(),
      where: _defaultWhereById,
      whereArgs: [entity.id],
    );
  }

  /// Remover um registro
  Future<int> delete(int id) async {
    final db = await TasksDatabase.instance.database;
    return await db.delete(
      _tableName,
      where: _defaultWhereById,
      whereArgs: [id],
    );
  }
}
