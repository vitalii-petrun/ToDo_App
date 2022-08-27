import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/providers/task_provider.dart';

///Screen which opens when user select edit on sliding task/todo item
class TaskScreen extends StatefulWidget {
  //Task
  ///Task which details will be displayed.
  final Task task;

  ///Constructor receives Task oblect.
  const TaskScreen({Key? key, required this.task}) : super(key: key);

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final _descrFieldFlexValue = 6;
  final _descrFieldMaxLines = 10;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
          color: Colors.black,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Provider.of<TaskProvider>(context, listen: false)
                  .delete(widget.task.id);
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.delete,
              color: Colors.grey,
            ),
          ),
        ],
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: TextFormField(
                style: const TextStyle(fontSize: 20),
                onChanged: (value) {
                  widget.task.title = value;
                  Provider.of<TaskProvider>(context, listen: false)
                      .update(widget.task);
                },
                initialValue: widget.task.title,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Task's title",
                ),
              ),
            ),
            Row(
              children: [
                const Expanded(child: Icon(Icons.notes)),
                Expanded(
                  flex: _descrFieldFlexValue,
                  child: TextFormField(
                    minLines: 1,
                    maxLines: _descrFieldMaxLines,
                    keyboardType: TextInputType.multiline,
                    onChanged: (value) {
                      widget.task.description = value;
                    },
                    initialValue: widget.task.description,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Add additional info",
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Chip(
                  label: Text(widget.task.isDone ? "Done" : "Not done"),
                  backgroundColor:
                      widget.task.isDone ? Colors.lime : Colors.redAccent,
                ),
                const SizedBox(
                  width: 5,
                ),
                Chip(label: Text(widget.task.taskGroup ?? ""))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
