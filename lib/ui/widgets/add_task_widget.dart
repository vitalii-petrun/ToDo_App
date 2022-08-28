import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/providers/group_provider.dart';
import 'package:todo_app/providers/task_provider.dart';

///Form to create new task.
class AddTaskWidget extends StatefulWidget {
  ///Create constant widget.
  const AddTaskWidget({Key? key}) : super(key: key);

  @override
  State<AddTaskWidget> createState() => _AddTaskWidgetState();
}

class _AddTaskWidgetState extends State<AddTaskWidget> {
  final _titleCtrl = TextEditingController();
  final _descriptionCtrl = TextEditingController();

  String titleBuff = "";
  String descrBuff = "";

  //Toggle for "Additional info" field.
  bool _isActivated = false;
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
    final groupProvider = context.read<GroupProvider>();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            TextFormField(
              onFieldSubmitted: (title) {
                if (!_isActivated) {
                  context.read<TaskProvider>().add(
                        Task(
                          id: DateTime.now().millisecondsSinceEpoch,
                          title: title,
                          description: descrBuff,
                          taskGroup:
                              groupProvider.items[groupProvider.tabIndex].title,
                        ),
                      );
                  Navigator.pop(context);
                }
              },
              autofocus: true,
              controller: _titleCtrl,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "New task",
              ),
            ),
            if (_isActivated)
              TextFormField(
                onFieldSubmitted: (description) {
                  context.read<TaskProvider>().add(
                        Task(
                          id: DateTime.now().millisecondsSinceEpoch,
                          title: titleBuff,
                          description: description,
                          taskGroup:
                              groupProvider.items[groupProvider.tabIndex].title,
                        ),
                      );
                  Navigator.pop(context);
                },
                controller: _descriptionCtrl,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Additional info",
                  hintStyle: TextStyle(fontSize: 15),
                ),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      _isActivated = true;
                    });
                  },
                  icon: Icon(
                    Icons.notes,
                    color: Theme.of(context).primaryColorDark,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    context.read<TaskProvider>().add(
                          Task(
                            id: DateTime.now().millisecondsSinceEpoch,
                            title: titleBuff,
                            description: descrBuff,
                            taskGroup: groupProvider
                                .items[groupProvider.tabIndex].title,
                          ),
                        );
                  },
                  child: Text(
                    "Save",
                    style: TextStyle(
                      color: Theme.of(context).primaryColorDark,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
