import 'package:flutter/material.dart';
import 'package:todo_app/data/group_database_helper.dart';
import 'package:todo_app/models/group.dart';

///Refreshes the screen when changes occur.
class GroupProvider extends ChangeNotifier {
  List<Group> _items = [];
  int _choosenTabIndex = 0;

  ///Setter for _choosenTabIndex field.
  set tabIndex(int newIndex) {
    _choosenTabIndex = newIndex;

    notifyListeners();
  }

  ///Setter for _choosenTabIndex which can be called in didUpdateWidget().
  ///
  ///It doesn't call setState while second setter does.
  set tabIndexAfterRebuild(int newIndex) {
    _choosenTabIndex = newIndex;
  }

  ///Getter for _choosenTabIndex field.
  int get tabIndex => _choosenTabIndex;

  ///List of groups.
  List<Group> get items => [..._items];

  ///Reads all groups from table.
  Future<void> fetchAndSet() async {
    _items = await GroupDatabaseHelper.instance.readAll();

    notifyListeners();
  }

  ///Inserts new group to DB and to items list.
  Future add(Group group) async {
    _items.insert(_items.length, group);

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
