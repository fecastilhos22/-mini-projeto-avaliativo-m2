import '../datasources/todo_datasource.dart';
import '../models/todo_model.dart';
import 'result.dart';

class TodoRepository {
  final TodoDatasource _datasource = TodoDatasource();

  Future<Result<List<TodoModel>>> getTodos() async {
    try {
      final rawList = await _datasource.getTodos();
      final todos = rawList
          .map((json) => TodoModel.fromJson(json as Map<String, dynamic>))
          .toList();
      return Success(todos);
    } catch (e) {
      return Failure(e.toString());
    }
  }
}