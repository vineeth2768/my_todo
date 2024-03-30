import 'package:flutter/material.dart';
import 'package:my_todo/Provider/provider_db.dart';
import 'package:my_todo/Provider/theme_provider.dart';
import 'package:my_todo/model/todo.dart';
import 'package:my_todo/pages/add_todo.dart';
import 'package:my_todo/pages/todo_update.dart';

import 'package:provider/provider.dart';

enum TodoFilter { all, completed, active }

class TodoView extends StatefulWidget {
  const TodoView({super.key});

  @override
  _TodoViewState createState() => _TodoViewState();
}

class _TodoViewState extends State<TodoView> {
  TodoFilter _filter = TodoFilter.all;

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderDB>(builder: (context, notifier, child) {
      return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AddTodo()));
          },
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          title: const Text("My Todo Activities"),
          actions: [
            Switch(
                activeColor: Colors.green,
                trackOutlineColor:
                    MaterialStateProperty.all(Colors.transparent),
                value: Provider.of<ThemeServiceProvider>(context).isDarkModeOn,
                inactiveTrackColor: Colors.blueGrey,
                inactiveThumbColor: Colors.black87,
                onChanged: (_) {
                  Provider.of<ThemeServiceProvider>(context, listen: false)
                      .toggleTheme();
                }),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton<TodoFilter>(
                  value: _filter,
                  onChanged: (value) {
                    setState(() {
                      _filter = value!;
                    });
                  },
                  items: TodoFilter.values
                      .map((filter) => DropdownMenuItem<TodoFilter>(
                            value: filter,
                            child: Text(_getFilterText(filter)),
                          ))
                      .toList(),
                ),
              ),
              Expanded(
                child: _buildTodoList(notifier.todo),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildTodoList(List<Todo> todos) {
    List<Todo> filteredTodos;

    switch (_filter) {
      case TodoFilter.completed:
        filteredTodos = todos.where((todo) => todo.isCompleted).toList();
        break;
      case TodoFilter.active:
        filteredTodos = todos.where((todo) => !todo.isCompleted).toList();
        break;
      case TodoFilter.all:
      default:
        filteredTodos = todos;
    }

    return filteredTodos.isEmpty
        ? const Center(child: Text("Empty Todos"))
        : ListView.builder(
            itemCount: filteredTodos.length,
            itemBuilder: (context, index) {
              Todo todo = filteredTodos[index];
              return Card(
                margin: const EdgeInsets.all(10),
                elevation: 5,
                child: ListTile(
                  title: Text(
                    "${index + 1}.${todo.title}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(todo.content),
                  leading: Checkbox(
                    value: todo.isCompleted,
                    onChanged: (value) {
                      Provider.of<ProviderDB>(context, listen: false)
                          .toggleTodoCompletion(todo.todoId!, value ?? false);
                      if (value == true) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            behavior: SnackBarBehavior.floating,
                            duration: const Duration(seconds: 1),
                            content:
                                Text('${todo.title} Sucessfully Completed!'),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            behavior: SnackBarBehavior.floating,
                            duration: const Duration(seconds: 1),
                            content: Text('${todo.title} Active Now!'),
                          ),
                        );
                      }
                    },
                  ),
                  trailing: IconButton(
                      onPressed: () {
                        Provider.of<ProviderDB>(context, listen: false)
                            .deleteTodo(todo.todoId!);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            behavior: SnackBarBehavior.floating,
                            content: Text('${todo.title} Sucessfully Removed!'),
                          ),
                        );
                      },
                      icon: const Icon(Icons.close_rounded)),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UpdateTodo(
                        todo: todo,
                      ),
                    ),
                  ),
                ),
              );
            },
          );
  }

  String _getFilterText(TodoFilter filter) {
    switch (filter) {
      case TodoFilter.completed:
        return 'Completed';
      case TodoFilter.active:
        return 'Active';
      case TodoFilter.all:
      default:
        return 'All';
    }
  }
}
