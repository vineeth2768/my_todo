import 'package:flutter/material.dart';
import 'package:my_todo/Provider/provider_db.dart';
import 'package:my_todo/model/todo.dart';

import 'package:provider/provider.dart';

class UpdateTodo extends StatelessWidget {
  final Todo? todo;
  const UpdateTodo({super.key, this.todo});

  @override
  Widget build(BuildContext context) {
    final title = TextEditingController();
    final content = TextEditingController();
    final notifier = Provider.of<ProviderDB>(context, listen: false);

    title.text = todo?.title ?? "";
    content.text = todo?.content ?? "";

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Todo"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                onPressed: () => notifier
                    .updateTodo(Todo(
                        todoId: todo?.todoId,
                        title: title.text,
                        content: content.text,
                        isCompleted: false))
                    .whenComplete(() => Navigator.pop(context)),
                icon: const Icon(Icons.check)),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              TextFormField(
                controller: title,
                decoration: const InputDecoration(
                    hintText: "Title", border: InputBorder.none),
              ),
              TextFormField(
                controller: content,
                maxLines: 20,
                maxLength: 1000,
                decoration: const InputDecoration(
                    hintText: "Content", border: InputBorder.none),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
