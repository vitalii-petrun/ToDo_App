import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/providers/group_provider.dart';
import 'package:todo_app/providers/task_provider.dart';

///Form to create new task.
class AddTaskWidget extends StatefulWidget {
//TODO объяснить поподробнее
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
    final groupProvider = Provider.of<GroupProvider>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            TextFormField(
              autofocus: true,
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
                hintStyle: TextStyle(fontSize: 15),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Provider.of<TaskProvider>(context, listen: false).add(
                    Task(
                      title: titleBuff,
                      description: descrBuff,
                      taskGroup:
                          groupProvider.items[groupProvider.tabIndex].title,
                    ),
                  );
                },
                child: const Text("Save"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
