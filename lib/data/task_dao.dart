import 'package:nosso_primeiro_projeto/components/task.dart';
import 'package:nosso_primeiro_projeto/data/database.dart';
import 'package:sqflite/sqflite.dart';

class TaskDao {
  static const String tableSql = 'CREATE TABLE $_tablename('
      '$_name TEXT, '
      '$_difficulty INTERGER, '
      '$_image TEXT)';

  static const String _tablename = 'TaskTable';
  static const String _name = 'name';
  static const String _difficulty = 'difficulty';
  static const String _image = 'image';

  save(Task tarefa) async {
    /// TODO: Remover o print após o teste
    print('iniciando o save');
    final Database dataBase = await getDatabase();
    var itemExists = await find(tarefa.nome);
    Map<String, dynamic> taskMap = toMap(tarefa);
    if (itemExists.isEmpty) {
      /// TODO: Remover o print após o teste
      print('A tarefa não existia');
      return await dataBase.insert(_tablename, taskMap);
    } else {
      /// TODO: Remover o print após o teste
      print('A tarefa já existia');
      return await dataBase.update(
        _tablename,
        taskMap,
        where: '$_name = ?',
        whereArgs: [tarefa.nome],
      );
    }
  }

  Map<String, dynamic> toMap(Task tarefa) {
    /// TODO: Remover o print após o teste
    print('Convertendo tarefa em mapa');
    final Map<String, dynamic> mapaDeTarefas = Map();
    mapaDeTarefas[_name] = tarefa.nome;
    mapaDeTarefas[_image] = tarefa.foto;
    mapaDeTarefas[_difficulty] = tarefa.dificuldade;

    /// TODO: Remover o print após o teste
    print('Mapa de tarefas: $mapaDeTarefas');
    return mapaDeTarefas;
  }

  Future<List<Task>> findAll() async {
    /// TODO: Remover o print após o teste
    print('Acessando o findAll');
    final Database dataBase = await getDatabase();
    final List<Map<String, dynamic>> result = await dataBase.query(_tablename);

    /// TODO: Remover o print após o teste
    print('Prucurando dados no banco de dados... Encontrado: $result');
    return toList(result);
  }

  List<Task> toList(List<Map<String, dynamic>> mapaDeTarefas) {
    /// TODO: Remover o print após o teste
    print('Convertendo to list: ');
    final List<Task> tarefas = [];
    for (Map<String, dynamic> linha in mapaDeTarefas) {
      final Task tarefa = Task(linha[_name], linha[_image], linha[_difficulty]);
      tarefas.add(tarefa);
    }

    /// TODO: Remover o print após o teste
    print('lista de Tarefas $tarefas');
    return tarefas;
  }

  Future<List<Task>> find(String nomeDaTarefa) async {
    /// TODO: Remover o print após o teste
    print('Acessando o find: ');
    final Database database = await getDatabase();
    final List<Map<String, dynamic>> result = await database.query(
      _tablename,
      where: '$_name = ?',
      whereArgs: [nomeDaTarefa],
    );

    /// TODO: Remover o print após o teste
    print('Tarefa encontrada: ${toList(result)}');
    return toList(result);
  }

  delete(String nomeDaTarefa) async {}
}
