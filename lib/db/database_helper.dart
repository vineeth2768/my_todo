import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../model/todo.dart';

class DatabaseHelper {
  final databaseName = "todoApp.db";
  static String todoTableName = "todo";

  ///Table for todo
  String todoTable = '''
  CREATE TABLE IF NOT EXISTS $todoTableName (
  todoId INTEGER PRIMARY KEY AUTOINCREMENT,
  title TEXT,
  content TEXT,
  isCompleted INTEGER
  )''';

  /// Database connection
  Future<Database> initDB() async {
    final databasePath = await getApplicationDocumentsDirectory();
    final path = "${databasePath.path}/$databaseName";
    return openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute(todoTable);
    });
  }

  ///CRUD Methods
  // Get Todo
  Future<List<Todo>> getTodo() async {
    final db = await initDB();
    final List<Map<String, Object?>> res = await db.query(todoTableName);
    return res.map((e) => Todo.fromMap(e)).toList();
  }

  // Add Todo
  Future<void> addTodo(Todo todo) async {
    final db = await initDB();
    db.insert(todoTableName, todo.toMap());
  }

  // Update Todo
  Future<void> updateTodo(Todo todo) async {
    final db = await initDB();
    db.update(todoTableName, todo.toMap(),
        where: "todoId = ?", whereArgs: [todo.todoId]);
  }

  // Delete Todo
  Future<void> deleteTodo(int id) async {
    final db = await initDB();
    db.delete(todoTableName, where: "todoId = ?", whereArgs: [id]);
  }

  // Toggle Todo Completion
  Future<void> toggleTodoCompletion(int id, bool isCompleted) async {
    final db = await initDB();
    db.update(
      todoTableName,
      {'isCompleted': isCompleted ? 1 : 0},
      where: "todoId = ?",
      whereArgs: [id],
    );
  }
}
