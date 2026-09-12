import 'package:flutter/material.dart';
import '../viewModel/home_viewmodel.dart';
import '../data/models/todo_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _viewModel = HomeViewModel();

  @override
  void initState() {
    super.initState();
    _viewModel.loadUserName();
    _viewModel.loadTodos();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _viewModel,
      builder: (context, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text(_viewModel.userFullName),
            actions: [
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () async {
                  await _viewModel.logout();
                  if (context.mounted) {
                    Navigator.pushReplacementNamed(context, '/login');
                  }
                },
              ),
            ],
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: TextField(
                  decoration: const InputDecoration(
                    labelText: 'Buscar tarefa',
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: _viewModel.setSearchText,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: DropdownButton<TodoFilter>(
                  value: TodoFilter.all,
                  isExpanded: true,
                  items: const [
                    DropdownMenuItem(
                      value: TodoFilter.all,
                      child: Text('Todas'),
                    ),
                    DropdownMenuItem(
                      value: TodoFilter.completed,
                      child: Text('Completadas'),
                    ),
                    DropdownMenuItem(
                      value: TodoFilter.pending,
                      child: Text('Não completadas'),
                    ),
                  ],
                  onChanged: (value) {
                    if (value != null) _viewModel.setFilter(value);
                  },
                ),
              ),
              if (_viewModel.isLoading)
                const Expanded(
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (_viewModel.errorMessage != null)
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(_viewModel.errorMessage!),
                        ElevatedButton(
                          onPressed: _viewModel.loadTodos,
                          child: const Text('Tentar de novo'),
                        ),
                      ],
                    ),
                  ),
                )
              else
                Expanded(
                  child: ListView.builder(
                    itemCount: _viewModel.todos.length,
                    itemBuilder: (context, index) {
                      final TodoModel todo = _viewModel.todos[index];
                      return Card(
                        color: todo.completed ? Colors.grey[300] : null,
                        child: CheckboxListTile(
                          value: todo.completed,
                          onChanged: (_) => _viewModel.toggleCompleted(todo),
                          title: Text(
                            todo.todo,
                            style: TextStyle(
                              color: todo.completed
                                  ? Colors.grey
                                  : Colors.black,
                              decoration: todo.completed
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
