import 'package:flutter/material.dart';
import 'package:todo_app/models/task.dart';

///Widget which displays list of tasks.
class TaskListWidget extends StatelessWidget {
  ///List of tasks to display.
  final List<Task> tasks;

  ///Widget receives list of tasks and display them.
  const TaskListWidget({Key? key, required this.tasks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text(tasks[index].title),
          ),
        );
      },
    );
  }
}
