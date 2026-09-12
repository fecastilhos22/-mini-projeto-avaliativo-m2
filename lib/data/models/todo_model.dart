class TodoModel {
  final int _id;
  final String _todo;
  final bool _completed;
  final int _userId;

  TodoModel({
    required int id,
    required String todo,
    required bool completed,
    required int userId,
  })  : _id = id,
        _todo = todo,
        _completed = completed,
        _userId = userId;

  int get id => _id;
  String get todo => _todo;
  bool get completed => _completed;
  int get userId => _userId;

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'],
      todo: json['todo'],
      completed: json['completed'],
      userId: json['userId'],
    );
  }

  // Útil pra quando formos salvar/ler do SQLite mais pra frente
  Map<String, dynamic> toMap() {
    return {
      'id': _id,
      'todo': _todo,
      'completed': _completed ? 1 : 0,
      'userId': _userId,
    };
  }

  // Um "copyWith" ajuda a criar uma cópia do objeto mudando só um campo
  // (vamos usar isso quando o usuário marcar uma tarefa como completa)
  TodoModel copyWith({bool? completed}) {
    return TodoModel(
      id: _id,
      todo: _todo,
      completed: completed ?? _completed,
      userId: _userId,
    );
  }

  @override
  String toString() => 'TodoModel(id: $_id, todo: $_todo, completed: $_completed)';
}