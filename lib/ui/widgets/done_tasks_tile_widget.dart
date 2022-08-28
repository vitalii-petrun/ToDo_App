import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/group.dart';
import 'package:todo_app/providers/group_provider.dart';
import 'package:todo_app/providers/task_provider.dart';
import 'package:todo_app/ui/widgets/task_list_widget.dart';

///Widget which shows list of done tasks.
class DoneTasksTileWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final taskProvider = context.read<TaskProvider>();
    final groupProvider = context.read<GroupProvider>();
    final Group _choosenGroup = groupProvider.items[groupProvider.tabIndex];
    final int doneTasksLengthByGroup = taskProvider
        .itemsByGroup(_choosenGroup.title)
        .where((task) => task.isDone)
        .length;

    return Consumer<TaskProvider>(
      builder: (context, tasks, child) {
        return doneTasksLengthByGroup > 0
            ? ExpansionTile(
                textColor: Theme.of(context).primaryColorDark,
                title: Text("Done tasks ($doneTasksLengthByGroup)"),
                children: [
                  TaskListWidget(
                    tasks: tasks
                        .itemsByGroup(_choosenGroup.title)
                        .where((task) => task.isDone)
                        .toList(),
                  )
                ],
              )
            : const SizedBox();
      },
    );
  }
}
