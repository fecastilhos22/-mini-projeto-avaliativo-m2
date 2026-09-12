import '../datasources/todo_datasource.dart';
import '../datasources/todo_local_datasource.dart';
import '../models/todo_model.dart';
import 'result.dart';

class TodoRepository {
  final TodoDatasource _remote = TodoDatasource();
  final TodoLocalDatasource _local = TodoLocalDatasource();

  Future<Result<List<TodoModel>>> getTodos() async {
    try {
      final rawList = await _remote.getTodos();
      final todos = rawList
          .map((json) => TodoModel.fromJson(json as Map<String, dynamic>))
          .toList();
      await _local.insertAll(todos); // salva no SQLite
      final saved = await _local.getAll(); // lê de volta via SELECT
      return Success(saved);
    } catch (e) {
      // se a API falhar, tenta usar o que já tem salvo localmente
      final local = await _local.getAll();
      if (local.isNotEmpty) return Success(local);
      return Failure(e.toString());
    }
  }

  Future<Result<void>> updateCompleted(int id, bool completed) async {
    try {
      await _local.updateCompleted(id, completed);
      return const Success(null);
    } catch (e) {
      return Failure(e.toString());
    }
  }
}