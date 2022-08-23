import 'package:flutter/material.dart';
import 'package:todo_app/data/Group_database_helper.dart';
import 'package:todo_app/models/Group.dart';

///Refreshes the screen when changes occur.
class GroupProvider extends ChangeNotifier {
  List<Group> _items = [];

  ///Getter for _items field.
  List<Group> get items => [..._items];

  ///Reads all groups from table.
  Future<void> fetchAndSet() async {
    _items = await GroupDatabaseHelper.instance.readAll();
    notifyListeners();
  }

  ///Inserts new group to DB and to items list.
  Future add(Group group) async {
    _items.insert(0, group);
    notifyListeners();
    await GroupDatabaseHelper.instance.create(group);
  }

  ///Updates group in DB and a list.
  Future update(Group group) async {
    final index = _items.indexWhere((e) => e.id == group.id);

    if (index != -1) {
      _items[index] = group;
      notifyListeners();
      await GroupDatabaseHelper.instance.update(group);
    }
  }

  ///Deletes group by its id.
  Future delete(int id) async {
    _items.removeWhere((e) => e.id == id);
    notifyListeners();
    await GroupDatabaseHelper.instance.delete(id);
  }
}
