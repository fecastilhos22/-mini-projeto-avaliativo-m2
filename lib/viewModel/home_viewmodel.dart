import 'package:flutter/foundation.dart';
import '../data/models/todo_model.dart';
import '../data/repositories/todo_repository.dart';
import '../data/repositories/session_repository.dart';
import '../data/repositories/result.dart';

enum TodoFilter { all, completed, pending }

class HomeViewModel extends ChangeNotifier {
  final TodoRepository _todoRepository = TodoRepository();
  final SessionRepository _sessionRepository = SessionRepository();

  bool isLoading = false;
  String? errorMessage;
  String userFullName = '';

  List<TodoModel> _allTodos = [];
  TodoFilter _filter = TodoFilter.all;
  String _searchText = '';

  // Getter que aplica os filtros na hora de exibir (não altera a lista original)
  List<TodoModel> get todos {
    return _allTodos.where((todo) {
      final matchesFilter = switch (_filter) {
        TodoFilter.all => true,
        TodoFilter.completed => todo.completed,
        TodoFilter.pending => !todo.completed,
      };
      final matchesSearch =
          todo.todo.toLowerCase().contains(_searchText.toLowerCase());
      return matchesFilter && matchesSearch;
    }).toList();
  }

  Future<void> loadUserName() async {
    final first = await _sessionRepository.getFirstName() ?? '';
    final last = await _sessionRepository.getLastName() ?? '';
    userFullName = '$first $last';
    notifyListeners();
  }

  Future<void> loadTodos() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    final result = await _todoRepository.getTodos();

    isLoading = false;
    if (result is Success) {
      _allTodos = (result as Success).data;
    } else {
      errorMessage = (result as Failure).message;
    }
    notifyListeners();
  }

  void setFilter(TodoFilter filter) {
    _filter = filter;
    notifyListeners();
  }

  void setSearchText(String text) {
    _searchText = text;
    notifyListeners();
  }

  Future<void> toggleCompleted(TodoModel todo) async {
    final updated = !todo.completed;
    await _todoRepository.updateCompleted(todo.id, updated);

    final index = _allTodos.indexWhere((t) => t.id == todo.id);
    if (index != -1) {
      _allTodos[index] = todo.copyWith(completed: updated);
    }
    notifyListeners();
  }
  Future<void> logout() async {
  await _sessionRepository.clearSession();
  }
}