import 'package:flutter/material.dart';
import 'package:todo_app/data/group_database_helper.dart';
import 'package:todo_app/models/group.dart';

///Refreshes the screen when changes occur.
class GroupProvider extends ChangeNotifier {
  List<Group> _items = [];
  int _choosenTabID = 0;
  set tabIndex(int newIndex) {
    _choosenTabID = newIndex;
    notifyListeners();
  }

  int get tabIndex => _choosenTabID;

  ///List of groups.
  List<Group> get items => [..._items]; //TODO что за оператор?

  ///Reads all groups from table.
  Future<void> fetchAndSet() async {
    _items = await GroupDatabaseHelper.instance.readAll();
    notifyListeners();
  }

  ///Inserts new group to DB and to items list.
  Future add(Group group) async {
    Group temp;

    temp = await GroupDatabaseHelper.instance.create(group);
    _items.insert(_items.length, temp);
    notifyListeners();
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
    print(" deleted from _items");
    notifyListeners();
    await GroupDatabaseHelper.instance.delete(id);
  }
}
