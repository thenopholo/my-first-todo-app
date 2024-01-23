import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'taks.db');
  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(tableSql);
    },
    version: 1,
  );
}

const String tableSql = 'CREATE TABLE $_tablename('
    '$_name TEXT, '
    '$_difficulty INTERGER, '
    '$_image TEXT)';

const String _tablename = 'TaskTable';
const String _name = 'name';
const String _difficulty = 'difficulty';
const String _image = 'image';
