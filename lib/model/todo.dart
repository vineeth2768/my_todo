import 'dart:convert';

Todo todoFromMap(String str) => Todo.fromMap(json.decode(str));

String todoToMap(Todo data) => json.encode(data.toMap());

class Todo {
  final int? todoId;
  final String title;
  final String content;
  late final bool isCompleted;

  Todo({
    this.todoId,
    required this.title,
    required this.content,
    required this.isCompleted,
  });

  Todo copyWith({
    int? todoId,
    String? title,
    String? content,
    bool? isCompleted,
  }) =>
      Todo(
        todoId: todoId ?? this.todoId,
        title: title ?? this.title,
        content: content ?? this.content,
        isCompleted: isCompleted ?? this.isCompleted,
      );

  factory Todo.fromMap(Map<String, dynamic> json) => Todo(
        todoId: json["todoId"],
        title: json["title"],
        content: json["content"],
        isCompleted: json["isCompleted"] == 1,
      );

  Map<String, dynamic> toMap() => {
        "todoId": todoId,
        "title": title,
        "content": content,
        "isCompleted": isCompleted,
      };
}
