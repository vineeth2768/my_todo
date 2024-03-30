import 'package:flutter/cupertino.dart';
import 'package:my_todo/db/database_helper.dart';
import '../model/todo.dart';

class ProviderDB extends ChangeNotifier {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  List<Todo> _todo = [];
  List<Todo> get todo => _todo;

  // Todo Fetch
  Future<void> fetchTodo() async {
    await _databaseHelper.initDB();
    _todo = await _databaseHelper.getTodo();
    notifyListeners();
  }

  // TODO Insert

  Future<void> insertTodo(Todo todos) async {
    await _databaseHelper.initDB();
    _databaseHelper.addTodo(todos);
    await fetchTodo();
  }

  // TODO Update
  Future<void> updateTodo(Todo todos) async {
    await _databaseHelper.initDB();
    _databaseHelper.updateTodo(todos);
    await fetchTodo();
  }

  // TODO Delete
  Future<void> deleteTodo(int id) async {
    await _databaseHelper.initDB();
    _databaseHelper.deleteTodo(id);
    await fetchTodo();
  }

  // TODO Toggle Completion
  Future<void> toggleTodoCompletion(int id, bool isCompleted) async {
    await _databaseHelper.initDB();
    _databaseHelper.toggleTodoCompletion(id, isCompleted);
    await fetchTodo();
  }

  //Init
  /// Init method, to initialize todo list on the start
  init() {
    fetchTodo();
    notifyListeners();
  }
}
