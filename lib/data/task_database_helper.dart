import 'package:todo_app/data/database_helper.dart';
import 'package:todo_app/models/task.dart';

///Task Table Helper.
class TaskDatabaseHelper {
  ///Instance of GroupDatabaseHelper.
  static final TaskDatabaseHelper instance = TaskDatabaseHelper._init();
  TaskDatabaseHelper._init();

  ///Inserts a [Task] object to DB.
  Future create(Task task) async {
    final db = await DatabaseHelper.instance.database;

    await db.insert(taskTableName, task.toMap());
  }

  ///Method returns a single [Task] object from Database by its ID.
  Future<Task> read(int id) async {
    final db = await DatabaseHelper.instance.database;

    final maps = await db.query(
      taskTableName,
      columns: TaskFields.values,
      where: '${TaskFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Task.fromMap(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  ///Method returns all [Task] objects from Database.
  Future<List<Task>> readAll() async {
    final db = await DatabaseHelper.instance.database;

    final result = await db.query(taskTableName);

    return result.map((data) => Task.fromMap(data)).toList();
  }

  ///Updates a [Task] object by its id.
  Future<int> update(Task task) async {
    final db = await DatabaseHelper.instance.database;

    return db.update(
      taskTableName,
      task.toMap(),
      where: '${TaskFields.id} = ?',
      whereArgs: [task.id],
    );
  }

  ///Method deletes [Task] object by its id.
  Future<int> delete(int id) async {
    final db = await DatabaseHelper.instance.database;

    return db.delete(
      taskTableName,
      where: '${TaskFields.id} = ?',
      whereArgs: [id],
    );
  }
}
