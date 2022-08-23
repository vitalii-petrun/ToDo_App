import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/providers/task_provider.dart';

///Form to create new task.
class AddTaskWidget extends StatefulWidget {
  ///Makes possible to create constant widget.
  const AddTaskWidget({Key? key}) : super(key: key);

  @override
  State<AddTaskWidget> createState() => _AddTaskWidgetState();
}

class _AddTaskWidgetState extends State<AddTaskWidget> {
  final _titleCtrl = TextEditingController();
  final _descriptionCtrl = TextEditingController();

  String titleBuff = "";
  String descrBuff = "";
  @override
  void initState() {
    _titleCtrl.addListener(() {
      titleBuff = _titleCtrl.text;
    });
    _descriptionCtrl.addListener(() {
      descrBuff = _descriptionCtrl.text;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextFormField(
            controller: _titleCtrl,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: "New task",
            ),
          ),
          TextFormField(
            controller: _descriptionCtrl,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: "Additional info",
            ),
          ),
          TextButton(
            onPressed: () {
              Provider.of<TaskProvider>(context, listen: false).add(
                Task(
                  title: titleBuff,
                  description: descrBuff,
                  taskGroup: "Fiorentino",
                ),
              );
            },
            child: const Text("Save"),
          )
        ],
      ),
    );
  }
}
