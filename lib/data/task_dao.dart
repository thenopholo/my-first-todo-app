import 'package:nosso_primeiro_projeto/components/task.dart';

class TaskDao {
  static const String tableSql = 'CREATE TABLE $_tablename('
      '$_name TEXT, '
      '$_difficulty INTERGER, '
      '$_image TEXT)';

  static const String _tablename = 'TaskTable';
  static const String _name = 'name';
  static const String _difficulty = 'difficulty';
  static const String _image = 'image';

  save(Task taerfa) async{}
  Future <List<Task>> findAll() async{}
  Future <List<Task>>find(String nomeDaTarefa) async{}
  delete(String nomeDaTarefa) async{}
}