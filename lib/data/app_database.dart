import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/models/task.dart';

///Work with SQLite database.
///
///Contains methods for manipulating data.
class AppDatabase {
  static const String _tableName = "tasks";

  ///Global instance of this class.
  static final AppDatabase instance = AppDatabase._init();

  static Database? _database;

  ///Connection with our database.
  Future<Database> get database async {
    if (_database != null) return _database as Database;

    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'test.db');

    _database = await openDatabase(path, version: 1, onCreate: _createDB);

    return _database as Database;
  }

  ///Private constructor.
  AppDatabase._init();

  Future _createDB(Database db, int _) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const boolType = 'BOOLEAN NOT NULL';

    await db.execute(
      '''
CREATE TABLE $_tableName ( 
  ${TaskFields.id} $idType, 
  ${TaskFields.title} $textType,
  ${TaskFields.description} $textType,
  ${TaskFields.isDone} $boolType,
  ${TaskFields.group} $textType
  )
''',
    );
  }

  ///Inserts a [Task] object to DB.
  Future<Task> create(Task task) async {
    final db = await instance.database;

    final id = await db.insert(_tableName, task.toMap());

    return task.copy(id: id); //TODO исправить на сеттер для поля айди
  }

  ///Method returns a single [Task] object from [Database] by its ID.
  Future<Task> readTask(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      _tableName,
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

  ///Method returns all [Task] objects from [Database].
  Future<List<Task>> readAllTasks() async {
    final db = await instance.database;

    final result = await db.query(_tableName);

    return result.map((data) => Task.fromMap(data)).toList();
  }

  ///Updates a [Task] object by its id.
  Future<int> update(Task task) async {
    final db = await instance.database;

    return db.update(
      _tableName,
      task.toMap(),
      where: '${TaskFields.id} = ?',
      whereArgs: [task.id],
    );
  }

  ///Method deletes [Task] object by its id.
  Future<int> delete(int id) async {
    final db = await instance.database;

    return db.delete(
      _tableName,
      where: '${TaskFields.id} = ?',
      whereArgs: [id],
    );
  }

  ///Method which closes DB.
  Future close() async {
    final db = await instance.database;

    await db.close();
  }
}
