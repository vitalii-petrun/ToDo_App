import 'package:flutter/material.dart';
import 'package:todo_app/data/task_database_helper.dart';
import 'package:todo_app/models/task.dart';

///Provider which holds list of tasks from DB.
class TaskProvider extends ChangeNotifier {
  List<Task> _items = [];

  ///Getter for _items field.
  List<Task> get items => [..._items];

  ///Returns tasks by group.
  List<Task> itemsByGroup(String groupName) =>
      _items.where((task) => task.taskGroup == groupName).toList();

  ///Reads all tasks from table.
  Future<void> fetchAndSet() async {
    _items = await TaskDatabaseHelper.instance.readAll();
    notifyListeners();
  }

  ///Inserts new task to DB and to items list.
  Future add(Task task) async {
    Task temp; //temporary variable to receive task with id from create() method
    temp = await TaskDatabaseHelper.instance.create(task);
    _items.insert(0, temp);
    notifyListeners();
  }

  ///Updates task in DB and a list.
  Future update(Task task) async {
    final index = _items.indexWhere((e) => e.id == task.id);
    if (index != -1) {
      _items[index] = task;
      notifyListeners();
      await TaskDatabaseHelper.instance.update(task);
    }
  }

  ///Changes isDone status.
  Future changeStatus(Task task) async {
    final index = _items.indexWhere((task) => task.id == task.id);
    if (index != -1) {
      task.isDone = !task.isDone;
      await TaskDatabaseHelper.instance.update(task);
      notifyListeners();
    }
  }

  ///Deletes task by its id.
  Future delete(int id) async {
    _items.removeWhere((e) => e.id == id);
    notifyListeners();
    await TaskDatabaseHelper.instance.delete(id);
  }
}
