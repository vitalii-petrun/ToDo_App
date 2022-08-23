import 'package:todo_app/data/database_helper.dart';
import 'package:todo_app/models/Group.dart';

///Group Table Helper.
class GroupDatabaseHelper {
  ///Instance of GroupDatabaseHelper.
  static final GroupDatabaseHelper instance = GroupDatabaseHelper._init();
  GroupDatabaseHelper._init();

  ///Inserts a [Group] object to DB.
  Future<Group> create(Group group) async {
    final db = await DatabaseHelper.instance.database;

    final id = await db.insert(groupTableName, group.toMap());

    return group.copy(id: id); //TODO исправить на сеттер для поля айди
  }

  ///Method returns a single [Group] object from Database by its ID.
  Future<Group> read(int id) async {
    final db = await DatabaseHelper.instance.database;

    final maps = await db.query(
      groupTableName,
      columns: GroupFields.values,
      where: '${GroupFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Group.fromMap(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  ///Method returns all [Group] objects from Database.
  Future<List<Group>> readAll() async {
    final db = await DatabaseHelper.instance.database;

    final result = await db.query(groupTableName);

    return result.map((data) => Group.fromMap(data)).toList();
  }

  ///Updates a [Group] object by its id.
  Future<int> update(Group group) async {
    final db = await DatabaseHelper.instance.database;

    return db.update(
      groupTableName,
      group.toMap(),
      where: '${GroupFields.id} = ?',
      whereArgs: [group.id],
    );
  }

  ///Method deletes [Group] object by its id.
  Future<int> delete(int id) async {
    final db = await DatabaseHelper.instance.database;

    return db.delete(
      groupTableName,
      where: '${GroupFields.id} = ?',
      whereArgs: [id],
    );
  }
}
