import 'package:nosso_primeiro_projeto/components/task.dart';
import 'package:nosso_primeiro_projeto/data/database.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

class TaskDao {
  static const String tableSql = 'CREATE TABLE $_tablename('
      '$_id TEXT PRIMARY KEY, '
      '$_name TEXT, '
      '$_difficulty INTERGER, '
      '$_image TEXT)';

  static const String _id = 'id';
  static const String _tablename = 'TaskTable';
  static const String _name = 'name';
  static const String _difficulty = 'difficulty';
  static const String _image = 'image';

  save(Task tarefa) async {
    final Database dataBase = await getDatabase();
    var itemExists = await find(tarefa.id);

    if (tarefa.id.isEmpty) {
      var uuid = const Uuid();
      tarefa.id = uuid.v4();
    }

    Map<String, dynamic> taskMap = toMap(tarefa);
    if (itemExists.isEmpty) {
      return await dataBase.insert(_tablename, taskMap);
    } else {
      return await dataBase.update(
        _tablename,
        taskMap,
        where: '$_id = ?',
        whereArgs: [tarefa.id],
      );
    }
  }

  Map<String, dynamic> toMap(Task tarefa) {
    final Map<String, dynamic> mapaDeTarefas = Map();
    mapaDeTarefas[_id] = tarefa.id;
    mapaDeTarefas[_name] = tarefa.nome;
    mapaDeTarefas[_image] = tarefa.foto;
    mapaDeTarefas[_difficulty] = tarefa.dificuldade;
    return mapaDeTarefas;
  }

  Future<List<Task>> findAll() async {
    final Database dataBase = await getDatabase();
    final List<Map<String, dynamic>> result = await dataBase.query(_tablename);
    return toList(result);
  }

  List<Task> toList(List<Map<String, dynamic>> mapaDeTarefas) {
    final List<Task> tarefas = [];
    for (Map<String, dynamic> linha in mapaDeTarefas) {
      final Task tarefa =
          Task(linha[_id], linha[_name], linha[_image], linha[_difficulty]);
      tarefas.add(tarefa);
    }
    return tarefas;
  }

  Future<List<Task>> find(String taskId) async {
    final Database database = await getDatabase();
    final List<Map<String, dynamic>> result = await database.query(
      _tablename,
      where: '$_id = ?',
      whereArgs: [taskId],
    );
    return toList(result);
  }

  delete(String taskId) async {
    final Database database = await getDatabase();
    return await database.delete(
      _tablename,
      where: '$_id = ?',
      whereArgs: [taskId],
    );
  }
}
