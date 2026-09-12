import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/todo_model.dart';

class TodoLocalDatasource {
  Future<Database> _getDatabase() async {
    final path = join(await getDatabasesPath(), 'todos.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          '''CREATE TABLE todos(
            id INTEGER PRIMARY KEY,
            todo TEXT,
            completed INTEGER,
            userId INTEGER
          )''',
        );
      },
    );
  }

  Future<void> insertAll(List<TodoModel> todos) async {
    final db = await _getDatabase();
    final batch = db.batch();
    for (final todo in todos) {
      batch.insert(
        'todos',
        todo.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
  }

  Future<List<TodoModel>> getAll() async {
    final db = await _getDatabase();
    final maps = await db.query('todos');
    return maps.map((map) {
      return TodoModel(
        id: map['id'] as int,
        todo: map['todo'] as String,
        completed: (map['completed'] as int) == 1,
        userId: map['userId'] as int,
      );
    }).toList();
  }

  Future<void> updateCompleted(int id, bool completed) async {
    final db = await _getDatabase();
    await db.update(
      'todos',
      {'completed': completed ? 1 : 0},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}